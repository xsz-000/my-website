@echo off

echo =========================================
echo 🚀 Auto Website CI/CD Setup Starting...
echo =========================================

:: ====================================================
:: 1️⃣ 初始化 npm
:: ====================================================

if not exist package.json (
    call npm init -y
)

:: ====================================================
:: 2️⃣ 安装依赖
:: ====================================================

echo 📦 Installing dependencies...

call npm install chokidar simple-git

:: ====================================================
:: 3️⃣ 创建 index.html
:: ====================================================

echo 🌐 Creating index.html...

(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo.
echo ^<head^>
echo   ^<meta charset="UTF-8"^>
echo   ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo   ^<title^>Auto Website^</title^>
echo   ^<link rel="stylesheet" href="style.css"^>
echo ^</head^>
echo.
echo ^<body^>
echo.
echo   ^<h1^>🚀 Auto Deploy System^</h1^>
echo.
echo   ^<p^>
echo     Continue 修改代码后，
echo     GitHub 与 Cloudflare 会自动更新。
echo   ^</p^>
echo.
echo   ^<button id="btn"^>
echo     Click Me
echo   ^</button^>
echo.
echo   ^<script src="script.js"^>^</script^>
echo.
echo ^</body^>
echo ^</html^>
) > index.html

:: ====================================================
:: 4️⃣ 创建 style.css
:: ====================================================

echo 🎨 Creating style.css...

(
echo body {
echo   margin: 0;
echo   padding: 0;
echo   background: #111;
echo   color: white;
echo   font-family: Arial, sans-serif;
echo   display: flex;
echo   flex-direction: column;
echo   justify-content: center;
echo   align-items: center;
echo   height: 100vh;
echo   text-align: center;
echo }
echo.
echo h1 {
echo   font-size: 48px;
echo }
echo.
echo button {
echo   margin-top: 30px;
echo   padding: 12px 24px;
echo   border: none;
echo   border-radius: 10px;
echo   cursor: pointer;
echo }
) > style.css

:: ====================================================
:: 5️⃣ 创建 script.js
:: ====================================================

echo ⚙️ Creating script.js...

(
echo console.log("🚀 Website Loaded");
echo.
echo const btn = document.getElementById("btn");
echo.
echo btn.addEventListener("click", ^(^) =^> {
echo   alert("🔥 Auto Deploy System Running");
echo });
) > script.js

:: ====================================================
:: 6️⃣ 创建 .gitignore
:: ====================================================

echo 🚫 Creating .gitignore...

(
echo node_modules
echo .DS_Store
echo *.log
) > .gitignore

:: ====================================================
:: 7️⃣ 创建 auto-ci.js
:: ====================================================

echo 🤖 Creating auto-ci.js...

(
echo const chokidar = require("chokidar"^);
echo const { exec } = require("child_process"^);
echo.
echo console.log("🚀 Auto CI running..."^);
echo.
echo const run = ^(cmd^) =^>
echo   new Promise(^(resolve^) =^> {
echo     exec^(cmd, ^(err, stdout, stderr^) =^> {
echo.
echo       if ^(err^) {
echo         console.log^(err.message^);
echo       }
echo.
echo       if ^(stdout^) {
echo         console.log^(stdout^);
echo       }
echo.
echo       if ^(stderr^) {
echo         console.log^(stderr^);
echo       }
echo.
echo       resolve^(^);
echo     }^);
echo   }^);
echo.
echo let timer = null;
echo.
echo chokidar
echo   .watch^(".", {
echo     ignored: ["**/.git/**", "**/node_modules/**"],
echo     ignoreInitial: true,
echo   }^)
echo.
echo   .on^("change", ^(path^) =^> {
echo.
echo     console.log^("📦 File changed:", path^);
echo.
echo     clearTimeout^(timer^);
echo.
echo     timer = setTimeout^(async ^(^) =^> {
echo.
echo       console.log^("🔄 Auto syncing..."^);
echo.
echo       await run^("git add ."^);
echo.
echo       await run^(
echo         'git diff --cached --quiet ^|^| git commit -m "auto update"'
echo       ^);
echo.
echo       await run^("git push"^);
echo.
echo       console.log^("✅ Pushed → GitHub → Cloudflare"^);
echo.
echo     }, 2000^);
echo   }^);
) > auto-ci.js

:: ====================================================
:: 8️⃣ 设置 npm start
:: ====================================================

call npm pkg set scripts.start="node auto-ci.js"

:: ====================================================
:: 9️⃣ 初始化 git
:: ====================================================

if not exist .git (
    git init
)

:: ====================================================
:: 🔟 启动监听
:: ====================================================

echo.
echo =========================================
echo ✅ Setup Complete
echo =========================================
echo.

echo 🚀 Starting Auto CI...

call npm start