# Haxe/JS Development Container

VSCode DevContainer向けのHaxe/JS開発環境Dockerコンテナです。

## 概要

このDockerコンテナは [mcr.microsoft.com/devcontainers/base:ubuntu](https://github.com/devcontainers/images/tree/main/src/base-ubuntu) をベースに構築されており、以下が含まれています。

- **Haxe 4.3.7** - クロスプラットフォーム開発言語
- **NekoVM 2.4.1** - Haxeランタイム環境
- **volta**
- **Node.js v20**
- **Yarn v1**
- **日本語ロケール対応** (ja_JP.UTF-8)

## 使用方法

### 1. Dockerイメージのビルド

```bash
./build.sh
```

Windowsの場合は、Git Bash等を使用して実行してください。

### 2. DevContainerの設定

VSCodeワークスペースに `.devcontainer/devcontainer.json` ファイルを作成してください。以下は設定例です。

```json
{
  "name": "my project",
  "image": "denkiyagi/devcontainer-haxe-js:latest",
  "customizations": {
    "vscode": {
      "extensions": [
        "nadako.vshaxe",
        "wiggin77.codedox",
      ]
    }
  }
}
```
