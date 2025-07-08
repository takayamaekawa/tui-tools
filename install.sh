#!/bin/bash

# TUI Tools Collection - インストールスクリプト
# 使用方法: curl -fsSL https://provider.maekawa.dev/install.sh | bash [-s tool-name]
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

# リポジトリをクローン
clone_repository() {
  local repo_url="https://github.com/takayamaekawa/tui-tools.git"
  local tmp_dir
  local clone_dir="tui-tools"
  
  log_info "リポジトリをクローンしています..."
  
  # 一時ディレクトリを作成
  tmp_dir=$(mktemp -d)
  cd "$tmp_dir"
  
  if ! git clone "$repo_url" "$clone_dir"; then
    log_error "リポジトリのクローンに失敗しました"
    rm -rf "$tmp_dir"
    exit 1
  fi
  
  cd "$clone_dir"
  log_success "リポジトリをクローンしました"
  
  # サブモジュールを初期化
  log_info "サブモジュールを初期化中..."
  if ! git submodule update --init --recursive; then
    log_error "サブモジュールの初期化に失敗しました"
    rm -rf "$tmp_dir"
    exit 1
  fi
  log_success "サブモジュールの初期化完了"
  
  # 一時ディレクトリのパスを環境変数として保存
  export INSTALL_TMP_DIR="$tmp_dir"
}

# make が利用可能かチェック
check_make() {
  if ! command -v make &>/dev/null; then
    log_error "make が見つかりません。makeをインストールしてください。"
    echo "Ubuntu/Debian: sudo apt install make"
    echo "CentOS/RHEL: sudo yum install make"
    echo "macOS: xcode-select --install"
    exit 1
  fi
}

# Discord Exporter のインストール
install_discord_exporter() {
  log_info "Discord Exporter をインストール中..."
  
  if [ -d "discord-exporter-tui" ]; then
    cd discord-exporter-tui
    
    if [ -f "Makefile" ]; then
      if make install; then
        log_success "Discord Exporter のインストール完了"
      else
        log_error "Discord Exporter のインストールに失敗しました"
        exit 1
      fi
    else
      log_error "Makefile が見つかりません"
      exit 1
    fi
    
    cd ..
  else
    log_error "discord-exporter-tui ディレクトリが見つかりません"
    exit 1
  fi
}

# Figma Exporter のインストール
install_figma_exporter() {
  log_info "Figma Exporter をインストール中..."
  
  if [ -d "figma-image-exporter-tui" ]; then
    cd figma-image-exporter-tui
    
    if [ -f "Makefile" ]; then
      if make install; then
        log_success "Figma Exporter のインストール完了"
      else
        log_error "Figma Exporter のインストールに失敗しました"
        exit 1
      fi
    else
      log_error "Makefile が見つかりません"
      exit 1
    fi
    
    cd ..
  else
    log_error "figma-image-exporter-tui ディレクトリが見つかりません"
    exit 1
  fi
}

# 使用方法の表示
show_usage() {
  echo ""
  echo "使用方法:"
  echo "  Discord Exporter: curl -fsSL https://provider.maekawa.dev/install.sh | bash -s discord-exporter"
  echo "  Figma Exporter:   curl -fsSL https://provider.maekawa.dev/install.sh | bash -s figma-exporter"
  echo "  全ツール:         curl -fsSL https://provider.maekawa.dev/install.sh | bash"
  echo ""
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

  # 依存関係チェック
  if ! command -v git &>/dev/null; then
    log_error "git が見つかりません。gitをインストールしてください。"
    exit 1
  fi
  
  check_make
  echo

  # リポジトリクローン
  clone_repository
  echo

  # ツール別インストール
  case $TOOL_NAME in
  "discord-exporter")
    install_discord_exporter
    ;;
  "figma-exporter")
    install_figma_exporter
    ;;
  "all")
    log_info "全ツールをインストールします..."
    install_discord_exporter
    install_figma_exporter
    ;;
  *)
    log_error "無効なツール名: $TOOL_NAME"
    show_usage
    exit 1
    ;;
  esac

  echo
  log_success "インストール完了！"
  echo
  echo "次のステップ:"
  echo "1. discord_exporter --help または figma_exporter --help で使用方法を確認"
  echo "2. 各ツールの設定ファイルでトークンを設定"
  echo "3. ツールの実行: discord_exporter または figma_exporter"
  echo
  
  # 一時ディレクトリのクリーンアップ
  if [ -n "$INSTALL_TMP_DIR" ] && [ -d "$INSTALL_TMP_DIR" ]; then
    log_info "一時ファイルをクリーンアップ中..."
    rm -rf "$INSTALL_TMP_DIR"
  fi
}

# スクリプト実行
main "$@"

