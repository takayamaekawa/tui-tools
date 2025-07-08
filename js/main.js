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
