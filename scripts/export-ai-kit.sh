#!/bin/bash
set -e

echo "📦 Extracting Universal AI Framework Toolkit..."

# Create temporary directory
TMP_DIR="ai-starter-kit"
mkdir -p "$TMP_DIR/.agents/skills"

# 1. Extract and build AGENTS.md
echo "# AI 開発ガイドライン" > "$TMP_DIR/AGENTS.md"
echo "" >> "$TMP_DIR/AGENTS.md"
echo "このドキュメントは、AIエージェントが当プロジェクトを開発する際に遵守すべきすべてのルール・標準・制約を定義する、「絶対的な憲法」です。" >> "$TMP_DIR/AGENTS.md"
echo "" >> "$TMP_DIR/AGENTS.md"

# Use awk to extract content between AI_KIT_START and AI_KIT_END
awk '/<!-- AI_KIT_START -->/{flag=1; next} /<!-- AI_KIT_END -->/{flag=0; next} flag' AGENTS.md >> "$TMP_DIR/AGENTS.md"

# Create a copy for GEMINI.md as well
cp "$TMP_DIR/AGENTS.md" "$TMP_DIR/GEMINI.md"

# 2. Copy core skills
cp -r .agents/skills/core_* "$TMP_DIR/.agents/skills/"

# 3. Zip the toolkit
TARGET_DIR="public/toolkit"
mkdir -p "$TARGET_DIR"
ZIP_FILE="$TARGET_DIR/ai-starter-kit.zip"
rm -f "$ZIP_FILE"
zip -r "$ZIP_FILE" "$TMP_DIR" > /dev/null

# Cleanup
rm -rf "$TMP_DIR"

echo "✅ Successfully exported to $ZIP_FILE !"
echo "You can extract this zip into any new project to instantly bootstrap the dual-AI development workflow."
