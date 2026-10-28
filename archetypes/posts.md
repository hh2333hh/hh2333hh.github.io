---
title: {{ with getenv "HUGO_NEW_POST_TITLE" }}{{ . | jsonify }}{{ else }}{{ .Name | humanize | jsonify }}{{ end }}
date: {{ .Date }}
description: "用一两句话概括这篇文章。"
tags: []
draft: true
---

在这里写下正文。

## 一个小标题

继续记录你的想法。
