---
title: leetcode刷题答案记录
date: 2019-04-28 14:59:22
updated: 2019-04-28 14:59:22
tags:
---

[TOC]

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
            if (**nums**[i] === target - nums[j]) {
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

## 第2题 两个链表求和

给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

这个题是参考答案做的。

```js
/*
 * @lc app=leetcode id=2 lang=javascript
 *
 * [2] Add Two Numbers
 */
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
    var List = new ListNode(0);
    var head = List;
    var sum = 0;
    var carry = 0;

    while (l1 !== null || l2 !== null || sum > 0) {
        if (l1 !== null) {
            sum = sum + l1.val;
            l1 = l1.next;
        }
        if (l2 !== null) {
            sum = sum + l2.val;
            l2 = l2.next;
        }
        if (sum >= 10) {
            carry = 1;
            sum -= 10;
        }

        head.next = new ListNode(sum);
        head = head.next;

        sum = carry;
        carry = 0;
    }
    return List.next;
};
```

## 第3题 查找字符串中子字符串最长长度

    刚开始的思路是放到map里，后来发现会有bdfb的情况，所以不能用map来判断是否存在，改为用数组判断是否存在，存在就从所在位置删除之前的数组

```js

/*
 * @lc app=leetcode id=3 lang=javascript
 *
 * [3] Longest Substring Without Repeating Characters
 */
/**
 * @param {string} s
 * @return {number}
 */
var lengthOfLongestSubstring = function(s) {
    let sArr = s.split('');
    let maxArr = [];
    let l = 0;
    let max = 0;
    for (let i = 0, il = sArr.length; i < il; i++) {
        let tmp = sArr[i];
        if (maxArr.includes(tmp)) {
            maxArr = maxArr.slice(maxArr.indexOf(tmp) + 1, maxArr.length);
            maxArr.push(tmp);
            l = maxArr.length;
        } else {
            maxArr.push(tmp);
            ++l;
        }
        if (l > max) {
            max = l;
        }
    }
    return max;
};


// 厉害的解法
function lengthOfLongestSubstring(s) {
    const map = {};
    let left = 0;

    return s.split('').reduce((max, v, i) => {
        left = map[v] >= left ? map[v] + 1 : left;
        map[v] = i;
        return Math.max(max, i - left + 1);
    }, 0);
}

```

## 4. 寻找两个有序数组的中位数

两个有序数组求中位数，
问题一般化为，求两个有序数组的第k个数，当k = (m+n)/2时为原问题的解。

怎么求第k个数？分别求出第一个和第二个数组的第 k / 2个数 a 和 b，然后比较 a 和 b，
当a < b ，说明第 k 个数位于 a数组的第 k / 2个数后半段，
或者b数组的 第 k / 2 个数前半段，问题规模缩小了一半，然后递归处理就行。 时间复杂度是 O(log(m+n))

[链接](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/solution/zhen-zheng-ologmnde-jie-fa-na-xie-shuo-gui-bing-pa/)

[解法二](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/solution/4-xun-zhao-liang-ge-you-xu-shu-zu-de-zhong-wei-shu/)：

将两个数组合成一个数组，用二分法查找中间位置的元素。(因为二分法的复杂度是O(log(m+n)))