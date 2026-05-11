@echo off
cd /d %~dp0

echo 🚀 开始自动部署...

git add .

git commit -m "update %date% %time%"

git push

echo ✅ 部署完成！网站已更新
pause