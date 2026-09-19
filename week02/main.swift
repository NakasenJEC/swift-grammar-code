// week02: Optional
// このプログラムは、week01 で作った名簿（名前から点数を引く辞書）を使って、
// 名簿に載っている人と載っていない人を、落ちないように扱います。
//
// 使い方
//   1. Xcode で、9/28 に作ったプロジェクト SwiftGrammar の main.swift を開く
//   2. 中身をすべて消し、このファイルの内容を貼り付ける（前の週のコードは学習ノートに上げてあるので、消えてかまいません）
//   3. 「読む」と書かれている部分は、⌘R を押す前に出力を予想してから実行する
//   4. 「演習」と書かれている部分は、はじめは NG が並ぶ。すべて OK にするのが今週の課題

// MARK: - チェック関数（毎週の教材コードの先頭に、これと同じものが入っています）

func check(_ name: String, _ condition: Bool) {
    print(condition ? "OK  \(name)" : "NG  \(name)")
}

// MARK: - 言語モードの確認（最初の行が NG なら、Build Settings の Swift Language Version を Swift 6 にしてください）

#if swift(>=6.0)
let isSwift6 = true
#else
let isSwift6 = false
#endif
check("Swift 6 の言語モード", isSwift6)

// MARK: - 読む

// --- 1. 辞書の添字は Optional を返す ---

let scoreOf: [String: Int] = [
    "電子太郎": 82,
    "電子花子": 55,
    "山田一郎": 91,
    "佐藤みなみ": 60,
    "グエン・アン": 72,
]

let taroScore = scoreOf["電子太郎"]
let suzukiScore = scoreOf["鈴木"]
print(type(of: taroScore))    // Int ではありません
print(type(of: suzukiScore))

// Optional のまま表示すると、中身ではなく包みごと出ます
print(String(describing: taroScore))
print(String(describing: suzukiScore))

// --- 2. Optional 型の変数を自分で作る ---

var retakeScore: Int? = nil     // 再テストはまだ受けていません
print("再テストは未実施か: \(retakeScore == nil)")
retakeScore = 65
print("再テストは未実施か: \(retakeScore == nil)")

// --- 3. if let で取り出す ---

if let score = scoreOf["電子太郎"] {
    print("電子太郎は \(score) 点です")
} else {
    print("電子太郎は名簿にありません")
}

if let score = scoreOf["鈴木"] {
    print("鈴木は \(score) 点です")
} else {
    print("鈴木は名簿にありません")
}

// 同じ名前で取り出すときは、右辺を省略できます（Swift 5.7 以降）
if let retakeScore {
    print("再テストは \(retakeScore) 点でした")
}

// カンマでつなぐと、両方あるときだけ中に入ります
if let a = scoreOf["電子太郎"], let b = scoreOf["山田一郎"] {
    print("2人の合計は \(a + b) 点です")
}

// 取り出した値をそのまま条件に使えます
if let score = scoreOf["佐藤みなみ"], score >= 60 {
    print("佐藤みなみは合格です（\(score) 点）")
}

// --- 4. ?? で既定値を決める ---

let absentScore = scoreOf["鈴木"] ?? 0
print("鈴木は名簿に無いので \(absentScore) 点として扱います")

let nickname: String? = "たろう"
let nicknameLength = nickname?.count ?? 0
print("ニックネームの長さ: \(nicknameLength)")

// --- 5. guard let で早めに帰る ---

// guard は関数の中でしか使えません。関数の書き方は単元3で扱います
func describe(name: String, in table: [String: Int]) -> String {
    guard let score = table[name] else {
        return "\(name)は名簿にありません"
    }
    return "\(name)は \(score) 点です"
}

print(describe(name: "山田一郎", in: scoreOf))
print(describe(name: "鈴木", in: scoreOf))

// --- 6. ! は使わない ---

// let dangerous = scoreOf["鈴木"]!
// 上の行のコメントを外して実行すると、次のメッセージを出して止まります
// Fatal error: Unexpectedly found nil while unwrapping an Optional value

// MARK: - 演習

// 演習1: ?? を使って、山田一郎と鈴木の点数を取り出してください
//        名簿に無い人は 0 点として扱います

var yamadaScore = -1
var suzukiPoint = -1
// ここに書く

check("演習1 山田一郎は91点", yamadaScore == 91)
check("演習1 鈴木は名簿に無いので0点", suzukiPoint == 0)

// 演習2: wanted を順に見て、名簿にある名前だけを found に集め、
//        その人たちの点数の合計を foundTotal に入れてください。if let を使います

let wanted = ["電子太郎", "鈴木", "グエン・アン", "田中"]
var found: [String] = []
var foundTotal = 0
// ここに書く

check("演習2 見つかったのは2名", found.count == 2)
check("演習2 並び順は wanted のまま", found == ["電子太郎", "グエン・アン"])
check("演習2 2人の合計は154点", foundTotal == 154)

// 演習3: guard let を使って judge を完成させてください
//        名簿に無ければ "名簿にありません"、60点以上なら "合格"、そうでなければ "再テスト" を返します

func judge(name: String, in table: [String: Int]) -> String {
    // ここに書く
    return "（まだ書いていません）"
}

check("演習3 山田一郎は合格", judge(name: "山田一郎", in: scoreOf) == "合格")
check("演習3 電子花子は再テスト", judge(name: "電子花子", in: scoreOf) == "再テスト")
check("演習3 佐藤みなみは合格", judge(name: "佐藤みなみ", in: scoreOf) == "合格")
check("演習3 鈴木は名簿にありません", judge(name: "鈴木", in: scoreOf) == "名簿にありません")

// MARK: - 概念 / Java / Swift
//
//  概念                Java                              Swift
//  値が無いこと         null（どの参照型にも入る）           nil（Optional にした型にだけ入る）
//  値が無いかもしれない型  String（見た目で分からない）        String?（型に ? が付く）
//  値があるか調べる      if (s != null) { ... }            if let s = s { ... }
//  早めに帰る           if (s == null) return ...;         guard let s = s else { return ... }
//  既定値              s != null ? s : ""                s ?? ""
//  連鎖して呼ぶ         if (s != null) s.length();        s?.count
//  標準ライブラリの型    Optional<String>（Java 8 以降）     T? は言語そのものの機能
//  取り違えたとき        NullPointerException（実行時）      コンパイル時にエラー。! を書いたときだけ実行時に落ちる
