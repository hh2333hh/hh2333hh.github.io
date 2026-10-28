# 树木与森林 · 个人博客

用 Hugo 生成静态网站，用 Markdown 写文章，通过 GitHub Pages 自动发布。包括首页、博客、作品和关于我，以及文章目录、标签、归档和手机排版。

## 网站页面

| 页面 | 路径 | 内容来源 |
| --- | --- | --- |
| 首页 | `/` | 网站首页模板 |
| 博客 | `/posts/` | `content/posts/` |
| 作品 | `/projects/` | `content/projects/` |
| 关于我 | `/about/` | `content/about.md` |
| 归档 | `/archives/` | 自动按文章日期生成 |
| 标签 | `/tags/` | 自动根据文章的 `tags` 生成 |

首页、作品和关于我的内容可逐步完善；博客文章仍按下文的方式写作和发布。

## 在电脑上预览

在 PowerShell 中进入本项目目录：

```powershell
cd D:\WorkingDocument\personal-blog
.\scripts\hugo.ps1 server --buildDrafts
```

打开终端显示的本地网址，通常是 `http://localhost:1313/`。保存文章后，页面会自动更新；按 `Ctrl+C` 停止预览。

脚本优先使用项目中的 `.tools\hugo\hugo.exe`，其次使用已安装的 Hugo。重新下载项目时，先从 [Hugo 官方发布页](https://github.com/gohugoio/hugo/releases/tag/v0.167.0) 下载 Windows amd64 标准版，将 `hugo.exe` 解压到 `.tools\hugo\`。本地与自动发布统一使用 0.167.0。

## 写一篇文章

```powershell
.\scripts\new-post.ps1 -Title '我的第一篇文章' -Slug 'my-first-post'
```

文章创建在 `content/posts/my-first-post/index.md`。`Slug` 是网址中的短名称，只用小写英文字母、数字和连字符。已有目录不会被覆盖。

每篇文章开头填写这些信息：

```yaml
---
title: "我的第一篇文章"
date: 2026-10-28T10:00:00+08:00
description: "这篇文章的简短介绍。"
tags: ["生活", "读书"]
draft: true
---
```

分隔线下方是 Markdown 正文。写好后把 `draft: true` 改成 `draft: false`，再将修改同步到 GitHub。未来日期的文章要到对应日期后重新构建才会发布，不会自动定时上线。

图片和文章放在同一个目录，正文中这样引用：

```markdown
![图片说明](example.png)
```

草稿可以通过带 `--buildDrafts` 的本地预览查看，但不会进入正式构建。`draft` 只控制网页是否发布，公开仓库里的源文件仍然公开。

## 修改博客名称

编辑 `hugo.toml` 中的 `title`、`[params]` 下的描述和作者信息。首页大标题由 `homeTitle`、`homeSubtitle` 两行组成，介绍文字是 `homeDescription`。文章内容在 `content/posts/`，样式在 `assets/css/main.css`。

作品内容放在 `content/projects/`，个人介绍编辑 `content/about.md`。维护这些 Markdown 文件后，同步到 GitHub 即可更新对应页面。

关于页在桌面上采用左侧个人简介、右侧正文的排版，在手机上自动合为单栏。个人介绍、兴趣和“找到我”中的联系方式直接编辑 `content/about.md` 正文；顶部的 `title`、`displayName`、`shortBio`、`focus` 分别控制页面标题、名字、短句和关注方向，填写 `description` 时会优先用它替代短句。

博客文章《树木与森林》的文件是 `content/posts/树木与森林.md`，可以直接编辑。作品页目前展示「树木与森林」博客。

添加作品时，在 `content/projects/作品英文短名/index.md` 中填写 `title`、`date`、`description`、`projectType` 和 Markdown 正文。可参考现有的 `content/projects/suiji/index.md`。

RSS 只订阅博客文章，不会把关于页和作品混入文章订阅。

## 发布到 GitHub Pages

网站地址：[hh2333hh.github.io](https://hh2333hh.github.io/)。源代码仓库：[hh2333hh/hh2333hh.github.io](https://github.com/hh2333hh/hh2333hh.github.io)。本地目录已关联该仓库的 `main` 分支。

修改文章或页面并保存后，在本项目的 PowerShell 中运行：

```powershell
git add --all
git commit -m "更新博客"
git push origin main
```

推送会触发 `.github/workflows/pages.yaml`，由 GitHub Actions 构建并发布。可在仓库的 [Actions 页面](https://github.com/hh2333hh/hh2333hh.github.io/actions) 查看进度；Pages 的发布源设为 **GitHub Actions**。不要上传 `.tools/`、`.preview/`、`tmp/`、`public/` 或 `resources/` 等本地工具和生成文件；`.gitignore` 已配置排除。

原课程作业的根目录文件与提交历史继续保留，`static/` 下另有这些页面和图片的发布副本，使原有 HTML 链接继续可用。旧版仓库说明保存在 `legacy/README.md`。

发布配置会从 GitHub Pages 自动取得网站地址。本地 `hugo.toml` 中的 `baseURL` 也已设为正式网址；需要自定义域名时，在 Pages 设置中绑定并同步修改它。

本地检查正式构建：

```powershell
.\scripts\hugo.ps1 --gc --minify
```

生成的网站在 `public/`。开发预览、构建和创建文章都在项目目录内完成，不修改系统设置。
