#!/bin/bash

# TUI Tools Collection - GitHub Pages setup script
# discord-exporter-tuiと同様のgh-pagesブランチ自動デプロイ方式

set -e

echo "Setting up GitHub Pages with gh-pages branch auto-deployment..."

# 現在のブランチを記録
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $CURRENT_BRANCH"

# docs/ディレクトリが存在することを確認
if [ ! -d "docs" ]; then
    echo "Error: docs/ directory not found. Please ensure docs/ directory exists and is committed to git."
    exit 1
fi

echo "Creating orphan gh-pages branch..."

# gh-pagesブランチを作成
git checkout --orphan gh-pages

# 既存のファイルを削除（.gitディレクトリは保持）
git rm -rf . 2>/dev/null || true

# 元のブランチからdocs/の内容をチェックアウト
git checkout $CURRENT_BRANCH -- docs/

# docs/の内容をルートに移動
mv docs/* .
rmdir docs

# .gitignoreを作成
cat > .gitignore << 'EOF'
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

# すべてをステージに追加
git add .

# コミット
git commit -m "Deploy GitHub Pages

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# リモートにプッシュ
git push origin gh-pages --force

echo "gh-pages branch created and pushed!"

# 元のブランチに戻る
git checkout $CURRENT_BRANCH

echo "Returned to $CURRENT_BRANCH branch"
echo ""
echo "GitHub Pages deployment complete!"
echo ""

# GitHub CLI を使用してリポジトリ作成とPages設定の自動化
if command -v gh &> /dev/null; then
    echo "GitHub CLI detected. Attempting to automate repository and Pages setup..."
    
    # リポジトリ情報を取得
    REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
    GITHUB_USERNAME=$(gh api user --jq '.login' 2>/dev/null || echo "takayamaekawa")
    
    echo "Repository: $GITHUB_USERNAME/$REPO_NAME"
    
    # リモートリポジトリが存在するかチェック
    if ! git remote get-url origin &>/dev/null; then
        echo "No remote origin found. Creating GitHub repository..."
        gh repo create "$REPO_NAME" --public --description "TUI Tools Collection - ターミナルユーザーインターフェース（TUI）ベースのツール集"
        git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    fi
    
    # メインブランチをプッシュ
    git push -u origin $CURRENT_BRANCH
    
    # Pages設定を自動化
    echo "Configuring GitHub Pages..."
    gh api repos/$GITHUB_USERNAME/$REPO_NAME/pages \
        --method POST \
        --field source='{"branch":"gh-pages","path":"/"}' \
        2>/dev/null && echo "GitHub Pages configured successfully!" || echo "Pages configuration may need manual setup"
    
    echo ""
    echo "🎉 Setup complete!"
    echo "Your site should be available at: https://$GITHUB_USERNAME.github.io/$REPO_NAME"
    echo "Custom domain: https://provider.maekawa.dev (when configured)"
    
else
    echo "GitHub CLI not found. Please install 'gh' for automatic repository and Pages setup."
    echo ""
    echo "Manual steps required:"
    echo "1. Create GitHub repository if not exists"
    echo "2. Push main branch: git push -u origin $CURRENT_BRANCH"
    echo "3. Go to repository Settings > Pages"
    echo "4. Set Source to 'Deploy from a branch'"
    echo "5. Select 'gh-pages' branch and '/ (root)' folder"
    echo ""
    echo "Your site will be available at: https://takayamaekawa.github.io/tui-tools"
    echo "Custom domain: https://provider.maekawa.dev (when configured)"
fi