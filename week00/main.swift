// week00: 環境確認
// このプログラムは、Xcode と Swift の設定を確認し、チェック関数 check() の動き方を見せます。
// 実行すると OK と NG の行が並びます。最後の NG が 1 行だけ出るのは、わざとそうしています。
//
// 使い方
//   1. Xcode で File > New > Project... > macOS > Command Line Tool を選び、名前を week00 にして作成
//   2. 作られた main.swift の中身をすべて消し、このファイルの内容を貼り付ける
//   3. ⌘R で実行し、下のコンソールに OK / NG の行が出ることを確認する

// MARK: - チェック関数（毎週の教材コードの先頭に、これと同じものが入っています）

func check(_ name: String, _ condition: Bool) {
    print(condition ? "OK  \(name)" : "NG  \(name)")
}

// MARK: - 読む

#if swift(>=6.0)
print("Swift 6 の言語モードで動いています")
#else
print("Swift 5 の言語モードです。Build Settings の Swift Language Version を確認してください")
#endif

let greeting = "こんにちは、Swift"
print(greeting)

// MARK: - 演習（今日は何も書かなくて大丈夫です）

check("1 + 1 は 2", 1 + 1 == 2)
check("greeting の文字数は 11", greeting.count == 11)
check("わざと失敗する例。これは NG のままで正解です", 1 + 1 == 3)
