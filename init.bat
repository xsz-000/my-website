@echo off
cd /d %~dp0

echo 🚀 初始化项目...

git init
git branch -M main

git remote remove origin 2>nul
git remote add origin https://github.com/xsz-000/my-website.git

git add .
git commit -m "init"

git push -u origin main

echo ✅ 初始化完成
pause