# 02 Optional

## この章で分かること

- Optional は「値があるか、無い（`nil`）か」を型で表す仕組みであること
- 辞書の添字が `Int` ではなく `Int?` を返す理由
- `if let` と `guard let` で中身を取り出す書き方と、その使い分け
- `??` で既定値を決める書き方、`?.` で連鎖して呼ぶ書き方
- `!`（強制アンラップ）が何をするか、なぜ授業では使わないか

この章の教材コードは [week02/main.swift](../week02/main.swift) です。単元1で作った名簿（名前から点数を引く辞書）をそのまま使います。

## 概念と Java との対応

| 概念 | Java | Swift |
|------|------|------|
| 値が無いこと | `null` | `nil` |
| `null` を入れられる範囲 | どの参照型にも入る | 型に `?` を付けたときだけ入る |
| 値が無いかもしれない型 | `String`（見た目では分からない） | `String?` |
| 値があるか調べる | `if (s != null) { ... }` | `if let s = s { ... }` |
| 早めに帰る | `if (s == null) return ...;` | `guard let s = s else { return ... }` |
| 既定値 | `s != null ? s : ""` | `s ?? ""` |
| 連鎖して呼ぶ | `if (s != null) s.length();` | `s?.count` |
| 標準ライブラリの型 | `Optional<String>`（Java 8 以降。参照は `null` のまま） | `String?` は言語そのものの機能 |
| 取り違えたとき | `NullPointerException`（実行時に落ちる） | コンパイル時にエラー |

Java との一番大きな違いは、2行目と最後の行です。Java では `String s` と書いた時点で `null` が入る可能性が常にあり、それを防ぐ手段が言語にありません。Swift では `String` と書けば `nil` は絶対に入りません。`nil` が入るのは `String?` と書いたときだけです。そして `String?` のまま使おうとすると、実行する前にコンパイラが止めます。

`NullPointerException` は「実行してみたら落ちた」というエラーですが、Swift の Optional はそれを「書いている途中でエラーになる」に変えます。面倒に感じるところが、そのまま安全さになっています。

## 文法の説明と実行できる例

### Optional とは何か

型の後ろに `?` を付けると、その型の値か `nil` のどちらかが入る型になります。

```swift
var retakeScore: Int? = nil     // 再テストはまだ受けていない
print(retakeScore == nil)       // true
retakeScore = 65
print(retakeScore == nil)       // false
```

`Int?` は `Int` とは別の型です。`Int` を入れられる場所に `Int?` を入れることはできません。

### 辞書の添字は Optional を返す

単元1で使った名簿を、そのまま使います。

```swift
let scoreOf: [String: Int] = [
    "電子太郎": 82,
    "電子花子": 55,
    "山田一郎": 91,
]
let taroScore = scoreOf["電子太郎"]
let suzukiScore = scoreOf["鈴木"]
print(type(of: taroScore))     // Optional<Int>
print(type(of: suzukiScore))   // Optional<Int>
```

どちらも `Optional<Int>` です。`Optional<Int>` と `Int?` は同じ意味で、`Int?` は書きやすくした書き方です。

辞書がこうなっているのは、存在しないキーを渡されたときに返す値が無いからです。Java の `Map.get` は `null` を返しますが、`null` が返ってきたことを確かめるかどうかは書く人まかせです。Swift は型で「無いかもしれない」と示すので、確かめないと先に進めません。

Optional のまま表示すると、中身ではなく包みごと出ます。

```swift
let scoreOf = ["電子太郎": 82]
print(String(describing: scoreOf["電子太郎"]))   // Optional(82)
print(String(describing: scoreOf["鈴木"]))       // nil
```

### if let で取り出す

`if let` は「値があれば取り出して、その名前で使う」という書き方です。

```swift
let scoreOf = ["電子太郎": 82]
if let score = scoreOf["電子太郎"] {
    print("電子太郎は \(score) 点です")
} else {
    print("電子太郎は名簿にありません")
}
```

`score` は `Int` です。`Int?` ではありません。中身を取り出したので、そのまま計算に使えます。

`score` が使えるのは波括弧の中だけです。外に出た時点で `score` はもうありません。

同じ名前で取り出すときは、右辺を省略できます（Swift 5.7 以降）。

```swift
let retakeScore: Int? = 65
if let retakeScore {
    print("再テストは \(retakeScore) 点でした")
}
```

カンマでつなぐと、両方あるときだけ中に入ります。

```swift
let scoreOf = ["電子太郎": 82, "山田一郎": 91]
if let a = scoreOf["電子太郎"], let b = scoreOf["山田一郎"] {
    print("2人の合計は \(a + b) 点です")
}
```

取り出した値をそのまま条件に使うこともできます。

```swift
let scoreOf = ["佐藤みなみ": 60]
if let score = scoreOf["佐藤みなみ"], score >= 60 {
    print("佐藤みなみは合格です（\(score) 点）")
}
```

### ?? で既定値を決める

`??` は「値があればそれを、無ければ右側を使う」という演算子です。nil 合体演算子といいます。

```swift
let scoreOf = ["電子太郎": 82]
let absentScore = scoreOf["鈴木"] ?? 0
print("鈴木は名簿に無いので \(absentScore) 点として扱います")
```

`absentScore` の型は `Int` です。`??` を通した時点で Optional ではなくなります。

「無ければ 0 点」と決めてよい場面かどうかは、自分で判断してください。欠席と 0 点は違うことがあります。

### ?. で連鎖して呼ぶ

Optional のまま、中身のメソッドやプロパティを呼びたいときは `?.` を使います。値が無ければ呼ばずに `nil` になります。

```swift
let nickname: String? = "たろう"
let nicknameLength = nickname?.count ?? 0
print("ニックネームの長さ: \(nicknameLength)")   // 3
```

```swift
let nickname: String? = nil
let nicknameLength = nickname?.count ?? 0
print("ニックネームの長さ: \(nicknameLength)")   // 0
```

`nickname?.count` の型は `Int?` です。`?.` を通すと結果も Optional になります。だから最後に `?? 0` を付けて `Int` に戻しています。

### guard let で早めに帰る

`guard let` は「値が無ければここで帰る。あればこの先ずっと使える」という書き方です。関数の中でしか使えません。

```swift
func describe(name: String, in table: [String: Int]) -> String {
    guard let score = table[name] else {
        return "\(name)は名簿にありません"
    }
    return "\(name)は \(score) 点です"
}

let scoreOf = ["山田一郎": 91]
print(describe(name: "山田一郎", in: scoreOf))
print(describe(name: "鈴木", in: scoreOf))
```

関数の書き方そのものは単元3で扱います。ここでは `guard let` の形だけ見てください。

`else` の中では、必ずその場から抜けなければなりません。関数なら `return`、繰り返しの中なら `break` か `continue` です。抜けないとコンパイルエラーになります。

### if let と guard let の使い分け

| | `if let` | `guard let` |
|---|---|---|
| 取り出した値が使える範囲 | 波括弧の中だけ | それ以降ずっと |
| 値が無いときに書くこと | `else` は省略できる | `else` は必須で、そこから抜ける |
| 向いている場面 | 値があるときだけ何かする | 値が無いなら先に進めない |
| 書いたときの形 | 本体が右に寄っていく | 本体が左のまま並ぶ |

条件が3つ4つと増えると、`if let` は入れ子が深くなっていきます。`guard let` を並べると、深くならずに済みます。

### ! は使わない

`!` は「中身があると信じて、無理やり取り出す」という書き方です。無ければその場でプログラムが止まります。

```swift
let scoreOf = ["電子太郎": 82]
// let dangerous = scoreOf["鈴木"]!
// 実行するとこうなります
// Fatal error: Unexpectedly found nil while unwrapping an Optional value
print(scoreOf.count)
```

この授業では `!` を使いません。生成AIが書いたコードに `!` が入っていたら、`if let` か `guard let` か `??` に書き換えてから提出してください。書き換えた理由は、学習ノートの4点セットの「AIの出力から自分が変えた点」に書けます。

## よくある間違い

### Optional のまま計算する

```text
error: value of optional type 'Int?' must be unwrapped to a value of type 'Int'
note: coalesce using '??' to provide a default when the optional value contains 'nil'
note: force-unwrap using '!' to abort execution if the optional value contains 'nil'
```

`scoreOf["電子太郎"] + 10` のように書くと出ます。「`Int?` を `Int` にしてから使いなさい」という意味です。`note:` の1行目が `??` を、2行目が `!` を勧めていますが、この授業では `??` か `if let` を使ってください。

### Optional のままメソッドを呼ぶ

```text
error: value of optional type 'String?' must be unwrapped to refer to member 'count' of wrapped base type 'String'
note: chain the optional using '?' to access member 'count' only for non-'nil' base values
```

`nickname.count` と書くと出ます。`nickname?.count` にするか、`if let` で取り出してから呼びます。

### Optional を `Int` の変数に入れる

```text
error: value of optional type 'Int?' must be unwrapped to a value of type 'Int'
```

`let final: Int = retake`（`retake` は `Int?`）で出ます。`Int?` と `Int` は別の型なので、そのままでは入りません。

### if let の外で使おうとする

```text
error: cannot find 'score' in scope
```

`if let score = ...` で取り出した `score` は、波括弧の中だけのものです。外でも使いたいなら `guard let` にします。

### 文字列補間に Optional をそのまま入れる

```text
warning: string interpolation produces a debug description for an optional value; did you mean to make this explicit?
note: use 'String(describing:)' to silence this warning
```

`print("点数は \(scoreOf["電子太郎"]) です")` と書くと出ます。実行はできますが、表示は `点数は Optional(82) です` になります。`?? 0` を付けるか、`if let` で取り出してから入れてください。

### Optional でないものを Optional だと思い込む

次のようなコメントを見かけることがあります。生成AIの説明にも出てきます。

```swift
var name3 = "山田"   // ← 「Optional<String> 型」と書いてあったら、それは間違い
print(type(of: name3))
```

`= "山田"` から型推論されるのは `String` です。`String?` にしたいなら `var name3: String? = "山田"` と書かなければなりません。自分のコードでも、迷ったら `type(of:)` で確かめてください。

### `!` で落ちる

```text
Fatal error: Unexpectedly found nil while unwrapping an Optional value
```

これはコンパイルが通り、実行したときに落ちます。`!` を書いた行が原因です。

## 確認テストで問われること

第2回の確認テスト（11/30 月）はこの章の範囲から出ます。形式は毎回同じで、出力予測2問、誤り指摘1問、白紙再実装1問です。

- 出力予測：`if let` を通ったか通らなかったかで出力が変わるコード。`String(describing:)` で Optional を表示したときの見え方。`??` の既定値が使われるかどうか
- 誤り指摘：Optional のまま計算する、`if let` の外で使う、`Int?` を `Int` に代入する、のうちどれか。エラーメッセージを読んで、何を直せばよいかを答えます
- 白紙再実装：辞書から値を取り出し、無ければ既定の文字列を返す処理（5〜15行）。教材コードの演習3が近い形です

生成AIは使いません（AI利用レベル0）。Xcode の Intelligence をオフにしてから受けてください。出題後は、問題と解答を問題バンクに載せます。

## 詳解Swift 第5版の対応節

より詳しく知りたいときは、次を引いてください。

| この章の内容 | The Swift Programming Language 日本語版 |
|------|------|
| `nil`、Optional、`if let`、`guard let`、`!` | [基本（The Basics）](https://www.swiftlangjp.com/language-guide/the-basics.html) |
| `??` | [基本演算子（Basic Operators）](https://www.swiftlangjp.com/language-guide/basic-operators.html) |
| `?.` の連鎖 | [オプショナルチェーン（Optional Chaining）](https://www.swiftlangjp.com/language-guide/optional-chaining.html) |
| 辞書の添字が Optional を返すこと | [コレクション型（Collection Types）](https://www.swiftlangjp.com/language-guide/collection-types.html) |

『詳解 Swift 第5版』（荻原剛志、SBクリエイティブ、2019）の対応する節は、授業で案内します。

---

前の章：[01 型と制御構文の再確認、配列・辞書・範囲](01_basics.md)／次の章：03 関数とタプル（11/26 公開）
