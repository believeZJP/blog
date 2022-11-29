---
title: Flutter
date: 2021-05-13 15:54:44
updated: 2021-05-13 15:54:44
tags:
---

flutter

在Android studio 直接点Flutter Attach即可打开调试模式

## 安装踩坑

由于mac终端是zsh,所以添加path变量要添加到`~/.zprofile`中

```bash
# Flutter
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH="$PATH:/Applications/flutter/flutter/bin"
```

## 在Android studio 查看日志的方法

代码中用 `print('右侧更新${d}');`

`${d}是变量`

在控制台输入`flutter logs`即可查看

flutter 空安全检查
`https://blog.csdn.net/win7583362/article/details/118365693`

## 跑马灯

[链接](<https://github.com/akindone/flutterMarquee>)

```flutter
GestureDetector(
onTap: () => showDialog<String>(
  context: context,
  builder: (BuildContext context) => AlertDialog(
    title: const Text('AlertDialog Title'),
    content: Text('左边图：${model.data.left.imageUrl}---右边金币值${model.data.right.balanceString}'),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  ),
),

```

import 'package:fluttertoast/fluttertoast.dart';

Fluttertoast.showToast(
          msg: model.data.left.imageUrl,
          gravity: ToastGravity.CENTER,
        );

```js
// 截取数组

var firstRow = model.data.menus.sublist(0, lineMax);
var endPosition = 2 * lineMax;
if (model.data.menus.length < 2 * lineMax) {
  endPosition = model.data.menus.length;
}
var secondtRow = model.data.menus.sublist(lineMax, endPosition);

```
