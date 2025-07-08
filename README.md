# TUI Tools Collection

TUIベースのツール集です。各ツールは独立したサブモジュールとして管理されています。

## 含まれるツール

### 1. Discord Exporter TUI
- **説明**: Discordチャンネルから直接XLSXファイルにエクスポートするTUIツール
- **機能**: メッセージの検索、フィルタリング、エクスポート

### 2. Figma Image Exporter TUI  
- **説明**: FigmaのURLから画像を取得してassetsフォルダに保存するTUIツール
- **機能**: 画像リンク取得、選択式ダウンロード、一括ダウンロード

## インストール

```bash
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
