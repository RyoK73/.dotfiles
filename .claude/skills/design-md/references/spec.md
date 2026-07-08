# DESIGN.md 公式仕様リファレンス

出典: https://github.com/google-labs-code/design.md `docs/spec.md` (Apache-2.0, Google Labs, version: alpha)

DESIGN.mdは「YAML frontmatter（機械可読トークン）」＋「Markdown本文（人間可読の説明・根拠）」の2部構成。トークンが正とし、本文はその適用文脈を説明する。

## 1. YAML frontmatter スキーマ

```yaml
version: <string>          # 任意, 現在 "alpha"
name: <string>              # 必須
description: <string>       # 任意
colors:
  <token-name>: <Color>
typography:
  <token-name>: <Typography>
rounded:
  <scale-level>: <Dimension>
spacing:
  <scale-level>: <Dimension | number>
components:
  <component-name>:
    <token-name>: <string|token reference>
```

- `<scale-level>` は `xs`/`sm`/`md`/`lg`/`xl`/`full` 等の任意の文字列キー。
- **Color**: 有効なCSSカラー文字列。Hex(`#RGB`/`#RRGGBB`/`#RRGGBBAA`)、named color、`rgb()`/`hsl()`/`hwb()`、`oklch()`/`oklab()`/`lch()`/`lab()`、`color-mix()`。WCAGコントラスト判定のため内部的にsRGBへ変換される。**Hexが推奨デフォルト**。
- **Typography**: `fontFamily`(string) / `fontSize`(Dimension) / `fontWeight`(number, 例400・700) / `lineHeight`(Dimension | 単位なし数値。単位なしはfontSizeへの乗数、CSS慣行として推奨) / `letterSpacing`(Dimension) / `fontFeature`(string, font-feature-settings) / `fontVariation`(string, font-variation-settings)。
- **Dimension**: 単位付き文字列。有効単位は `px` / `em` / `rem` のみ。
- **Token Reference**: `{path.to.token}` 形式でYAMLツリー内の他の値を参照。基本はプリミティブ値を指す（`colors.primary-60`など、グループ自体は不可）。ただし`components`セクション内では複合値（`{typography.label-md}`）への参照も許可。

### colors
`map<string, Color>`。**少なくとも `primary` は必須**。複数パレットがある場合、`primary`/`secondary`/`tertiary`/`neutral` の順で命名するのが一般的な慣習。

### typography
`map<string, Typography>`。多くのデザインシステムは9〜15段階のtypography levelを持つ。`headline`/`display`/`body`/`label`/`caption`等の意味カテゴリ×サイズ(`small`/`medium`/`large`)で命名するのが一般的。

### rounded
`map<string, Dimension>`。ボタン・カード等の角丸トークン。

### spacing
`map<string, Dimension | number>`。スペーシングスケール識別子→寸法値、またはカラム数等の単位なし数値。

### components
`map<string, map<string, string>>`。コンポーネント識別子→サブトークン群。値はリテラルまたは他トークンへの参照。

**コンポーネントプロパティトークン一覧**: `backgroundColor`(Color) / `textColor`(Color) / `typography`(Typography) / `rounded`(Dimension) / `padding`(Dimension) / `size`(Dimension) / `height`(Dimension) / `width`(Dimension)

**バリアント**: 状態違い（active/hover/pressed等）は別キーとして定義する。例: `button-primary`, `button-primary-hover`, `button-primary-active`。

```yaml
components:
  button-primary:
    backgroundColor: "{colors.primary-60}"
    textColor: "{colors.primary-20}"
    rounded: "{rounded.md}"
    padding: 12px
  button-primary-hover:
    backgroundColor: "{colors.primary-70}"
```

## 2. Markdown本文セクション

`##`（h2）見出しのみがセクションとしてパースされる。任意で`#`(h1)をドキュメントタイトルに使えるが、セクションとしては扱われない。**セクションは省略可能だが、存在するものは下記の順序で並べること**。

| # | セクション名 | 別名 |
|---|---|---|
| 1 | Overview | Brand & Style |
| 2 | Colors | — |
| 3 | Typography | — |
| 4 | Layout | Layout & Spacing |
| 5 | Elevation & Depth | Elevation |
| 6 | Shapes | — |
| 7 | Components | — |
| 8 | Do's and Don'ts | — |

### Overview（Brand & Style）
製品の見た目・感触の総合説明。ブランドパーソナリティ、対象ユーザー、UIが喚起すべき感情（プレイフル/プロフェッショナル、密/疎 等）を記述。個別トークンが未定義な場面でエージェントの高レベルな判断基準として機能する。

### Colors
主要カラーパレットの説明。少なくとも`primary`を含む。複数パレットがあれば各々の役割（例: primary=見出し・本文、secondary=境界線・注釈、tertiary=インタラクション専用、neutral=背景）を記述する。

### Typography
フォント戦略。使用フォントファミリーと、見出し/本文/ラベル等各レベルの役割・ウェイト・使いどころを記述。

### Layout（Layout & Spacing）
グリッドモデル（Fluid/Fixed-Max-Width等）とスペーシングスケール（基準単位、コンテナ内パディング等）を記述。

### Elevation & Depth（Elevation）
視覚的階層の作り方。シャドウを使うか、あるいはトーナルレイヤーや境界線・コントラストなどの代替手段かを記述。

### Shapes
角丸・コーナー処理の方針（最小半径・一貫性ルール）を記述。

### Components
ボタン・チップ・リスト・ツールチップ・チェックボックス・ラジオボタン・入力欄等、共通コンポーネントのスタイル指針。各状態（hover/active/error等）を含む。ドメイン固有のコンポーネント追加も推奨される。

### Do's and Don'ts
実践的なガイドラインと落とし穴。例:
```markdown
## Do's and Don'ts

- Do use the primary color only for the single most important action per screen
- Don't mix rounded and sharp corners in the same view
- Do maintain WCAG AA contrast ratios (4.5:1 for normal text)
- Don't use more than two font weights on a single screen
```

## 3. 推奨トークン名（非規範的）

- **Colors**: `primary`, `secondary`, `tertiary`, `neutral`, `surface`, `on-surface`, `error`
- **Typography**: `headline-display`, `headline-lg`, `headline-md`, `body-lg`, `body-md`, `body-sm`, `label-lg`, `label-md`, `label-sm`
- **Rounded**: `none`, `sm`, `md`, `lg`, `xl`, `full`

## 4. 未知コンテンツの扱い

| ケース | 挙動 |
|---|---|
| 未知のセクション見出し | そのまま保持。エラーにしない（例: `## Iconography`） |
| 未知のcolorトークン名 | 値が有効なら受理 |
| 未知のtypographyトークン名 | 受理 |
| 未知のspacing値 | 受理。有効なDimensionでなければ文字列として保持 |
| 未知のcomponentプロパティ | 警告付きで受理 |
| セクション見出しの重複 | エラー。ファイルを拒否（例: `## Colors`が2つ） |
