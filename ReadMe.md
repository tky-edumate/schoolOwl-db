# Edumate 専用のDB

## 環境構築

### Mycliのインストール

Mysqlを使いやすくするツール

インストールの仕方
### Windowsの場合
```bash
# Python3が必要
$ pip3 install mycli
```
```bash
# Macの場合
$ brew install mycli
```

https://www.mycli.net/install を参考


### Dockerのセットアップ
```bash
# 今のディレクトリを確認
# プロジェクト直下であることを確認
$ basename `pwd`
edumate-db

# docker上でこのプロジェクト用のmysqlを立てる
$ docker compose up -d

## 起動するまで待機
$ docker logs -f edumate_db_container
```


