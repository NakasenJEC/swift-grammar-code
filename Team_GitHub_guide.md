# 日専祭アプリを3人で GitHub で管理するガイド

> Swift（1年生・後期）補足資料。アプリのプロジェクトを GitHub で管理すると決めたチームだけが使います（任意）
> 対象：Xcode 26.6。画面の名前は 2026年10月に Xcode 26.6 で確かめました
> 学習ノート（自分のユーザー名/swift-grammar-template）とは別のリポジトリです。学習ノートの書き方は今までどおりです

GitHub で管理しなくても、日専祭のアプリは作れます。途中でうまくいかなくなったら、無理に続けないでください。3人がそれぞれ自分の Mac で担当機能を作り、あとで1台にまとめる方法に戻れます。

---

## 3人で守る約束

1. ブランチは使いません。全員が main で作業します
2. 作業を始める前に「Pull」をします。終わったら「Commit」→「Pull」→「Push」の順です
3. 1人1ファイルにします。自分の担当機能は、自分が作った Swift ファイルに書きます
4. 次のものは代表者だけが変えます：`ContentView.swift`、`（アプリ名）App.swift`、AppIcon、「Signing & Capabilities」の Team
5. iPhone への転送（実機転送）は、代表者の Mac だけで行います。ほかの2人はシミュレータで確かめます
6. アクセストークンなどの秘密の情報は、リポジトリに入れません。Public のリポジトリは誰でも見られます。他人の画像や音楽を使うときは、二宮先生の著作権の注意に従います

なぜこの約束なのかは、最後の「約束の理由」に書いてあります。

## 全体の流れ

| STEP | 誰が | すること |
|---|---|---|
| 1 | 代表者 | GitHub の Web でリポジトリを作る |
| 2 | 代表者と2人 | 代表者が2人を招待し、2人が承認する |
| 3 | 3人 | トークンを作り、Xcode に登録する |
| 4 | 代表者 | リポジトリを Xcode に取り込み、その中にプロジェクトを作って Push する |
| 5 | 2人 | リポジトリを Xcode に取り込む |
| 6 | 3人 | 毎回の作業（Pull → 作業 → Commit → Pull → Push） |

STEP 1・2・3 は GitHub の Web の操作です。学習ノートと同じ画面なので、慣れている人が多いはずです。各 STEP の最後に「できたかの確認」があります。確認が合わなければ、そこで止めてください。

---

## STEP 1　代表者：GitHub の Web でリポジトリを作る

代表者は、チームの3人のうち、リポジトリを作る1人です。

1. GitHub にログインし、右上の「＋」→「New repository」
2. 「Repository name」に、アプリ名に関連する名前を英数字で入れます（例：`omikuji-shaker`）。日本語は使いません
3. 公開範囲は「Public」にします
4. 「Add README」をオンにします
5. 「.gitignore」の欄で「Swift」を選びます。一覧が長いので、Swift と入力して探します
6. ライセンスは付けなくてかまいません
7. 「Create repository」を押します
8. できたリポジトリで `.gitignore` を開き、鉛筆アイコン ✏️ を押します。一番下に `.DS_Store` の1行を足し、「Commit changes...」→「Commit changes」
9. リポジトリの名前を二宮先生に報告します

`.gitignore` は「GitHub に上げないファイル」の一覧です。Xcode は、使う人ごとの画面の状態を `xcuserdata` というフォルダに保存します。学校の Mac は全員のユーザー名が同じ（cmstudent）なので、これを上げると3人の保存がぶつかります。Swift を選ぶと、`xcuserdata/` が最初から入ります。

できたかの確認：リポジトリのファイル一覧に `README.md` と `.gitignore` がある。`.gitignore` の中に `xcuserdata/` と `.DS_Store` の行がある。

## STEP 2　代表者：2人を招待する　2人：招待を受ける

代表者がすること

1. リポジトリの「Settings」→ 左の「Collaborators」
2. 「Add people」を押し、2人のユーザー名（ハンドル名）を入れて選びます
3. 「Add （ユーザー名） to this repository」を押します。パスワードの確認が出たら、自分の GitHub のパスワードを入れます

2人がすること

1. GitHub からのメール、または GitHub の通知を開きます
2. 「Accept invitation」を押します

招待は7日で切れます。切れたら、代表者にもう一度招待してもらいます。

できたかの確認：代表者の「Collaborators」の画面に、2人のユーザー名が出ている。招待を受ける前は「Pending」と出ます。

## STEP 3　3人：トークンを作り、Xcode に登録する

Xcode から GitHub に Push するには、パスワードの代わりに「トークン」を使います。3人とも、自分のトークンを作ります。

### トークンを作る（GitHub の Web）

1. 右上の自分のアイコン →「Settings」
2. 左の一番下の「Developer settings」
3. 「Personal access tokens」→「Tokens (classic)」
4. 「Generate new token」→「Generate new token (classic)」
5. 「Note」に名前を入れます（例：`Xcode nissensai`）
6. 「Expiration」は 30 days 以上にします。日専祭（11/1）より後まで使えるようにするためです
7. 「Select scopes」で次の3つにチェックを入れます：`repo`、`admin:public_key`、`user`
8. 一番下の「Generate token」を押します
9. 表示されたトークン（`ghp_` で始まる文字列）をコピーします。この画面を閉じると、二度と表示されません

- 作るのは「Tokens (classic)」です。「Fine-grained tokens」では、人に招待されたリポジトリに Push できません
- トークンはパスワードと同じです。人に見せません。チャットや生成AIに貼りません。リポジトリのファイルに書きません

### Xcode に登録する

1. Xcode のメニュー「Xcode」→「Settings...」
2. 左の「Source Control」を選び、「Accounts」の「Add Account...」を押します
3. 一覧から「GitHub」を選んで「Continue」
4. 「Account」に GitHub のユーザー名、「Token」にコピーしたトークンを貼ります
5. 「Sign In」を押します

この画面には「GitHub personal access tokens must have these scopes set:」と、`admin:public_key`、`repo`、`user` の3つが出ます。この3つにチェックを入れたトークンを使います。

できたかの確認：「Settings...」の「Source Control」の「Accounts」に、自分の GitHub のアカウントが出ている。

## STEP 4　代表者：取り込んで、その中にプロジェクトを作る

すでにプロジェクトを作り始めている場合も、この手順で新しいプロジェクトを作ります。作ってあった Swift ファイルや画像は、あとで移します（この STEP の最後）。

### リポジトリを取り込む（Clone）

1. GitHub のリポジトリのページで、緑の「Code」を押し、HTTPS の URL をコピーします
2. Xcode のメニュー「Integrate」→「Clone...」
3. 上の「Enter repository URL」の欄に URL を貼り、「Clone」を押します
4. 保存場所を聞かれたら、分かりやすい場所（例：書類フォルダ）を選びます
5. Finder で保存場所を開き、リポジトリ名のフォルダの中に `README.md` があることを確かめます。`.gitignore` は Finder では見えませんが、入っています

### プロジェクトを作る

1. Xcode のメニュー「File」→「New」→「Project...」→ iOS の「App」→「Next」
2. 「Product Name」などを入れます。「Team」は代表者の Team を選びます
3. 「Next」を押すと保存場所を聞かれます。いま取り込んだリポジトリのフォルダ（`README.md` があるフォルダ）を選びます
4. 画面の下に「Source Control: Create Git repository on my Mac」があれば、チェックを外します
5. 「Create」を押します

取り込んだフォルダは、すでに GitHub とつながったリポジトリです。チェックを付けたままにすると、その中にもう1つリポジトリができてしまいます。

### 最初の Commit と Push

1. 左のナビゲータの上に並ぶアイコンのうち、左から2つ目（Source Control）を押し、「Changes」を選びます
2. 「Uncommitted Changes」をクリックすると、右に変更の一覧が出ます
3. 「Stage All」を押します
4. 「Commit message (required)」に、何をしたかを書きます（例：`プロジェクトを作成`）
5. 「Commit」を押します
6. メニュー「Integrate」→「Push...」→「Push」

できたかの確認：GitHub のリポジトリのページを再読み込みすると、アプリ名のフォルダと `（アプリ名）.xcodeproj` が見える。`xcuserdata` という名前のフォルダはどこにも無い。

### 作ってあったファイルを移す

- Swift ファイルは、Finder で新しいプロジェクトのアプリ名のフォルダ（`ContentView.swift` と同じ場所）にコピーします。Xcode に戻ると、自動で一覧に出ます
- 画像は、Xcode で `Assets` を開き、そこにドラッグします
- 前のプロジェクトの `ContentView.swift` の中身は、代表者が新しい `ContentView.swift` に貼ります
- 移したら、上の「最初の Commit と Push」と同じ手順で Commit と Push をします

## STEP 5　2人：取り込む

1. 代表者から、リポジトリの URL を聞きます（GitHub のページの緑の「Code」→ HTTPS）
2. Xcode のメニュー「Integrate」→「Clone...」
3. URL を貼り、「Clone」を押して、保存場所を選びます
4. 取り込んだフォルダの中の `（アプリ名）.xcodeproj` を開きます
5. 実行先をシミュレータ（例：iPhone 17 Pro）にして、▶︎ で動かします

「Signing & Capabilities」に Team のエラーが出ても、Team を変えないでください。シミュレータでは、そのまま動きます。

できたかの確認：シミュレータで、代表者が作ったアプリが動く。

## STEP 6　毎回の作業（3人）

### 始めるとき

1. メニュー「Integrate」→「Pull...」→「Pull」。「Rebase local changes onto upstream changes」のチェックは付けません

### 作業

2. 自分の担当機能のファイルを作ったり直したりします。新しいファイルは、メニュー「File」→「New」→「File from Template...」→「Swift File」（画面を作るなら「SwiftUI View」）

### 区切りがついたら（何度でも）

3. Source Control の「Changes」→「Uncommitted Changes」で、変わったファイルを確かめます。自分の担当ではないファイルが入っていたら、Commit しないで代表者に相談します
4. 「Stage All」→「Commit message (required)」に何をしたかを書く（例：`ランキング画面を追加`）→「Commit」
5. メニュー「Integrate」→「Pull...」→「Pull」
6. メニュー「Integrate」→「Push...」→「Push」

できたかの確認：GitHub のリポジトリのページで、自分のコミットが出ている。Xcode では、Source Control の「Repositories」でリポジトリ名をクリックすると、3人のコミットの一覧が見られる。

---

## 困ったとき

| こうなった | こうする |
|---|---|
| Push で「The local repository is out of date. Make sure all changes have been pulled from the remote repository and try again.」と出た | ほかの人が先に Push しています。「Pull...」をしてから、もう一度「Push...」 |
| Pull が止まった。または、まだ Commit していない変更をどうするか聞かれた | 先に自分の変更を Commit してから、Pull します |
| 衝突（コンフリクト）の画面が出た | 同じファイルの同じところを2人が直しています。自分で直そうとせず、その画面を閉じて代表者と相談します |
| Signing の Team を変えてしまった | Commit しないでください。「Changes」で `（アプリ名）.xcodeproj` を選び、メニュー「Integrate」→「Discard Changes in Selected Files...」で取り消します |
| 認証のエラーが出て Push できない | トークンの期限切れか、スコープ（3つ）の足りないトークンです。STEP 3 でトークンを作り直し、Xcode の「Accounts」で古いアカウントを消してから登録し直します |
| 招待が届かない。7日を過ぎた | 代表者に招待し直してもらいます |
| どうしても元に戻せない | 自分が作ったファイルを Finder でデスクトップなどにコピーして避けておきます。取り込んだフォルダをゴミ箱に入れて、STEP 5 から取り込み直します |

## 生成AIに聞くとき

次の前提文を貼ってから質問すると、自分の画面に合った答えが返りやすくなります。トークンは絶対に貼りません。

```
私は専門学校の1年生です。Xcode 26.6 で iOS アプリを3人で作っています。
GitHub の操作は、Xcode のメニュー「Integrate」の Commit、Pull、Push だけを使います。
ブランチは使わず、全員が main で作業しています。ターミナルの git コマンドは使いません。
1人1ファイルで分担していて、ContentView.swift と Signing の設定は代表者だけが変えます。
質問：（ここに書く）
```

## 約束の理由

| 約束 | 理由 |
|---|---|
| 1人1ファイル | 別々のファイルなら、Pull したときに自動でまとまります。同じ行を2人が直すと、自動ではまとまらず衝突します |
| ContentView などは代表者だけ | どの担当の人も触りたくなるファイルなので、衝突が起きやすいからです |
| Team と実機転送は代表者だけ | Team を選ぶと、プロジェクトの設定ファイル（`project.pbxproj`）が書き換わります。Team は人ごとに違うので、3人が選ぶと必ず衝突します。シミュレータは、Team が違っても動きます |
| .gitignore を最初に入れる | Xcode が使う人ごとに保存する `xcuserdata` が、学校の Mac では3人とも同じ場所になり、ぶつかるからです |
| Pull してから Push | ほかの人の変更を先に取り込まないと、Push が断られるからです |

## 詰まったら

- 無理に進めないでください。GitHub で管理しなくても、日専祭のアプリは作れます
- 詰まった画面のスクリーンショット（⌘ + Shift + 4）を撮っておき、次の対面の授業（第8回・10/19 月）で中川に見せてください
- それまでは、自分の担当機能を自分の Mac で作り続けます
