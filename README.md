

<div align="center">
  <h1>🧩 BPC 一键下载 & 更新工具</h1>
  <p><b>🚀 一键下载、解压、更新 BPC 插件，轻松本地加载！</b></p>
</div>

---

## ✨ 功能亮点

• 自动下载最新版 BPC 插件包  
• 自动解压到指定文件夹（默认：<code>C:\CMD Tools</code>）  
• 支持 Chrome、Edge 浏览器手动加载或更新插件

---

## 🚀 快速上手

1. <b>下载本项目所有文件</b> 到本地任意文件夹。
2. <b>双击运行</b> <code>一键下载解压.bat</code>，或右键选择“使用 PowerShell 运行”。
3. 程序会自动下载并解压插件到 <code>C:\CMD Tools</code> 文件夹。
4. 打开 Chrome 或 Edge，访问扩展程序管理页面：<br>
	<code>chrome://extensions/</code> 或 <code>edge://extensions/</code>
5. <b>开启“开发者模式”</b>，点击“加载已解压的扩展程序”，选择 <code>C:\CMD Tools\bypass-paywalls-chrome-clean-master</code> 文件夹。
6. 如需更新插件，重复运行本工具即可。

---

## ⚠️ 注意事项

- 需联网，下载速度取决于网络状况。
- 默认解压路径为 <code>C:\CMD Tools</code>，如需更改请编辑 <code>download_script.ps1</code> 中的 <code>$targetFolder</code> 变量。
- 若遇到权限问题，请以管理员身份运行。
- 本工具不会自动打开浏览器或安装插件，仅负责下载与解压。

---

## 💡 常见问题

- <b>下载失败/超时</b>：请检查网络连接，或稍后重试。
- <b>找不到插件文件夹</b>：请确认 <code>C:\CMD Tools</code> 下有 <code>bypass-paywalls-chrome-clean-master</code> 文件夹。
- <b>浏览器无法加载</b>：请确保选择的是完整的插件文件夹，而不是压缩包或子文件夹。

---

## 📢 免责声明

本工具仅用于学习与研究，插件版权归原作者所有。请遵守相关法律法规，勿用于商业用途。

---
