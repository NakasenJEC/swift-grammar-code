# 付録D 命名規則

プログラミングにおける名前付けは、言ってみれば「タイトル」のようなものです。映画のタイトルが分かりやすいほど内容が想像しやすいのと同じように、プログラムの名前もその意味が分かるほど読みやすくなります。プログラムは長くなるほど、適切な名前付けが重要になります。

この付録は、昨年度のテキスト第4回「命名規則」の文章を元にしています。

## キャメルケース

キャメルケースは、単語を連結して書くときに、ラクダのコブのように単語ごとに大文字と小文字を使い分ける書き方です。

### ローワーキャメルケース

最初の単語は小文字、2つ目以降の単語の頭文字を大文字にします。変数、定数、関数、プロパティ、メソッドに使います。

```swift
let studentName = "電子太郎"
var totalPrice = 0
func calculateTax(price: Int) -> Int { price / 10 }
```

### アッパーキャメルケース

すべての単語の頭文字を大文字にします。型（構造体、クラス、列挙型、プロトコル）の名前に使います。

```swift
struct ShoppingItem { }
class BankAccount { }
enum PaymentMethod { case cash, creditCard }
protocol Drawable { }
```

## 略語はどうするか

名前に `ID` や `HTTP` のような略語を含む場合はどうするか迷います。Swift では、略語が名前の途中にある場合はすべて大文字、先頭にある場合はすべて小文字にします。

| 元の言葉 | 名前 | 理由 |
|------|------|------|
| Student ID Number | `studentIDNumber` | `ID` は途中にあるので全部大文字 |
| UTF8 Byte | `utf8Byte` | `UTF` は先頭にあるので全部小文字 |
| HTTP Request | `httpRequest` | `HTTP` は先頭にあるので全部小文字 |
| Target URL | `targetURL` | `URL` は途中にあるので全部大文字 |

## 関数名の基本ルール

関数は何か「動作」するので、名前に動詞を使います。具体的な動作内容が分かる名前にします。

```swift
// 分かりにくい例
func press() { }            // 何を押すのか分からない
func data() -> [Int] { [] }  // 動詞が無い

// 分かりやすい例
func pressButton(at index: Int) { }
func loadScores() -> [Int] { [] }
```

## 引数ラベルで読みやすくする

Swift の関数には、呼び出すときに見える引数ラベルがあります。呼び出しが英語の文として読めるように付けます。

```swift
func move(from start: Int, to end: Int) { }
move(from: 1, to: 5)   // 「1 から 5 へ move する」と読める
```

`move(start:end:)` より `move(from:to:)` の方が、呼び出しを読んだときに意味が伝わります。

## 名前は「型」ではなく「役割」を表す

```swift
let array = [90, 75, 60]          // 何の配列か分からない
let scores = [90, 75, 60]         // 点数の配列だと分かる

let str = "2026-09-25"            // 何の文字列か分からない
let startDate = "2026-09-25"      // 開始日だと分かる
```

## 英語が苦手でも、流暢なフレーズを目指す

完璧な英語である必要はありません。ただし、`hoge`、`foo`、`tmp`、`data1` のような、意味の無い名前は使いません。この本と教材コードでも使いません。

単語に迷ったら、次のものが役に立ちます。

- Apple の [API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)（英語）。Swift の標準ライブラリの名前付けの考え方
- 変数名を英語にしてくれる Web サービス（例：codic）
- 生成AIに「Swift で、買い物リストの品名を表す定数の名前を3つ提案して」と聞く

## まとめ

| 対象 | 書き方 | 例 |
|------|------|------|
| 変数、定数、関数、プロパティ、メソッド | ローワーキャメルケース | `totalPrice`、`addItem(_:)` |
| 型（構造体、クラス、列挙型、プロトコル） | アッパーキャメルケース | `ShoppingItem`、`Drawable` |
| 列挙型のケース | ローワーキャメルケース | `case creditCard` |
| 略語 | 途中は大文字、先頭は小文字 | `userID`、`urlString` |
| 関数 | 動詞から始める | `loadScores()`、`pressButton(at:)` |
| 引数ラベル | 呼び出しが文として読めるように | `move(from:to:)` |
