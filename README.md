# README
このアプリケーションは、Amazon Kindleストア で購入した電子書籍をブラウザで一覧表示し、各種情報でのソートや検索、ビューワーへのリンク表示などの機能を提供します。

## セットアップ
一覧のソースとなる情報は、Amazonが提供しているWindows・Mac向け電子書籍リーダーアプリ「[Kindle for PC](https://www.amazon.co.jp/gp/browse.html?reroutedViaSP=1&node=26197586051&ref=kcp_fd_hz)」が生成するXMLファイルから取得しています。
このファイルは、Kindle for PC を起動したタイミングでAmazonアカウントの購入情報と同期します。
正しく一覧を表示するためには、以下の手順でセットアップしてください。

1. 前提としてAmazon.co.jpアカウントを所持しており、そのアカウントを用いてkindleストアで電子書籍を購入していること
2. Kindle for PC をインストールし、初回起動およびkindle書籍を所持しているアカウントにログインを行う
3. `/config/resources.yml`を作成し、`metadata_xml_path`キーにKindle for PC のアプリケーションフォルダ配下に存在する書籍情報メタデータ`KindleSyncMetadataCache.xml`へのファイルパスを指定する(` /config/resources.yml.example`を参照のこと)
4. bundler および gem のインストール
```
$ gem install bundler -v 2.5.14
$ bundle install
```
5. `bin/rails s`

なお、書籍情報メタデータが取得できない場合は`lib/ExampleMetadata.xml`が参照されます。
