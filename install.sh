#!/bin/bash

# TUI Tools Collection - インストールスクリプト
# 使用方法: ./install.sh [tool-name]
# tool-name: discord-exporter, figma-exporter, または空（全ツール）

set -e

# 色付きの出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ログ関数
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Python バージョンチェック
check_python() {
  log_info "Pythonのバージョンをチェック中..."

  if command -v python3 &>/dev/null; then
    PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    log_info "Python $PYTHON_VERSION が見つかりました"

    # Python 3.8+ が必要
    if python3 -c 'import sys; exit(0 if sys.version_info >= (3, 8) else 1)'; then
      log_success "Python バージョンチェック完了"
    else
      log_error "Python 3.8以上が必要です。現在のバージョン: $PYTHON_VERSION"
      exit 1
    fi
  else
    log_error "Python3が見つかりません。Pythonをインストールしてください。"
    exit 1
  fi
}

# 依存関係のインストール
install_dependencies() {
  local tool_name=$1
  log_info "$tool_name の依存関係をインストール中..."

  case $tool_name in
  "discord-exporter")
    if [ -f "discord-exporter-tui/requirements.txt" ]; then
      pip3 install -r discord-exporter-tui/requirements.txt
      log_success "Discord Exporter の依存関係をインストールしました"
    else
      log_warning "requirements.txt が見つかりません: discord-exporter-tui/requirements.txt"
    fi
    ;;
  "figma-exporter")
    if [ -f "figma-image-exporter-tui/requirements_tui.txt" ]; then
      pip3 install -r figma-image-exporter-tui/requirements_tui.txt
      log_success "Figma Exporter の依存関係をインストールしました"
    else
      log_warning "requirements_tui.txt が見つかりません: figma-image-exporter-tui/requirements_tui.txt"
    fi
    ;;
  *)
    log_error "未知のツール名: $tool_name"
    exit 1
    ;;
  esac
}

# ディレクトリ存在チェック
check_directories() {
  log_info "ツールディレクトリをチェック中..."

  if [ ! -d "discord-exporter-tui" ]; then
    log_warning "discord-exporter-tui ディレクトリが見つかりません"
  fi

  if [ ! -d "figma-image-exporter-tui" ]; then
    log_warning "figma-image-exporter-tui ディレクトリが見つかりません"
  fi

  log_success "ディレクトリチェック完了"
}

# 実行権限の設定
set_permissions() {
  log_info "実行権限を設定中..."

  find . -name "*.sh" -type f -exec chmod +x {} \;
  find . -name "*.py" -type f -exec chmod +x {} \;

  log_success "実行権限を設定しました"
}

# Discord Exporter の設定
setup_discord_exporter() {
  log_info "Discord Exporter を設定中..."

  if [ -d "discord-exporter-tui" ]; then
    cd discord-exporter-tui

    # 設定ファイルのサンプルを作成
    if [ ! -f "config.json" ]; then
      cat >config.json <<'EOF'
{
    "discord_token": "",
    "export_format": "xlsx",
    "output_directory": "exports",
    "max_messages": 1000
}
EOF
      log_info "config.json のサンプルを作成しました"
      log_warning "discord_token を設定してください"
    fi

    cd ..
    log_success "Discord Exporter の設定完了"
  else
    log_warning "discord-exporter-tui ディレクトリが見つかりません"
  fi
}

# Figma Exporter の設定
setup_figma_exporter() {
  log_info "Figma Exporter を設定中..."

  if [ -d "figma-image-exporter-tui" ]; then
    cd figma-image-exporter-tui

    # assetsディレクトリを作成
    mkdir -p assets

    # 設定ファイルのサンプルを作成
    if [ ! -f "figma_config.json" ]; then
      cat >figma_config.json <<'EOF'
{
    "figma_token": "",
    "urls_file": "figma_urls.json",
    "output_file": "figma_images.json",
    "assets_dir": "assets"
}
EOF
      log_info "figma_config.json のサンプルを作成しました"
      log_warning "figma_token を設定してください"
    fi

    # サンプルURLファイルを作成
    if [ ! -f "figma_urls.json" ]; then
      cat >figma_urls.json <<'EOF'
[
  {
    "name": "Sample Design 1",
    "url": "https://www.figma.com/file/ABC123/Sample-Design?node-id=1%3A2&t=xyz123"
  },
  {
    "name": "Sample Design 2", 
    "url": "https://www.figma.com/file/DEF456/Another-Design?node-id=2%3A3&t=abc456"
  }
]
EOF
      log_info "figma_urls.json のサンプルを作成しました"
    fi

    cd ..
    log_success "Figma Exporter の設定完了"
  else
    log_warning "figma-image-exporter-tui ディレクトリが見つかりません"
  fi
}

# メイン処理
main() {
  echo "========================================"
  echo "      TUI Tools Collection Installer"
  echo "========================================"
  echo

  # 引数の処理
  TOOL_NAME=${1:-"all"}

  log_info "インストールを開始します: $TOOL_NAME"
  echo

  # Python チェック
  check_python
  echo

  # ディレクトリチェック
  check_directories
  echo

  # 実行権限設定
  set_permissions
  echo

  # ツール別インストール
  case $TOOL_NAME in
  "discord-exporter")
    install_dependencies "discord-exporter"
    setup_discord_exporter
    ;;
  "figma-exporter")
    install_dependencies "figma-exporter"
    setup_figma_exporter
    ;;
  "all")
    log_info "全ツールをインストールします..."
    install_dependencies "discord-exporter"
    install_dependencies "figma-exporter"
    setup_discord_exporter
    setup_figma_exporter
    ;;
  *)
    log_error "無効なツール名: $TOOL_NAME"
    echo "使用方法: $0 [discord-exporter|figma-exporter|all]"
    exit 1
    ;;
  esac

  echo
  log_success "インストール完了！"
  echo
  echo "次のステップ:"
  echo "1. 各ツールの設定ファイルでトークンを設定"
  echo "2. GitHub Pages用のセットアップ: ./setup-pages.sh"
  echo "3. ツールの実行: cd [tool-directory] && python3 [main-script]"
  echo
}

# スクリプト実行
main "$@"

