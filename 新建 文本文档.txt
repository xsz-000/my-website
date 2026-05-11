@echo off
cd /d %~dp0

echo ==========================
echo 🚀 Git 一键初始化开始
echo ==========================

:: 检查是否已初始化
if exist ".git" (
    echo ⚠️ 已检测到 Git 仓库，跳过 init
) else (
    echo 📦 初始化 Git...
    git init
)

:: 强制主分支
git branch -M main

:: 删除旧 remote（防止重复错误）
git remote remove origin 2>nul

:: 添加 remote
git remote add origin https://github.com/xsz-000/my-website.git

echo 🌐 remote 已设置

:: 添加所有文件
git add .

:: 提交（如果没有改动也不会炸）
git commit -m "auto init" 2>nul

:: 关键：自动绑定 upstream + push
git push -u origin main

echo ==========================
echo ✅ 完成！GitHub 已同步
echo ==========================

pause