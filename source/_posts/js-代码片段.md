---
title: js 代码片段
date: 2019-06-20 16:03:49
updated: 2019-06-20 16:03:49
tags:
---
## js比较版本号

```js
/**
 * 版本比较 versionCompare
 * @param {String} currVer 当前版本.
 * @param {String} promoteVer 比较版本.
 * @return {Boolean} false 当前版本小于比较版本返回 true.
 *
 * 使用
 * versionCompare("6.3","5.2.5"); // false.
 * versionCompare("6.1", "6.1"); // false.
 * versionCompare("6.1.5", "6.2"); // true.
 */
function versionCompare(currVer = '0.0.0', promoteVer = '0.0.0') {
    if (currVer === promoteVer) {
        return false;
    }
    const currVerArr = currVer.split('.');
    const promoteVerArr = promoteVer.split('.');
    const len = Math.max(currVerArr.length, promoteVerArr.length);
    // ~是按位取反的意思，计算机里面处理二进制数据时候的非，
    // ~~利用两个按位取反的符号，进行类型的转换，转换成数字
    for (let i = 0; i < len; i++) {
        // 将比较对象转成数字
        const proVal = ~~promoteVerArr[i];
        const curVal = ~~currVerArr[i];
        if (proVal < curVal) {
            return false;
        }
        else if (proVal > curVal) {
            return true;
        }
    }
    return false;
}
```
