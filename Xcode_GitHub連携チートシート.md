# Xcode × GitHub — Swiftコードを管理するチートシート

> Swift（1年生・後期）補足資料（希望者向け）
> 対象：Xcode 26.6（画面の名前が違う場合は近いものを探してください）
> 前提：GitHubアカウントを持っていること（授業用アカウントと同じでOK）

---

## ■ このチートシートの目的

「日専祭アプリのプロジェクトや、自分で書いたSwiftのプロジェクトも、GitHubで管理してみたい」
そういう学生向けの手順書です。

**学習ノートの管理（授業で使うもの。Web UI で編集・Upload files）とは別物**なので混同しないでください。
このチートシートで管理するのは **Swiftのソースコード（.swift, .xcodeprojなど）** です。

---

## ■ やることは4つだけ

1. **Xcodeに自分のGitHubアカウントを登録する**（最初に1回だけ）
2. **プロジェクトをGitリポジトリにする**（プロジェクトごとに1回）
3. **GitHubに新しいリモートリポジトリを作る**（プロジェクトごとに1回）
4. **コミットして、プッシュする**（変更するたび）

この授業の範囲では、ブランチ・プルリクエストは使いません。
「ローカルで作業 → 保存（コミット）→ GitHubに送る（プッシュ）」の繰り返しだけです。

---

## ■ STEP 1：Xcodeに自分のGitHubアカウントを登録する（最初に1回だけ）

Xcodeから自分のGitHubに直接ファイルを送れるように、まずアカウントを登録します。

1. Xcodeのメニューバーから **Xcode > Settings...**（または `⌘ + ,`）を開く
2. 上のタブから **Accounts** を選ぶ
3. 左下の **+** ボタンをクリック
4. **GitHub** を選んで **Continue**
5. GitHubのユーザー名と **Personal Access Token** を入力

### Personal Access Token の作り方

GitHubのパスワードではなく、専用のトークンを作って使います。

1. https://github.com にログインして、右上の自分のアイコン → **Settings** をクリック
2. 左側のメニューを一番下までスクロール → **Developer settings**
3. **Personal access tokens** → **Tokens (classic)**
4. **Generate new token** → **Generate new token (classic)**
5. **Note** に分かりやすい名前（例：`Xcode on MyMac`）を入力
6. **Expiration** は好きな期間を選ぶ（90日が無難）
7. **Select scopes** で **repo** にチェック（これだけでOK）
8. 一番下の **Generate token** をクリック
9. 表示されたトークン（`ghp_xxxxx...`）を **コピーしてXcodeに貼り付ける**

💡 **トークンは一度しか表示されません。** 失くしたら作り直してください。

💡 **なぜパスワードじゃなくてトークン？** GitHubは2021年からセキュリティ強化のため、外部ツール（Xcodeなど）からのパスワード認証を廃止しました。トークンは「Xcode専用の合言葉」のようなものです。

---

## ■ STEP 2：プロジェクトをGitリポジトリにする（プロジェクトごとに1回）

Xcodeで作った新しいプロジェクトは、**「Create Git repository on my Mac」にチェックを入れて作成すれば**、自動的にGitリポジトリになります。

### 新規プロジェクト作成時

1. **File > New > Project...** で新規プロジェクトを作る
2. 名前などを設定した次の「保存場所を選ぶ」画面で、**Source Control: Create Git repository on my Mac** にチェックが入っていることを確認
3. **Create** で作成 → ローカルのGitリポジトリが自動で作成されます

### 既存プロジェクトをあとからGit管理にする

すでに作っているプロジェクトをGit管理にしたい場合：

1. プロジェクトをXcodeで開く
2. メニューバーから **Integrate > New Git Repository...**
3. 確認ダイアログで **Create** をクリック

これで、Xcodeの左側のナビゲータ（**⌘ + 2**で表示）に **Source Control Navigator** が使えるようになります。

---

## ■ STEP 3：GitHubに新しいリモートリポジトリを作る（プロジェクトごとに1回）

ローカルのGitリポジトリを、GitHubと結びつけます。

1. Xcodeの左側ナビゲータで **Source Control Navigator**（**⌘ + 2**）を開く
2. **Repositories** セクションで、プロジェクト名を右クリック
3. **New "プロジェクト名" Remote...** を選ぶ
4. 出てきたダイアログで以下を設定：
   - **Account**: STEP 1で登録したGitHubアカウントを選択
   - **Owner**: 自分のアカウント
   - **Repository Name**: 自動で入る（変えてもOK）
   - **Visibility**: **Private**（非公開）か **Public**（公開）を選ぶ
5. **Create** をクリック

💡 **Private と Public どっち？** 自分専用の練習なら **Private** で十分。公開して誰かに見せたいなら **Public**。後から変更もできます。

これで、GitHubに新しいリポジトリが作られ、ローカルと自動でつながります。

---

## ■ STEP 4：コミットして、プッシュする（変更するたび）

ファイルを編集したら、その変更を保存（コミット）して、GitHubに送ります（プッシュ）。

### コミットする

1. メニューバーから **Integrate > Commit...**（または **⌥ + ⌘ + C**）
2. 左側に変更されたファイルの一覧、右側に変更内容（差分）が表示される
3. 下の入力欄に **コミットメッセージ** を書く（例：「検索機能を追加」）
4. 左下の **Push to remote** にチェック
5. **Commit 1 File and Push** をクリック

💡 **コミットメッセージは未来の自分への手紙です。** 「なにを」「なぜ」変えたかを簡潔に書いておくと、あとで振り返るときに役立ちます。

### プッシュだけあとからやる場合

Commit時にPushのチェックを入れ忘れても大丈夫です。

1. **Integrate > Push...**（または **⌥ + ⌘ + K**）
2. リモートとブランチを確認（通常は `origin/main`）
3. **Push** をクリック

---

## ■ よくあるトラブル

### 「Authentication failed」と出る

Personal Access Token が失効している可能性があります。
**Xcode > Settings > Accounts** で該当アカウントを選び、**Remove** してから STEP 1 をやり直してください。

### 「.DS_Store」など余計なファイルが含まれてしまう

プロジェクトのルートに `.gitignore` というファイルを作って、以下を書くと無視されます：

```
.DS_Store
xcuserdata/
*.xcuserstate
```

Xcodeで新規プロジェクトを作るときは、自動で適切な `.gitignore` が作られるので気にしなくてOKです。

### 間違えてコミットしてしまった

直前のコミットを取り消したい場合：

1. **Source Control Navigator**（⌘ + 2）で、**History** タブを開く
2. 最新のコミットの1つ前を右クリック → **Revert to Commit "..."**

ただし、すでにPushしてしまった場合は履歴が残ります。気にせず、次のコミットで修正しましょう。

---

## ■ もっと知りたい人へ：git コマンド

Xcode のGUIだけで基本はすべてできますが、ターミナルから `git` コマンドを使う方法もあります。
興味があれば以下のキーワードで調べてみてください：

- `git init` — リポジトリを作る
- `git add .` — 変更をステージする
- `git commit -m "メッセージ"` — コミットする
- `git push origin main` — プッシュする
- `git status` — 現在の状態を確認
- `git log` — コミット履歴を見る

これらは将来チームで開発するときに必ず使うスキルです。

---

## ■ 補足：学習ノートのリポジトリとの違い

| | 学習ノート（授業で必須） | Swiftコード（このチートシート） |
|---|---|---|
| 管理するファイル | NOTE.md と週の main.swift | Xcode プロジェクト全体（.swift、.xcodeproj など） |
| 編集する場所 | GitHubのWeb上（✏️ と Upload files） | 自分のMac上（Xcode） |
| リポジトリ | Forkしたテンプレート | 自分で新規作成 |
| 操作 | 鉛筆アイコン → Commit ／ Upload files → Commit | Xcode → Commit → Push |

---

**質問は授業のチャットまたは次回授業で気軽にどうぞ。**
