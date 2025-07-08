#!/bin/bash

# TUI Tools Collection - GitHub Pages セットアップスクリプト
# 統合的なGitHub Pagesサイトを構築します

set -e

# 色付きの出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
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

log_step() {
  echo -e "${CYAN}[STEP]${NC} $1"
}

# ディレクトリ構造の作成
create_directory_structure() {
  log_step "ディレクトリ構造を作成中..."

  # GitHub Pages用のディレクトリを作成
  mkdir -p docs
  mkdir -p docs/assets
  mkdir -p docs/css
  mkdir -p docs/js
  mkdir -p docs/demos
  mkdir -p docs/downloads

  log_success "ディレクトリ構造を作成しました"
}

# メインのindex.htmlを作成
create_main_index() {
  log_step "メインのindex.htmlを作成中..."

  cat >docs/index.html <<'EOF'
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TUI Tools Collection</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🖥️</text></svg>">
    <script
        async
        src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2877828132102103"
        crossorigin="anonymous">
    </script>
</head>
<body>
    <div class="container">
        <header>
            <h1>🖥️ TUI Tools Collection</h1>
            <p class="subtitle">ターミナルユーザーインターフェース（TUI）ベースのツール集</p>
        </header>

        <nav class="nav-tabs">
            <button class="tab-button active" onclick="showTab('overview')">概要</button>
            <button class="tab-button" onclick="showTab('tools')">ツール</button>
            <button class="tab-button" onclick="showTab('demos')">デモ</button>
            <button class="tab-button" onclick="showTab('download')">ダウンロード</button>
        </nav>

        <main>
            <!-- 概要タブ -->
            <div id="overview" class="tab-content active">
                <section class="hero">
                    <h2>✨ 特徴</h2>
                    <div class="features">
                        <div class="feature-card">
                            <h3>🚀 高速</h3>
                            <p>軽量でレスポンシブなTUIインターフェース</p>
                        </div>
                        <div class="feature-card">
                            <h3>🔧 実用的</h3>
                            <p>日常的なタスクを効率化する実用的なツール</p>
                        </div>
                        <div class="feature-card">
                            <h3>🎨 美しい</h3>
                            <p>Rich Console による美しいプログレス表示</p>
                        </div>
                        <div class="feature-card">
                            <h3>⌨️ キーボード重視</h3>
                            <p>Vimライクなキー操作（jklh）で効率的な操作</p>
                        </div>
                    </div>
                </section>

                <section class="getting-started">
                    <h2>🚀 クイックスタート</h2>
                    <div class="code-block">
                        <pre><code># リポジトリをクローン
git clone --recursive https://github.com/your-username/tui-tools.git
cd tui-tools

# 全ツールをインストール
./install.sh

# 個別ツールをインストール
./install.sh discord-exporter
./install.sh figma-exporter</code></pre>
                    </div>
                </section>
            </div>

            <!-- ツールタブ -->
            <div id="tools" class="tab-content">
                <section class="tools-grid">
                    <div class="tool-card">
                        <div class="tool-header">
                            <h3>💬 Discord Exporter TUI</h3>
                            <span class="version">v1.0.0</span>
                        </div>
                        <p class="tool-description">
                            Discordチャンネルから直接XLSXファイルにエクスポートするTUIツール
                        </p>
                        <div class="tool-features">
                            <ul>
                                <li>✅ メッセージの検索・フィルタリング</li>
                                <li>✅ Excel形式でのエクスポート</li>
                                <li>✅ 美しいTUIインターフェース</li>
                                <li>✅ 複数チャンネル対応</li>
                            </ul>
                        </div>
                        <div class="tool-actions">
                            <a href="demos/discord-exporter.html" class="btn btn-demo">デモを見る</a>
                            <a href="https://github.com/your-username/discord-exporter-tui" class="btn btn-source">ソースコード</a>
                        </div>
                    </div>

                    <div class="tool-card">
                        <div class="tool-header">
                            <h3>🎨 Figma Image Exporter TUI</h3>
                            <span class="version">v1.0.0</span>
                        </div>
                        <p class="tool-description">
                            FigmaのURLから画像を取得してassetsフォルダに保存するTUIツール
                        </p>
                        <div class="tool-features">
                            <ul>
                                <li>✅ Figma API連携</li>
                                <li>✅ 選択式・一括ダウンロード</li>
                                <li>✅ プログレス表示</li>
                                <li>✅ 設定管理機能</li>
                            </ul>
                        </div>
                        <div class="tool-actions">
                            <a href="demos/figma-exporter.html" class="btn btn-demo">デモを見る</a>
                            <a href="https://github.com/your-username/figma-image-exporter-tui" class="btn btn-source">ソースコード</a>
                        </div>
                    </div>
                </section>
            </div>

            <!-- デモタブ -->
            <div id="demos" class="tab-content">
                <section class="demos">
                    <h2>🎬 デモ動画</h2>
                    <div class="demo-grid">
                        <div class="demo-card">
                            <h3>Discord Exporter TUI</h3>
                            <div class="demo-placeholder">
                                <p>📹 デモ動画が表示されます</p>
                                <small>（実装予定）</small>
                            </div>
                            <a href="demos/discord-exporter.html" class="btn btn-secondary">詳細なデモを見る</a>
                        </div>
                        <div class="demo-card">
                            <h3>Figma Image Exporter TUI</h3>
                            <div class="demo-placeholder">
                                <p>📹 デモ動画が表示されます</p>
                                <small>（実装予定）</small>
                            </div>
                            <a href="demos/figma-exporter.html" class="btn btn-secondary">詳細なデモを見る</a>
                        </div>
                    </div>
                </section>

                <section class="screenshots">
                    <h2>📸 スクリーンショット</h2>
                    <div class="screenshot-grid">
                        <div class="screenshot-item">
                            <img src="assets/discord-exporter-screenshot.png" alt="Discord Exporter TUI" onerror="this.src='data:image/svg+xml,<svg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 400 300\'><rect width=\'100%\' height=\'100%\' fill=\'%23f0f0f0\'/><text x=\'50%\' y=\'50%\' text-anchor=\'middle\' dy=\'0.3em\' font-family=\'Arial\' font-size=\'18\' fill=\'%23666\'>Discord Exporter</text></svg>'">
                            <p>Discord Exporter TUI のメイン画面</p>
                        </div>
                        <div class="screenshot-item">
                            <img src="assets/figma-exporter-screenshot.png" alt="Figma Exporter TUI" onerror="this.src='data:image/svg+xml,<svg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 400 300\'><rect width=\'100%\' height=\'100%\' fill=\'%23f0f0f0\'/><text x=\'50%\' y=\'50%\' text-anchor=\'middle\' dy=\'0.3em\' font-family=\'Arial\' font-size=\'18\' fill=\'%23666\'>Figma Exporter</text></svg>'">
                            <p>Figma Exporter TUI のメイン画面</p>
                        </div>
                    </div>
                </section>
            </div>

            <!-- ダウンロードタブ -->
            <div id="download" class="tab-content">
                <section class="download-section">
                    <h2>📦 ダウンロード</h2>
                    <div class="download-option">
                        <h3>🔄 Git Clone（推奨）</h3>
                        <p>サブモジュールを含む完全なリポジトリをクローンします。</p>
                        <div class="code-block">
                            <pre><code>git clone --recursive https://github.com/your-username/tui-tools.git</code></pre>
                        </div>
                    </div>

                    <div class="download-option">
                        <h3>📁 ZIP ダウンロード</h3>
                        <p>最新のソースコードをZIPファイルでダウンロードします。</p>
                        <a href="https://github.com/your-username/tui-tools/archive/refs/heads/main.zip" class="btn btn-primary">ZIPをダウンロード</a>
                    </div>

                    <div class="download-option">
                        <h3>🔧 個別ツール</h3>
                        <p>個別のツールのみが必要な場合：</p>
                        <div class="individual-tools">
                            <a href="https://github.com/your-username/discord-exporter-tui" class="btn btn-outline">Discord Exporter TUI</a>
                            <a href="https://github.com/your-username/figma-image-exporter-tui" class="btn btn-outline">Figma Exporter TUI</a>
                        </div>
                    </div>
                </section>

                <section class="requirements">
                    <h2>⚙️ システム要件</h2>
                    <div class="requirements-grid">
                        <div class="requirement-item">
                            <h4>🐍 Python</h4>
                            <p>Python 3.8 以上</p>
                        </div>
                        <div class="requirement-item">
                            <h4>💻 OS</h4>
                            <p>Linux, macOS, Windows</p>
                        </div>
                        <div class="requirement-item">
                            <h4>📚 ライブラリ</h4>
                            <p>requirements.txt に記載</p>
                        </div>
                        <div class="requirement-item">
                            <h4>💾 ストレージ</h4>
                            <p>約 50MB</p>
                        </div>
                    </div>
                </section>
            </div>
        </main>
        <footer>
            <div class="footer-content">
                <p>&copy; 2024 TUI Tools Collection. Created with ❤️ for terminal enthusiasts.</p>
                <div class="footer-links">
                    <a href="https://github.com/your-username/tui-tools">GitHub</a>
                    <a href="https://github.com/your-username/tui-tools/issues">Issues</a>
                    <a href="https://github.com/your-username/tui-tools/blob/main/LICENSE">License</a>
                </div>
            </div>
        </footer>
    </div>

    <script src="js/main.js"></script>
</body>
</html>
EOF

  log_success "メインのindex.htmlを作成しました"
}

# CSSファイルの作成
create_css() {
  log_step "CSSファイルを作成中..."

  cat >docs/css/style.css <<'EOF'
/* TUI Tools Collection - Styles */

:root {
    --primary-color: #2563eb;
    --secondary-color: #7c3aed;
    --success-color: #059669;
    --warning-color: #d97706;
    --error-color: #dc2626;
    --bg-color: #0f172a;
    --surface-color: #1e293b;
    --text-primary: #f8fafc;
    --text-secondary: #cbd5e1;
    --border-color: #334155;
    --accent-gradient: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: var(--bg-color);
    color: var(--text-primary);
    line-height: 1.6;
    min-height: 100vh;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
}

/* Header */
header {
    text-align: center;
    padding: 3rem 0;
    background: var(--accent-gradient);
    margin-bottom: 2rem;
    border-radius: 0 0 2rem 2rem;
}

header h1 {
    font-size: 3rem;
    margin-bottom: 1rem;
    text-shadow: 0 2px 4px rgba(0,0,0,0.3);
}

.subtitle {
    font-size: 1.2rem;
    opacity: 0.9;
    font-weight: 300;
}

/* Navigation Tabs */
.nav-tabs {
    display: flex;
    justify-content: center;
    margin-bottom: 2rem;
    background: var(--surface-color);
    border-radius: 1rem;
    padding: 0.5rem;
    gap: 0.5rem;
}

.tab-button {
    background: transparent;
    border: none;
    color: var(--text-secondary);
    padding: 1rem 2rem;
    border-radius: 0.75rem;
    cursor: pointer;
    font-size: 1rem;
    font-weight: 500;
    transition: all 0.3s ease;
}

.tab-button:hover {
    background: var(--border-color);
    color: var(--text-primary);
}

.tab-button.active {
    background: var(--accent-gradient);
    color: white;
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

/* Tab Content */
.tab-content {
    display: none;
    animation: fadeIn 0.3s ease;
}

.tab-content.active {
    display: block;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Hero Section */
.hero {
    text-align: center;
    margin-bottom: 3rem;
}

.features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
}

.feature-card {
    background: var(--surface-color);
    padding: 2rem;
    border-radius: 1rem;
    border: 1px solid var(--border-color);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.feature-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

.feature-card h3 {
    margin-bottom: 1rem;
    color: var(--primary-color);
    font-size: 1.3rem;
}

/* Tools Grid */
.tools-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
    gap: 2rem;
}

.tool-card {
    background: var(--surface-color);
    border-radius: 1rem;
    padding: 2rem;
    border: 1px solid var(--border-color);
    transition: transform 0.3s ease;
}

.tool-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.tool-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.tool-header h3 {
    color: var(--primary-color);
    font-size: 1.4rem;
}

.version {
    background: var(--success-color);
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    font-weight: 600;
}

.tool-description {
    margin-bottom: 1.5rem;
    color: var(--text-secondary);
}

.tool-features ul {
    list-style: none;
    margin-bottom: 2rem;
}

.tool-features li {
    padding: 0.5rem 0;
    color: var(--text-secondary);
}

.tool-actions {
    display: flex;
    gap: 1rem;
}

/* Buttons */
.btn {
    display: inline-flex;
    align-items: center;
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    font-size: 0.9rem;
}

.btn-primary {
    background: var(--accent-gradient);
    color: white;
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4);
}

.btn-secondary {
    background: var(--border-color);
    color: var(--text-primary);
}

.btn-secondary:hover {
    background: var(--text-secondary);
    color: var(--bg-color);
}

.btn-demo {
    background: var(--success-color);
    color: white;
}

.btn-source {
    background: var(--surface-color);
    color: var(--text-primary);
    border: 1px solid var(--border-color);
}

.btn-outline {
    background: transparent;
    color: var(--primary-color);
    border: 2px solid var(--primary-color);
}

.btn-outline:hover {
    background: var(--primary-color);
    color: white;
}

/* Code Blocks */
.code-block {
    background: #000;
    border-radius: 0.5rem;
    padding: 1.5rem;
    margin: 1rem 0;
    border: 1px solid var(--border-color);
}

.code-block pre {
    color: #00ff00;
    font-family: 'Consolas', 'Monaco', monospace;
    overflow-x: auto;
}

/* Getting Started */
.getting-started {
    background: var(--surface-color);
    padding: 2rem;
    border-radius: 1rem;
    border: 1px solid var(--border-color);
}

/* Demo Section */
.demo-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.demo-card {
    background: var(--surface-color);
    padding: 2rem;
    border-radius: 1rem;
    border: 1px solid var(--border-color);
    text-align: center;
}

.demo-placeholder {
    background: var(--bg-color);
    padding: 3rem;
    border-radius: 0.5rem;
    margin: 1rem 0;
    border: 2px dashed var(--border-color);
}

.screenshot-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.screenshot-item {
    text-align: center;
}

.screenshot-item img {
    width: 100%;
    border-radius: 0.5rem;
    border: 1px solid var(--border-color);
    margin-bottom: 1rem;
}

/* Download Section */
.download-option {
    background: var(--surface-color);
    padding: 2rem;
    border-radius: 1rem;
    margin-bottom: 2rem;
    border: 1px solid var(--border-color);
}

.download-option h3 {
    color: var(--primary-color);
    margin-bottom: 1rem;
}

.individual-tools {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

/* Requirements */
.requirements-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
}

.requirement-item {
    background: var(--surface-color);
    padding: 1.5rem;
    border-radius: 1rem;
    text-align: center;
    border: 1px solid var(--border-color);
}

.requirement-item h4 {
    color: var(--primary-color);
    margin-bottom: 0.5rem;
}

/* Footer */
footer {
    margin-top: 4rem;
    padding: 2rem 0;
    border-top: 1px solid var(--border-color);
    text-align: center;
}

.footer-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
}

.footer-links {
    display: flex;
    gap: 2rem;
}

.footer-links a {
    color: var(--text-secondary);
    text-decoration: none;
    transition: color 0.3s ease;
}

.footer-links a:hover {
    color: var(--primary-color);
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        padding: 0 1rem;
    }
    
    header h1 {
        font-size: 2rem;
    }
    
    .nav-tabs {
        flex-wrap: wrap;
    }
    
    .tools-grid {
        grid-template-columns: 1fr;
    }
    
    .footer-content {
        flex-direction: column;
        text-align: center;
    }
    
    .tool-actions {
        flex-direction: column;
    }
}
EOF

  log_success "CSSファイルを作成しました"
}

# JavaScriptファイルの作成
create_javascript() {
  log_step "JavaScriptファイルを作成中..."

  cat >docs/js/main.js <<'EOF'
// TUI Tools Collection - Main JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // タブ切り替え機能の初期化
    initializeTabs();
    
    // スムーススクロールの設定
    initializeSmoothScroll();
    
    // その他の初期化
    initializeAnimations();
});

/**
 * タブ切り替え機能
 */
function initializeTabs() {
    const tabButtons = document.querySelectorAll('.tab-button');
    const tabContents = document.querySelectorAll('.tab-content');
    
    // タブボタンのクリックイベント
    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const targetTab = button.getAttribute('onclick').match(/'([^']+)'/)[1];
            showTab(targetTab);
        });
    });
}

/**
 * タブを表示する
 * @param {string} tabName - 表示するタブの名前
 */
function showTab(tabName) {
    // すべてのタブコンテンツを非表示
    const tabContents = document.querySelectorAll('.tab-content');
    tabContents.forEach(content => {
        content.classList.remove('active');
    });
    
    // すべてのタブボタンの状態をリセット
    const tabButtons = document.querySelectorAll('.tab-button');
    tabButtons.forEach(button => {
        button.classList.remove('active');
    });
    
    // 選択されたタブを表示
    const targetContent = document.getElementById(tabName);
    if (targetContent) {
        targetContent.classList.add('active');
    }
    
    // 対応するボタンをアクティブに
    const targetButton = document.querySelector(`[onclick="showTab('${tabName}')"]`);
    if (targetButton) {
        targetButton.classList.add('active');
    }
    
    // URLハッシュを更新
    window.location.hash = tabName;
    
    // Google Analytics（実装時）
    if (typeof gtag !== 'undefined') {
        gtag('event', 'tab_view', {
            event_category: 'navigation',
            event_label: tabName
        });
    }
}

/**
 * スムーススクロール機能
 */
function initializeSmoothScroll() {
    // ページ内リンクのスムーススクロール
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

/**
 * アニメーション機能
 */
function initializeAnimations() {
    // Intersection Observer for fade-in animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // アニメーション対象の要素を監視
    document.querySelectorAll('.feature-card, .tool-card, .demo-card').forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });
}

/**
 * コードブロックのコピー機能
 */
function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(() => {
            showToast('コマンドをクリップボードにコピーしました！');
        }).catch(err => {
            console.error('コピーに失敗しました:', err);
            fallbackCopyTextToClipboard(text);
        });
    } else {
        fallbackCopyTextToClipboard(text);
    }
}

/**
 * フォールバック用のコピー機能
 */
function fallbackCopyTextToClipboard(text) {
    const textArea = document.createElement("textarea");
    textArea.value = text;
    textArea.style.top = "0";
    textArea.style.left = "0";
    textArea.style.position = "fixed";
    
    document.body.appendChild(textArea);
    textArea.focus();
    textArea.select();
    
    try {
        const successful = document.execCommand('copy');
        if (successful) {
            showToast('コマンドをクリップボードにコピーしました！');
        } else {
            showToast('コピーに失敗しました');
        }
    } catch (err) {
        console.error('フォールバックコピーに失敗しました:', err);
        showToast('コピーに失敗しました');
    }
    
    document.body.removeChild(textArea);
}

/**
 * トースト通知を表示
 */
function showToast(message) {
    // 既存のトーストを削除
    const existingToast = document.querySelector('.toast');
    if (existingToast) {
        existingToast.remove();
    }
    
    // トースト要素を作成
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.textContent = message;
    toast.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #059669;
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 0.5rem;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        z-index: 1000;
        transform: translateX(100%);
        transition: transform 0.3s ease;
    `;
    
    document.body.appendChild(toast);
    
    // アニメーション
    setTimeout(() => {
        toast.style.transform = 'translateX(0)';
    }, 100);
    
    // 3秒後に削除
    setTimeout(() => {
        toast.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (toast.parentNode) {
                toast.parentNode.removeChild(toast);
            }
        }, 300);
    }, 3000);
}

/**
 * ページ読み込み時にURLハッシュに基づいてタブを表示
 */
window.addEventListener('load', () => {
    const hash = window.location.hash.substring(1);
    if (hash && ['overview', 'tools', 'demos', 'download'].includes(hash)) {
        showTab(hash);
    }
});

/**
 * 外部リンクの処理
 */
document.addEventListener('click', (e) => {
    if (e.target.tagName === 'A' && e.target.hostname !== window.location.hostname) {
        // 外部リンクを新しいタブで開く
        e.target.target = '_blank';
        e.target.rel = 'noopener noreferrer';
    }
});

// コードブロックにコピーボタンを追加
document.querySelectorAll('.code-block pre').forEach(codeBlock => {
    const copyButton = document.createElement('button');
    copyButton.textContent = '📋 コピー';
    copyButton.className = 'copy-button';
    copyButton.style.cssText = `
        position: absolute;
        top: 10px;
        right: 10px;
        background: rgba(255,255,255,0.1);
        border: 1px solid rgba(255,255,255,0.2);
        color: white;
        padding: 0.5rem;
        border-radius: 0.25rem;
        cursor: pointer;
        font-size: 0.8rem;
        transition: background 0.3s ease;
    `;
    
    copyButton.addEventListener('click', () => {
        copyToClipboard(codeBlock.textContent);
    });
    
    copyButton.addEventListener('mouseenter', () => {
        copyButton.style.background = 'rgba(255,255,255,0.2)';
    });
    
    copyButton.addEventListener('mouseleave', () => {
        copyButton.style.background = 'rgba(255,255,255,0.1)';
    });
    
    const container = codeBlock.closest('.code-block');
    if (container) {
        container.style.position = 'relative';
        container.appendChild(copyButton);
    }
});
EOF

  log_success "JavaScriptファイルを作成しました"
}

# デモページの作成
create_demo_pages() {
  log_step "デモページを作成中..."

  # Discord Exporter デモページ
  cat >docs/demos/discord-exporter.html <<'EOF'
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Discord Exporter TUI - Demo</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>💬 Discord Exporter TUI</h1>
            <p class="subtitle">デモンストレーション</p>
        </header>
        
        <main>
            <section>
                <h2>📋 機能概要</h2>
                <p>Discord Exporter TUIは、Discordチャンネルから直接XLSXファイルにエクスポートする強力なツールです。</p>
                
                <div class="features">
                    <div class="feature-card">
                        <h3>🔍 高度な検索機能</h3>
                        <p>メッセージの内容、日付、ユーザーによる絞り込みが可能</p>
                    </div>
                    <div class="feature-card">
                        <h3>📊 Excel出力</h3>
                        <p>構造化されたXLSXファイルでデータを出力</p>
                    </div>
                    <div class="feature-card">
                        <h3>⚡ リアルタイム処理</h3>
                        <p>プログレスバー付きのリアルタイム処理表示</p>
                    </div>
                </div>
            </section>
            
            <section>
                <h2>🎬 使用方法</h2>
                <div class="code-block">
                    <pre><code># Discord Exporter TUIを起動
cd discord-exporter-tui
python discord_exporter.py

# TUIインターフェースが起動します
# jklhキーで操作、スペースで決定</code></pre>
                </div>
            </section>
        </main>
        
        <footer>
            <p><a href="../index.html">← メインページに戻る</a></p>
        </footer>
    </div>
</body>
</html>
EOF

  # Figma Exporter デモページ
  cat >docs/demos/figma-exporter.html <<'EOF'
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Figma Image Exporter TUI - Demo</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🎨 Figma Image Exporter TUI</h1>
            <p class="subtitle">デモンストレーション</p>
        </header>
        
        <main>
            <section>
                <h2>📋 機能概要</h2>
                <p>Figma Image Exporter TUIは、FigmaのURLから画像を効率的に取得してローカルに保存するツールです。</p>
                
                <div class="features">
                    <div class="feature-card">
                        <h3>🔗 URL一括処理</h3>
                        <p>JSONファイルから複数のFigma URLを一括読み込み</p>
                    </div>
                    <div class="feature-card">
                        <h3>☑️ 選択式ダウンロード</h3>
                        <p>チェックボックスで必要な画像のみを選択</p>
                    </div>
                    <div class="feature-card">
                        <h3>📦 一括ダウンロード</h3>
                        <p>すべての画像を一度にダウンロード</p>
                    </div>
                </div>
            </section>
            
            <section>
                <h2>🎬 使用方法</h2>
                <div class="code-block">
                    <pre><code># Figma Image Exporter TUIを起動
cd figma-image-exporter-tui
python figma_tui.py

# TUIインターフェースが起動します
# 1. URLsから画像リンクを取得
# 2. 選択して画像をダウンロード
# 3. すべてをダウンロード</code></pre>
                </div>
            </section>
            
            <section>
                <h2>⚙️ 設定例</h2>
                <div class="code-block">
                    <pre><code># figma_urls.json の例
[
  {
    "name": "Design 1",
    "url": "https://www.figma.com/file/ABC123/Design?node-id=1%3A2"
  },
  {
    "name": "Design 2",
    "url": "https://www.figma.com/file/DEF456/Another?node-id=2%3A3"
  }
]</code></pre>
                </div>
            </section>
        </main>
        
        <footer>
            <p><a href="../index.html">← メインページに戻る</a></p>
        </footer>
    </div>
</body>
</html>
EOF

  log_success "デモページを作成しました"
}

# .gitignore の作成
create_gitignore() {
  log_step ".gitignoreファイルを作成中..."

  cat >docs/.gitignore <<'EOF'
# Dependencies
node_modules/
*.log

# Build outputs
dist/
build/

# Environment variables
.env
.env.local

# OS generated files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo

# Temporary files
*.tmp
*.temp
EOF

  log_success ".gitignoreファイルを作成しました"
}

# GitHub Actions ワークフローの作成
create_github_actions() {
  log_step "GitHub Actionsワークフローを作成中..."

  mkdir -p .github/workflows

  cat >.github/workflows/deploy-pages.yml <<'EOF'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4
      with:
        submodules: recursive
        
    - name: Setup Pages
      uses: actions/configure-pages@v4
      
    - name: Upload artifact
      uses: actions/upload-pages-artifact@v3
      with:
        path: './docs'
        
    - name: Deploy to GitHub Pages
      id: deployment
      uses: actions/deploy-pages@v4
EOF

  log_success "GitHub Actionsワークフローを作成しました"
}

# README.md の作成
create_readme() {
  log_step "README.mdを更新中..."

  # 既存のREADME.mdを更新
  cat >>README.md <<'EOF'

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
EOF

  log_success "README.mdを更新しました"
}

# メイン処理
main() {
  echo "================================================"
  echo "    TUI Tools Collection - Pages Setup"
  echo "================================================"
  echo

  log_info "GitHub Pagesサイトのセットアップを開始します..."
  echo

  # 各セットアップ関数を実行
  create_directory_structure
  echo

  create_main_index
  echo

  create_css
  echo

  create_javascript
  echo

  create_demo_pages
  echo

  create_gitignore
  echo

  create_github_actions
  echo

  create_readme
  echo

  log_success "GitHub Pagesサイトのセットアップが完了しました！"
  echo
  echo "次のステップ:"
  echo "1. GitHubリポジトリを作成してプッシュ"
  echo "2. Settings > Pages > Source: GitHub Actions を選択"
  echo "3. https://your-username.github.io/tui-tools でサイトを確認"
  echo
  echo "ローカルプレビュー:"
  echo "cd docs && python -m http.server 8000"
  echo "http://localhost:8000 でプレビュー可能"
  echo
}

# スクリプト実行
main "$@"
