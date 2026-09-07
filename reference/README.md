# Swift 文法リファレンス 2026（Java 経験者のための）

Swift（1年生・後期）の授業で扱う範囲を、Java を学んでいる人向けに、実行できる例付きで引ける本です。授業が進むごとに章が増えます。学期末に全章を PDF にして配ります。

## 目次

| 章 | 内容 | ファイル名（予定） | 公開 |
|---|------|------|------|
| [00 はじめに](00_intro.md) | この本の範囲と読み方 | `00_intro.md` | 公開済み |
| 01 型と制御構文・コレクション | `let`/`var`、基本の型、`if`/`switch`/`for`、配列・辞書・範囲 | `01_basics.md` | 11/5 |
| 02 Optional | `nil`、`?`、`if let`/`guard let`、`??`、`!` | `02_optional.md` | 11/12 |
| 03 関数とタプル | 引数ラベル、既定値、`inout`、可変長引数、タプル | `03_functions.md` | 11/19 |
| 04 構造体とプロパティ | `struct`、イニシャライザ、計算プロパティ、`didSet`、`mutating`、`extension` | `04_structs.md` | 11/26 |
| 05 列挙型と switch | `enum`、raw value、associated value、`CaseIterable`、パターンマッチ | `05_enums.md` | 12/3 |
| 06 クラスと継承 | `class`、継承、`override`、`deinit`、値型と参照型 | `06_classes.md` | 12/10 |
| 07 クロージャと高階関数 | クロージャ式、省略記法、キャプチャ、`map`/`filter`/`reduce`/`sorted` | `07_closures.md` | 12/17 |
| 08 プロトコルと extension | `protocol`、準拠、既定実装、`Equatable`/`Hashable`/`Codable` | `08_protocols.md` | 1/7 |
| 09 エラー処理とジェネリクス | `throws`/`try`/`do-catch`、`Result`、ジェネリック関数と型制約 | `09_errors_generics.md` | 1/14 |
| 10 総合演習 | 買い物メモアプリを読む・直す・広げる。`async`/`await` と `#Preview` の読み方 | `10_capstone.md` | 1/21 |
| [付録A 言語対応表](appendix_A_languages.md) | 概念ごとの Java・Kotlin・TypeScript・Go・Rust との対応 | `appendix_A_languages.md` | 骨格を公開済み。各章と一緒に埋まります |
| 付録B Swift 6 で変わったこと | 言語モード、`static var`、既定の MainActor、`if` 式、型付き throws | `appendix_B_swift6.md` | 1/21 |
| 付録C 用語集 | この本で使う用語の短い定義 | `appendix_C_glossary.md` | 1/29 |
| [付録D 命名規則](appendix_D_naming.md) | キャメルケース、略語、関数名、引数ラベル | `appendix_D_naming.md` | 公開済み |
| 付録E 詳解Swift 第5版との対応 | 各章がどの節に対応するか | `appendix_E_shokai_swift.md` | 1/29 |

## 使い方

- 授業の前に、その週の章の「この章で分かること」と「概念と Java との対応」だけ読んでおくと、月曜の導入が楽になります
- 章の中のコードは、その週の教材コード（`weekNN/main.swift`）と同じものです。貼って実行できます
- 各章の最後に「確認テストで問われること」があります。月曜の確認テストと期末の出題範囲はここに書いてあります
- 網羅的な文法書ではありません。載っていないことは、swift.org が掲載している日本語訳（[swiftlangjp.com](https://www.swiftlangjp.com)）か、書籍『詳解 Swift 第5版』（荻原剛志、SBクリエイティブ、2019）を引いてください

## 更新履歴

| 日付 | 内容 |
|------|------|
| 2026-09-06 | 骨格を作成（00、付録A、付録D） |
