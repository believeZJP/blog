---
title: leetcode刷题答案记录
date: 2019-04-28 14:59:22
updated: 2019-04-28 14:59:22
tags:
---

# LeetCode刷题答案记录

## 第一题 求和，在数组中找两个元素加起来等于一个数

```js
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 * 暴力查找，循环两次
 * 时间复杂度O(n^2)， 空间复杂度：O(1)
 */
var twoSum = function(nums, target) {
    let i = 0, il = nums.length, sumArr = [];
    for(; i < il; i++ ) {
        for (let j = i + 1; j < il; j++) {
            if (nums[i] === target - nums[j]) {
                return [i, j];
            }
        }
    }
    throw Error('not find~');
};



/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 * 匹配不到的存入map, 循环的时候去map里找是否有匹配的
 * 时间复杂度：O(n)
 * 空间复杂度：O(n) 所需的额外空间取决于哈希表中存储的元素数量，该表最多需要存储 n 个元素。
 */
var twoSum = function(nums, target) {
    let arrObj = {}, i = 0, il = nums.length;
    for(; i < il; i++ ) {
        let extra = target - nums[i];
        // 放进去的值可能是0，不能用if(arrObj[extra]) 判断是否有值
        if (arrObj[extra] !== undefined) {
            // 放入数组的顺序，前面的先放进去的，所以i在后面
            return [arrObj[extra], i];
        }
        arrObj[nums[i]] = i;
    }
};
```
