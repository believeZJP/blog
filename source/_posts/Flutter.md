---
title: Flutter
date: 2021-05-13 15:54:44
updated: 2021-05-13 15:54:44
tags:
---
## 安装踩坑

由于mac终端是zsh,所以添加path变量要添加到`~/.zprofile`中

```bash
# Flutter
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH="$PATH:/Applications/flutter/flutter/bin"
```
