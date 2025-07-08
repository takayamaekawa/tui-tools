# TUI Tools Collection

TUIベースのツール集です。各ツールは独立したサブモジュールとして管理されています。

## 含まれるツール

### 1. Discord Exporter TUI
- **説明**: Discordチャンネルから直接XLSXファイルにエクスポートするTUIツール
- **機能**: メッセージの検索、フィルタリング、エクスポート

### 2. Figma Image Exporter TUI  
- **説明**: FigmaのURLから画像を取得してassetsフォルダに保存するTUIツール
- **機能**: 画像リンク取得、選択式ダウンロード、一括ダウンロード

## 🚀 クイックインストール（推奨）

### Discord Exporter TUI
```bash
# 1行でインストール
curl -fsSL https://provider.maekawa.dev/install.sh | bash -s discord-exporter
```

### Figma Image Exporter TUI
```bash
# 1行でインストール
curl -fsSL https://provider.maekawa.dev/install.sh | bash -s figma-exporter
```

### 全ツール一括インストール
```bash
# すべてのツールを一括インストール
curl -fsSL https://provider.maekawa.dev/install.sh | bash
```

## インストール（手動）

```bash
# リポジトリをクローン
git clone --recursive https://github.com/takayamaekawa/tui-tools.git
cd tui-tools

# すべてのツールを一括インストール
./install.sh

# または個別にインストール
./install.sh discord-exporter
./install.sh figma-exporter
```

## セットアップ

```bash
# GitHub Pages用のセットアップ
./setup-pages.sh
```

## 使用方法

### Discord Exporter TUI
```bash
cd discord-exporter-tui
python discord_exporter.py
```

### Figma Image Exporter TUI
```bash
cd figma-image-exporter-tui  
python figma_tui.py
```

## デモ

統合デモページ: https://provider.maekawa.dev/tui-tools/

## 必要条件

- Python 3.8+
- pip
- Git
- 各ツール固有の依存関係（詳細は各ツールのREADMEを参照）

## ライセンス

各ツールのライセンスに従います。

## 📄 GitHub Pages

このプロジェクトには統合的なGitHub Pagesサイトが含まれています：

- **メインページ**: プロジェクト概要とナビゲーション
- **ツール詳細**: 各TUIツールの詳細情報
- **デモ**: ライブデモとスクリーンショット
- **ダウンロード**: インストール方法とダウンロードリンク

### セットアップ

```bash
# GitHub Pagesサイトをセットアップ
./setup-pages.sh

# GitHubリポジトリでPages機能を有効化
# Settings > Pages > Source: GitHub Actions を選択
```

### ローカル開発

```bash
# 静的サイトをローカルで確認
cd docs
python -m http.server 8000

# ブラウザで http://localhost:8000 を開く
```

### カスタマイズ

- `docs/index.html`: メインページの編集
- `docs/css/style.css`: スタイルの変更
- `docs/js/main.js`: JavaScript機能の追加
- `docs/demos/`: デモページの編集

### 自動デプロイ

GitHubにpushすると自動的にGitHub Pagesサイトが更新されます。
