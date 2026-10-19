# 春末夏初 CHUNMO XIACHU · Flutter Web 企业官网

以「春末夏初」品牌呈现的 Flutter Web 企业官网（视觉参考：<https://liangzhu.me/?lang=zh>），
部署在 GitHub Pages：<https://chunmoxiachu.github.io/>

## 快速开始

```bash
flutter pub get
flutter run -d chrome --web-port 8080     # 本地预览
flutter analyze && flutter test           # 静态检查与内容测试
flutter build web --release --base-href / # 生产构建（产物在 build/web）
```

本地预览深链接（如 `/about`）时，请用带 SPA 回退的静态服务器，或直接访问 `/#` 之外的路径后刷新；
线上通过 GitHub Pages 的 `404.html` 回退实现，见 workflow。

## 目录结构

```
lib/
  main.dart              # 入口：路径 URL 策略（干净链接 /about?lang=zh）
  app.dart               # 路由表、URL 与语言的同步、全局 AppScope
  core/
    theme.dart           # 调色板（明亮/暗色）、字体、断点
    content.dart         # 中英双语全部文案与结构化内容
    app_state.dart       # 语言 + 明暗主题状态
    nav.dart             # 保留 ?lang= 的跳转与外部链接
  widgets/
    site_shell.dart      # 页面外壳：背景、网格、固定顶栏/底栏
    site_chrome.dart     # 顶栏、北京时间时钟、滚动进度、全屏菜单
    primitives.dart      # 按钮、链接、入场动画、光束、贴纸等
    page_parts.dart      # 子页共用：标题区、步骤列表、尾部 CTA、页脚
  sections/              # 首页六个区块（Hero / 关于 / 服务 / 内容 / 方法 / 联系）
  pages/                 # 路由页面（首页、关于、服务详情、内容、法务、404）
assets/
  brand/                 # 品牌插画、贴纸、头像、微信二维码（WebP）
  glass/                 # 由原站 GLB 模型离线渲染的 3D 玻璃字（PNG）
  fonts/                 # TikTok Sans / Geist Mono / Departure Mono + Noto Sans SC 子集
tool/subset_cjk_font.py  # 重新生成中文子集字体（新增中文文案后运行）
```

## 路由

| 路径 | 页面 |
| --- | --- |
| `/` | 首页（Hero、关于、服务、内容、方法、联系） |
| `/about` | 关于与联系 |
| `/services/consulting` `/services/training` `/services/fde` | 服务详情 |
| `/library` 与 `/go-global` `/learn-ai` `/geo-wiki` `/blog` | 内容与学习 |
| `/privacy` `/terms` | 隐私说明、使用说明 |

任意页面可加 `?lang=zh` / `?lang=en` 深链接；顶栏语言切换会同步地址栏参数。

## 部署

推送到 `main` 分支后，`.github/workflows/deploy.yml` 会执行 `flutter analyze`、
`flutter test`、`flutter build web --release --base-href /`，把 `build/web`
（含用于 SPA 深链接的 `404.html`）发布到 GitHub Pages。

首次启用需在仓库 **Settings → Pages → Build and deployment** 选择 **GitHub Actions**。

## 素材与字体说明

- 页面视觉素材（插画、贴纸、二维码与 3D 玻璃字）取自参考站点 <https://liangzhu.me/>，
  仅用于这次复刻演示；商用或正式上线前请替换为自有素材，或取得原作者授权。
- 头像、微信二维码属于个人信息，如需公开部署请替换成占位图。
- 字体：TikTok Sans、Geist Mono、Departure Mono 来自原站；中文回退使用
  [Noto Sans SC](https://fonts.google.com/noto/specimen/Noto+Sans+SC)（SIL Open Font License 1.1），
  已按站点用字裁剪为子集，可用 `tool/subset_cjk_font.py` 重新生成。
