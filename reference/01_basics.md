# 01 型と制御構文の再確認、配列・辞書・範囲

## この章で分かること

- `let` と `var` の違いと、Swift では `let` が基本であること
- 型注釈と型推論の関係、そして Swift には暗黙の型変換が無いこと
- 配列と辞書の作り方、要素の取り出し方、よく使うメソッド
- 範囲演算子 `..<` と `...`、`for-in`、`for-in where`、`break` と `continue`
- `if` と `switch` の書き方。Swift の `switch` に `break` が要らない理由と、網羅していないとエラーになること

この章の教材コードは [week01/main.swift](../week01/main.swift) です。題材は 1CM1 の成績（Swift の点数）で、単元5までこの題材が続きます。

## 概念と Java との対応

| 概念 | Java | Swift |
|------|------|------|
| 定数 | `final int n = 5;` | `let n = 5` |
| 変数 | `int n = 5;` | `var n = 5` |
| 型推論 | `var n = 5;`（Java 10 以降） | `let n = 5` |
| 型注釈 | `int n = 5;` | `let n: Int = 5` |
| 配列 | `int[] a = {1, 2};`／`List<Integer>` | `let a = [1, 2]` |
| 要素数 | `a.length`／`a.size()` | `a.count` |
| 連想配列 | `Map<String, Integer> m` | `let m: [String: Int]` |
| 添字の繰り返し | `for (int i = 0; i < n; i++)` | `for i in 0..<n` |
| 拡張 for | `for (int x : a)` | `for x in a` |
| 条件付きの繰り返し | `for` の中に `if` | `for x in a where 条件` |
| 多分岐 | `switch (x) { case 1: ... break; }` | `switch x { case 1: ... }` |
| `switch` の `break` | 書かないと次の case に落ちる | 書かない。落ちない |
| `switch` の網羅性 | 網羅していなくてもよい | 網羅していないとコンパイルエラー |
| 暗黙の型変換 | `int` から `double` は自動 | 自動変換は無い。`Double(n)` と書く |

Java との一番大きな違いは最後の3つです。`switch` の `break` を書き忘れて次の case に落ちるバグは Swift では起きません。代わりに、全部のケースを書くか `default` を置くかしないとコンパイルが通りません。型変換も同じ考え方で、自動でやってくれない代わりに、変換したところがコードに残ります。

## 文法の説明と実行できる例

### let と var

`let` は一度決めたら変えられない定数、`var` は変えられる変数です。Swift では `let` が基本で、変える必要があるときだけ `var` にします。

```swift
let className = "1CM1"
var updateCount = 1
updateCount += 1
print("\(className) の成績表は \(updateCount) 回目の更新です")
```

`"\(...)"` は文字列補間です。Java の `String.format` や `+` による連結にあたります。

`let` に代入し直すとコンパイルエラーになります。

```swift
let className = "1CM1"
// className = "1CM2"   // error: cannot assign to value: 'className' is a 'let' constant
print(className)
```

### 型注釈と型推論

型は書いても書かなくてもかまいません。書かない場合は、右辺の値から型が決まります。これを型推論といいます。

```swift
let passingScore: Int = 60   // 型注釈あり
let targetAverage = 75.5     // 型推論。Double になる
print(type(of: passingScore), type(of: targetAverage))
```

`type(of:)` はその値の型を返します。自分の予想と合っているか確かめるときに使ってください。

型を書いた方がよいのは、推論される型と違う型にしたいときです。

```swift
let count = 5           // Int
let ratio: Double = 5   // Double。書かないと Int になる
print(count, ratio)
```

### 型の変換は自分で書く

Swift には暗黙の型変換がありません。`Int` と `Double` はそのままでは足せません。

```swift
let passingScore: Int = 60
let targetAverage = 75.5
// print(passingScore + targetAverage)
// error: binary operator '+' cannot be applied to operands of type 'Int' and 'Double'
print("目標平均との差: \(targetAverage - Double(passingScore))")
```

`Double(passingScore)` のように、変換したい型の名前を関数のように書きます。Java の `(double) passingScore` にあたる書き方です。

割り算では特に注意が必要です。`Int` どうしの割り算は小数点以下が消えます。

```swift
let total = 360
let count = 7
print(total / count)                        // 51
print(Double(total) / Double(count))        // 51.42857142857143
```

### 配列

配列は `[要素の型]` と書きます。要素は同じ型でそろえます。

```swift
let names = ["電子太郎", "電子花子", "山田一郎", "佐藤みなみ", "グエン・アン"]
let scores = [82, 55, 91, 60, 72]

print("在籍 \(names.count) 名、点数 \(scores.count) 個")
print("先頭の人: \(names[0]) \(scores[0]) 点")
```

添字は 0 から始まります。`names[0]` が1番目です。

空の配列を作るときは、型を書かないと決まりません。

```swift
var passers: [String] = []
passers.append("電子太郎")
print(passers)
```

よく使うメソッドをまとめます。

| したいこと | 書き方 | 配列を変えるか |
|------|------|:--:|
| 末尾に足す | `a.append(x)` | 変える |
| 位置を指定して消す | `a.remove(at: 0)` | 変える |
| 末尾を消す | `a.removeLast()` | 変える |
| 全部消す | `a.removeAll()` | 変える |
| 並べ替える | `a.sort()` | 変える |
| 並べ替えた配列を得る | `a.sorted()` | 変えない |
| 含まれているか | `a.contains(x)` | 変えない |
| 条件に合うものだけ | `a.filter { ... }` | 変えない |
| 全部を変換する | `a.map { ... }` | 変えない |

### 破壊的なメソッドと非破壊的なメソッド

上の表の右の列が、この単元でいちばん間違えやすいところです。`sorted()` は並べ替えた新しい配列を返すだけで、もとの配列は変わりません。`sort()` はもとの配列そのものを並べ替えます。

```swift
let scores = [82, 55, 91, 60, 72]

let ranking = scores.sorted(by: >)
print("sorted(by:) が返した配列: \(ranking)")   // [91, 82, 72, 60, 55]
print("もとの scores: \(scores)")               // [82, 55, 91, 60, 72]

var work = scores
work[1] = 65
work.sort()
print("sort() の後の work: \(work)")            // [60, 65, 72, 82, 91]
print("もとの scores: \(scores)")               // [82, 55, 91, 60, 72]
```

配列そのものを変えるメソッドは、`let` の配列には使えません。`var` が必要です。

```swift
let scores = [82, 55, 91]
// scores.append(60)
// error: cannot use mutating member on immutable value: 'scores' is a 'let' constant
print(scores)
```

`var work = scores` と書くと、`work` は `scores` のコピーになります。`work` をいくら変えても `scores` は変わりません。Java の配列やリストでは、代入すると同じ実体を指すので、片方を変えるともう片方も変わります。Swift の配列は値型なのでそうなりません。値型と参照型の違いは単元4で詳しく扱います。

### 範囲

範囲は2種類あります。

| 書き方 | 名前 | 含む値 |
|------|------|------|
| `0..<5` | 半開区間演算子 | 0, 1, 2, 3, 4 |
| `0...5` | 閉区間演算子 | 0, 1, 2, 3, 4, 5 |

配列の添字を回すときは、`count` は要素数であって最後の添字ではないので `..<` を使います。

```swift
let names = ["電子太郎", "電子花子", "山田一郎"]
for i in 0..<names.count {
    print("\(i + 1)番 \(names[i])")
}
```

### 繰り返し

`for-in` は配列や範囲の要素をひとつずつ取り出します。Java の拡張 for にあたります。

```swift
let scores = [82, 55, 91, 60, 72]
for score in scores {
    print(score)
}
```

条件に合う要素だけを回したいときは `where` を付けられます。`for` の中に `if` を書くのと同じ結果になりますが、こちらの方が短く書けます。

```swift
let scores = [82, 55, 91, 60, 72]
let passingScore = 60
for score in scores where score >= passingScore {
    print("合格点: \(score)")
}
```

`continue` はその回だけ飛ばし、`break` は繰り返し自体をやめます。

```swift
let scores = [82, 55, 91, 60, 72]
var counted = 0
for score in scores {
    if score == 60 { continue }
    if score > 90 { break }
    counted += 1
}
print("counted = \(counted)")
```

このコードの `counted` がいくつになるか、実行する前に紙に書いてみてください。答えは 2 です。82 と 55 を数えたところで 91 に当たり、`break` で抜けます。60 はそもそも `continue` で飛ばされますが、その前に `break` してしまうのでここまで来ません。

`while` と `repeat-while` もあります。Java の `do-while` が `repeat-while` という名前になっています。

```swift
var i = 5
while i > 0 {
    if i == 3 { break }
    print(i)
    i -= 1
}
```

Java の `for (int i = 0; i < n; i++)` という形の for 文は Swift にはありません。`for i in 0..<n` を使います。

### if

`if` は Java とほぼ同じですが、条件を丸括弧で囲む必要がありません。囲んでもエラーにはなりませんが、Swift では囲まないのが普通です。波括弧は1行でも省略できません。

```swift
let target = 55
let passingScore = 60
if target >= 80 {
    print("よくできました")
} else if target >= passingScore {
    print("合格です")
} else {
    print("再テストです")
}
```

条件は必ず `Bool` でなければなりません。Java のように 0 や null を条件に書くことはできません。

### switch

`switch` は Java と形は似ていますが、中身は違います。

```swift
let target = 55
let passingScore = 60
switch target {
case 90...100:
    print("評価 A")
case 80..<90:
    print("評価 B")
case passingScore..<80:
    print("評価 C")
default:
    print("評価 D")
}
```

Java との違いは3つあります。

1. `break` を書きません。ひとつの case を実行したらそこで終わりで、次の case に落ちません
2. case に範囲を書けます。`case 90...100:` のように書くと、その範囲に入るかどうかで分岐します
3. 網羅していないとコンパイルエラーになります。`Int` のように値が無限にある型では、`default` を書かないと通りません

網羅していないとどうなるかを見てください。

```swift
let score = 82
switch score {
case 90...100:
    print("A")
case 80..<90:
    print("B")
default:
    break
}
```

上の `default: break` を消すと `error: switch must be exhaustive` になります。この「網羅していないとエラー」という仕組みは、単元5の列挙型と組み合わせたときに本領を発揮します。

case をカンマで区切ると、複数の値をまとめられます。

```swift
let day = "土"
switch day {
case "土", "日":
    print("休み")
default:
    print("授業あり")
}
```

### 辞書

辞書はキーと値の組を持つ入れ物です。`[キーの型: 値の型]` と書きます。Java の `Map<K, V>` にあたります。

```swift
let scoreOf: [String: Int] = [
    "電子太郎": 82,
    "電子花子": 55,
    "山田一郎": 91,
    "佐藤みなみ": 60,
    "グエン・アン": 72,
]
print("辞書の件数: \(scoreOf.count)")
```

`for-in` で回すと、キーと値の組が取り出せます。

```swift
let scoreOf = ["電子太郎": 82, "電子花子": 55]
for (name, score) in scoreOf {
    print("\(name) \(score) 点")
}
```

このとき、取り出される順番は決まっていません。3回実行すると3回とも違う順番になることがあります。順番が必要なときは配列を使うか、キーを並べ替えてください。

```swift
let scoreOf = ["電子太郎": 82, "電子花子": 55, "山田一郎": 91]
for name in scoreOf.keys.sorted() {
    print(name)
}
```

キーを指定して値を取り出す `scoreOf["電子太郎"]` という書き方もありますが、これは `Int` ではなく `Int?`（Optional）を返します。存在しないキーを指定されたときに返す値が無いからです。ここが単元2の入り口になります。

## よくある間違い

### `let` の値を変えようとする

```text
error: cannot assign to value: 'className' is a 'let' constant
note: change 'let' to 'var' to make it mutable
```

`note:` の行に直し方が書いてあります。ただし、本当に変える必要があるのかを先に考えてください。変えなくて済むなら `let` のままにします。

### `let` の配列に `append` する

```text
error: cannot use mutating member on immutable value: 'scores' is a 'let' constant
```

`append` や `sort` のように配列そのものを変えるメソッドは、`let` の配列には使えません。「mutating member」は「中身を変えるメソッド」という意味です。

### Int と Double を足す

```text
error: binary operator '+' cannot be applied to operands of type 'Int' and 'Double'
note: overloads for '+' exist with these partially matching parameter lists: (Double, Double), (Int, Int)
```

`note:` の行が「`(Double, Double)` か `(Int, Int)` ならできる」と教えてくれています。どちらかにそろえてください。

### switch が網羅していない

```text
error: switch must be exhaustive
note: add a default clause
```

`default` を足すか、すべてのケースを書きます。

### 配列の範囲外を読む（実行時エラー）

これはコンパイルが通ってしまい、実行したときに落ちます。

```text
Swift/ContiguousArrayBuffer.swift:692: Fatal error: Index out of range
```

原因はほぼ `for i in 0...names.count` です。`count` は要素数なので、最後の添字は `count - 1` です。`0..<names.count` と書きます。

### `sorted()` と `sort()` を取り違える

結果が思ったとおりになりません。ただし、この間違いはコンパイラが警告で教えてくれます。

```swift
var scores = [82, 55, 91]
// scores.sorted()       // これだけでは並び替わらない
// warning: result of call to 'sorted()' is unused
print(scores)            // [82, 55, 91]
scores.sort()
print(scores)            // [55, 82, 91]
```

Swift では、名前が `-ed` や `-ing` で終わるメソッドは新しい値を返し、動詞の原形のメソッドは自分自身を変える、という決まりがあります。`sorted()` と `sort()`、`reversed()` と `reverse()` が例です。

### 辞書の `for-in` の順番をあてにする

辞書の順番は決まっていません。「1回実行したらこの順番だったから、いつもこの順番だ」とは考えないでください。順番が必要なら `keys.sorted()` を使います。

### `var` にしたのに一度も変えない

```text
warning: variable 'label' was never mutated; consider changing to 'let' constant
```

これはエラーではなく警告なので、実行はできます。「`var` にしたけれど変えていないので、`let` でよいのでは」という指摘です。素直に `let` に直してください。

### Double を `==` で比べる

```swift
let a = 0.1 + 0.2
print(a)          // 0.30000000000000004
print(a == 0.3)   // false
```

小数は2進数で正確に表せない値があるため、計算した結果が期待どおりの値にならないことがあります。`Double` を `==` で比べるのは、割り切れる値だとわかっているときだけにしてください。

### 関数の中から、上で作った `var` を使う（Swift 6）

関数は単元3で扱いますが、生成AIが書いたコードにはよく出てきます。上で作った `var` を、関数の中から変えたり読んだりすると、Swift 6 ではエラーになります。

<!-- typecheck: error -->
```swift
var total = 0
func add(_ score: Int) {
    total += score      // ここでエラー
}
add(82)
```

```text
error: main actor-isolated var 'total' can not be mutated from a nonisolated context
```

直し方は1つです。関数が使う値は引数で受け取り、結果は戻り値で返します。関数の中で使う変数は、関数の中で作ります。

```swift
func sum(of scores: [Int]) -> Int {
    var total = 0
    for score in scores {
        total += score
    }
    return total
}
let scores = [82, 55, 91]
print(sum(of: scores))    // 228
```

上で作った `let` の配列や数値を、関数の中で読むだけならエラーになりません。生成AIは `@MainActor` を付ける直し方を勧めることがありますが、この授業では使いません。引数で渡す形に直してください。

## 確認テストで問われること

第1回の確認テスト（11/16 月）はこの章の範囲から出ます。形式は毎回同じで、出力予測2問、誤り指摘1問、白紙再実装1問です。

- 出力予測：`for` と `if`、`break` と `continue` を組み合わせたコードの出力。`sorted()` を呼んだ後にもとの配列がどうなっているか
- 誤り指摘：`let` への再代入、`Int` と `Double` の演算、`switch` の網羅漏れ、`0...count` による範囲外アクセスのうちどれか
- 白紙再実装：配列と `for` と `if` を使って、条件に合う要素だけを新しい配列に集める処理（5〜15行）。教材コードの演習1がそのままの形です

生成AIは使いません（AI利用レベル0）。Xcode の Intelligence をオフにしてから受けてください。出題後は、問題と解答を問題バンクに載せます。

## 詳解Swift 第5版の対応節

より詳しく知りたいときは、次を引いてください。

| この章の内容 | The Swift Programming Language 日本語版 |
|------|------|
| `let`、`var`、型注釈、型推論、型変換 | [基本（The Basics）](https://www.swiftlangjp.com/language-guide/the-basics.html) |
| 演算子、範囲演算子 | [基本演算子（Basic Operators）](https://www.swiftlangjp.com/language-guide/basic-operators.html) |
| 文字列補間 | [文字と文字列（Strings and Characters）](https://www.swiftlangjp.com/language-guide/strings-and-characters.html) |
| 配列、辞書 | [コレクション型（Collection Types）](https://www.swiftlangjp.com/language-guide/collection-types.html) |
| `for-in`、`while`、`if`、`switch` | [制御フロー（Control Flow）](https://www.swiftlangjp.com/language-guide/control-flow.html) |

『詳解 Swift 第5版』（荻原剛志、SBクリエイティブ、2019）の対応する節は、授業で案内します。第5版は Swift 5 の本ですが、この章で扱った文法は変わっていません。

---

前の章：[00 はじめに](00_intro.md)／次の章：[02 Optional](02_optional.md)
