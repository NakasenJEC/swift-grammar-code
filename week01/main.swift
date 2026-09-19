// week01: 型と制御構文の再確認、配列・辞書・範囲
// このプログラムは、1CM1 の成績を並べ替えたり、合格した人を数えたり、
// 名前から点数を引いたりします。
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

// --- 1. let と var、型注釈と型推論 ---

let className = "1CM1"
var updateCount = 1
updateCount += 1
print("\(className) の成績表は \(updateCount) 回目の更新です")

let passingScore: Int = 60
let targetAverage = 75.5
print(type(of: passingScore), type(of: targetAverage))

// print(passingScore + targetAverage)   // この行のコメントを外すと何が起きますか
print("目標平均との差: \(targetAverage - Double(passingScore))")

// --- 2. 配列 ---

let names = ["電子太郎", "電子花子", "山田一郎", "佐藤みなみ", "グエン・アン"]
let scores = [82, 55, 91, 60, 72]   // names と同じ並びです

print("在籍 \(names.count) 名、点数 \(scores.count) 個")
print("先頭の人: \(names[0]) \(scores[0]) 点")

let ranking = scores.sorted(by: >)
print("sorted(by:) が返した配列: \(ranking)")
print("もとの scores: \(scores)")

var work = scores
work[1] = 65        // 電子花子の再テストの点数に書き換えます
work.sort()
print("sort() の後の work: \(work)")
print("もとの scores: \(scores)")

// --- 3. 範囲と繰り返し ---

for i in 0..<names.count {
    print("\(i + 1)番 \(names[i]) \(scores[i]) 点")
}

for score in scores where score >= passingScore {
    print("合格点: \(score)")
}

var counted = 0
for score in scores {
    if score == 60 { continue }
    if score > 90 { break }
    counted += 1
}
print("counted = \(counted)")   // 実行する前に、いくつになるか予想してください

// --- 4. if と switch ---

let target = scores[1]

if target >= 80 {
    print("\(names[1]): よくできました")
} else if target >= passingScore {
    print("\(names[1]): 合格です")
} else {
    print("\(names[1]): 再テストです")
}

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

// --- 5. 辞書 ---

let scoreOf: [String: Int] = [
    "電子太郎": 82,
    "電子花子": 55,
    "山田一郎": 91,
    "佐藤みなみ": 60,
    "グエン・アン": 72,
]

print("辞書の件数: \(scoreOf.count)")
for (name, score) in scoreOf {
    print("\(name) \(score) 点")
}
// 上の for-in を3回実行して、並ぶ順番を見比べてください

// 次の行はコメントのままにしてあります。単元2（Optional）で外します
// print(scoreOf["電子太郎"])

// MARK: - 演習

// 演習1: 60点以上だった人の名前を、names の並び順のまま passers に集めてください
//        0..<names.count で回して、if で選びます

var passers: [String] = []
// ここに書く

check("演習1 合格者は4名", passers.count == 4)
check("演習1 並び順は names のまま", passers == ["電子太郎", "山田一郎", "佐藤みなみ", "グエン・アン"])

// 演習2: scoreOf を for-in で回して、80点以上の人数を highScorers に入れてください

var highScorers = 0
// ここに書く

check("演習2 80点以上は2名", highScorers == 2)

// 演習3: scores の合計を total に、平均を average に入れてください
//        average は Double です。Int のまま割ると小数点以下が消えます

var total = 0
var average = 0.0
// ここに書く

check("演習3 合計は360", total == 360)
check("演習3 平均は72.0", average == 72.0)

// MARK: - 概念 / Java / Swift
//
//  概念              Java                                Swift
//  定数              final int n = 5;                    let n = 5
//  変数              int n = 5;                          var n = 5
//  型推論            var n = 5;（Java 10 以降）           let n = 5
//  型注釈            int n = 5;                          let n: Int = 5
//  配列              int[] a = {1, 2};                   let a = [1, 2]
//                    List<Integer> a = List.of(1, 2);
//  要素数            a.length ／ a.size()                a.count
//  連想配列          Map<String, Integer> m              let m: [String: Int]
//  添字の繰り返し     for (int i = 0; i < n; i++)         for i in 0..<n
//  拡張for           for (int x : a)                     for x in a
//  条件付きの繰り返し  for の中に if                        for x in a where 条件
//  多分岐            switch (x) { case 1: ... break; }   switch x { case 1: ... }
//                    break を書かないと次に落ちる           break は不要。網羅していないとエラー
//  暗黙の型変換       int から double は自動               自動変換なし。Double(n) と書く
