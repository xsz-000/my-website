const chokidar = require("chokidar");
const { exec } = require("child_process");

console.log("ðŸš€ Auto CI running...");

const run = (cmd) =>
  new Promise((resolve) => {
    exec(cmd, (err, stdout, stderr) => {

      if (err) {
        console.log(err.message);
      }

      if (stdout) {
        console.log(stdout);
      }

      if (stderr) {
        console.log(stderr);
      }

      resolve();
    });
  });

let timer = null;

chokidar
  .watch(".", {
    ignored: ["**/.git/**", "**/node_modules/**"],
    ignoreInitial: true,
  })

  .on("change", (path) => {

    console.log("ðŸ“¦ File changed:", path);

    clearTimeout(timer);

    timer = setTimeout(async () => {

      console.log("ðŸ”„ Auto syncing...");

      await run("git add .");

      await run(
        'git diff --cached --quiet || git commit -m "auto update"'
      );

      await run("git push");

      console.log("âœ?Pushed â†?GitHub â†?Cloudflare");

    }, 2000);
  });
