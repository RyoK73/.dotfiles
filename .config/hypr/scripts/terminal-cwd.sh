#!/bin/bash
# omarchy-cmd-terminal-cwd の代替。
#
# kitty 0.47系で追加された `kitten __watch_conf__` ヘルパープロセスが
# 子プロセス一覧の末尾(最大PID)に来るため、tail -n1 で選ぶ元の実装が
# シェルではなくこのヘルパーを誤検出し常に $HOME を返してしまう。
# ここでは子プロセスの中から /etc/shells に載っている実行ファイルを
# 明示的に探すことで回避する。

terminal_pid=$(hyprctl activewindow | awk '/pid:/ {print $2}')

cwd="$HOME"

if [[ -n $terminal_pid ]]; then
  for pid in $(pgrep -P "$terminal_pid"); do
    shell=$(readlink -f "/proc/$pid/exe" 2>/dev/null)
    if grep -qs "^$shell$" /etc/shells; then
      candidate=$(readlink -f "/proc/$pid/cwd" 2>/dev/null)
      if [[ -d $candidate ]]; then
        cwd="$candidate"
      fi
      break
    fi
  done
fi

echo "$cwd"
