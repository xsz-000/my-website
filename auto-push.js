const { execSync } = require("child_process");
const fs = require("fs");

console.log("?? 全自动监听启动...");

let timer = null;

// 防抖（避免疯狂提交）
function commitAndPush() {
  try {
    execSync("git add .");

    const time = new Date().toLocaleString();
    execSync(`git commit -m "auto update ${time}"`);

    execSync("git push");

    console.log("? 已自动推送 Cloudflare");
  } catch (e) {
    console.log("?? 没有变化或提交失败");
  }
}

fs.watch(".", { recursive: true }, (event, file) => {
  if (!file) return;
  if (file.includes(".git")) return;

  clearTimeout(timer);

  timer = setTimeout(() => {
    console.log("?? 检测到变化:", file);
    commitAndPush();
  }, 2000); // 2秒防抖
});