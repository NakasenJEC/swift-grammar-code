# 付録A 言語対応表

Swift で学ぶ概念が、Java、Kotlin、TypeScript、Go、Rust ではどう現れるかの対応表です。「この機能は Swift だけのものか、それともプログラミング言語に共通の考え方か」を見るために使ってください。授業が進むごとに、その章の行を埋めていきます。

| 概念 | 章 | Java | Swift | Kotlin | TypeScript | Go | Rust |
|------|:--:|------|------|------|------|------|------|
| 不変と可変 | 01 | `final int x` / `int x` | `let` / `var` | `val` / `var` | `const` / `let` | `const` は定数式のみ | `let` / `let mut` |
| 型推論 | 01 | `var x = 1`（Java 10〜） | `let x = 1` | `val x = 1` | `let x = 1` | `x := 1` | `let x = 1` |
| 配列 | 01 | `int[]`、`ArrayList<Integer>` | `[Int]` | `List<Int>`、`MutableList` | `number[]` | `[]int`、スライス | `Vec<i32>` |
| 辞書 | 01 | `HashMap<K,V>` | `[K: V]` | `Map<K,V>` | `Map<K,V>`、オブジェクト | `map[K]V` | `HashMap<K,V>` |
| 網羅的な分岐 | 01, 05 | `switch`（Java 21 でパターンマッチ） | `switch`（全ケース必須） | `when` | `switch`、判別可能なユニオン | `switch` | `match`（全ケース必須） |
| null 安全 | 02 | `null`、`Optional<T>`（Java 8〜） | `T?`、`if let`、`??` | `T?`、`?.`、`?:` | `T \| null`、`?.`、`??`（strictNullChecks） | `nil`、`(値, ok)` の2値返し | `Option<T>`、`match`、`?` |
| 関数の引数ラベル | 03 | 無し | 外部ラベルと内部名 | 名前付き引数（呼び出し側） | 無し | 無し | 無し |
| 複数の戻り値 | 03 | 無し（クラスを作る） | タプル `(Int, String)` | `Pair`、`data class` | タプル `[number, string]` | 多値返却 | タプル `(i32, String)` |
| 値型の構造体 | 04 | `record`（Java 16〜、参照型） | `struct`（値型） | `data class`（参照型） | 無し（すべて参照） | `struct`（値型） | `struct`（所有権で管理） |
| 計算プロパティ | 04 | getter メソッド | `var area: Double { ... }` | `val area get() = ...` | `get area() { ... }` | メソッド | メソッド |
| 型の後付け拡張 | 04, 08 | 無し | `extension` | 拡張関数 | 宣言のマージ | 同じパッケージ内でメソッド追加 | `impl` ブロック |
| 値を持つ列挙型 | 05 | `enum`（フィールド固定）、`sealed`（Java 17〜） | `enum` と associated value | `sealed class` | 判別可能なユニオン | 無し（`iota` と定数） | `enum`（データ付き） |
| 参照型と継承 | 06 | `class extends` | `class`、`override`、`final` | `open class` | `class extends` | 埋め込み（継承は無い） | 継承は無い（トレイト） |
| 無名関数 | 07 | ラムダ式（Java 8〜） | クロージャ `{ $0 * 2 }` | ラムダ `{ it * 2 }` | アロー関数 | 関数リテラル | クロージャ `\|x\| x * 2` |
| 高階関数 | 07 | Stream API | `map`/`filter`/`reduce` | `map`/`filter`/`fold` | `map`/`filter`/`reduce` | 標準では少ない | イテレータの `map`/`filter`/`fold` |
| インタフェース | 08 | `interface`（既定メソッドあり） | `protocol` と `extension` の既定実装 | `interface` | `interface`（構造的） | `interface`（暗黙の準拠） | `trait` |
| エラー処理 | 09 | 検査例外 `throws`、`try-catch` | `throws`、`try`、`do-catch`、`Result` | 例外（非検査） | 例外 | エラーを戻り値で返す | `Result<T, E>`、`?` |
| ジェネリクス | 09 | `<T extends X>` | `<T: X>`、`where` | `<T : X>` | `<T extends X>` | `[T any]`（Go 1.18〜） | `<T: Trait>` |
| 非同期 | 10 | `Thread`、`CompletableFuture`、仮想スレッド（21〜） | `async`/`await`、`Task` | コルーチン | `async`/`await`、`Promise` | ゴルーチン、チャネル | `async`/`await` |

> 表の各セルは「対応する考え方がある」ことを示すもので、細かい意味が同じとは限りません。詳しくは各言語の公式資料で確認してください（確度：中）。
