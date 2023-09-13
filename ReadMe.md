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
### Macの場合
```bash
# Homebrewが必要
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

これが表示されればOK.
> ...
> edumate_db_container  | Version: '5.7.42'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
```

### データベースに接続
```bash
# Mycliを通して接続
$ mycli -uedumate -pedustudent -P 13306

> mycli 1.27.0
> Home: http://mycli.net
> Bug tracker: https://github.com/dbcli/mycli/issues
> Thanks to the contributor - Seamile
> MySQL edumate@localhost:(none)>
```