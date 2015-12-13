# Shutter

初期セットアップ
-----

### [mergepbx](https://github.com/simonwagner/mergepbx)
Xcodeのプロジェクトの構成情報をもつpbxprojファイルをGitでマージするときに手助けしてくれるツール。これを入れれば、プロジェクトファイルのコンフリクトがほぼなくなります。

##### インストール
```
$ curl -s https://gist.githubusercontent.com/kaneshin/40d9331941682bf46f5d/raw/42e2a7df2d8dbf6c956edcd3fd1c332e3364f573/install_mergepbx.sh | sh
```

### [Carthage](https://github.com/Carthage/Carthage)
DynamicFrameworkを作成するためのライブラリ管理ツール。

##### インストール
```
$ brew update
$ brew install carthage
```

##### ライブラリ追加法
1. Cartfileにリポジトリ、バージョンを記述
```
github "Hoge/Moge" ~> 1.0
```

2. 下記コマンド実行
```
$ carthage bootstrap --platform iOS
```

3. Carthage/Build/iOS/ 以下にあるFrameworkをプロジェクトに追加
```
プロジェクトのFrameworksグループにドラッグする
```

4. Input filesに追加したFrameworkを追加
```
$(SRCROOT)/Carthage/Build/iOS/Moge.framework
```
![素材1](https://cloud.githubusercontent.com/assets/5757351/11765445/316f3a74-a19b-11e5-829b-74c8c7aeed61.png)




