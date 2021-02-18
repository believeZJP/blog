---
title: CSRF
date: 2021-01-21 11:00:29
updated: 2021-01-21 11:00:29
tags:
---
## CSRF 简介

跨站请求伪造（Cross-site request forgery），通常缩写为 CSRF 或者 XSRF， 是一种挟制用户在当前已登录的 Web 应用程序上执行非本意的操作的攻击方法。
跨站请求攻击，简单地说，是攻击者通过一些技术手段欺骗用户的浏览器去访问一个自己曾经认证过的网站并运行一些操作（如发邮件，发消息，甚至财产操作如转账和购买商品）。由于浏览器曾经认证过，所以被访问的网站会认为是真正的用户操作而去运行。

攻击者利用了 Web 中用户身份验证的一个漏洞：简单的身份验证只能保证请求发自某个用户的浏览器，却不能保证请求本身是用户自愿发出的。

<!-- more -->

## CSRF 防御措施

### 1. 检查 Referer 字段

HTTP 头中有一个 Referer 字段，这个字段用以标明请求来源于哪个地址。在处理敏感数据请求时，通常来说，Referer 字段应和请求的地址位于同一域名下。

如果是 CSRF 攻击传来的请求，Referer 字段会是包含恶意网址的地址，不会位于同一域名之下，这时候服务器就能识别出恶意的访问。

这种办法简单易行，仅需要在关键访问处增加一步校验。但这种办法也有其局限性，因其完全依赖浏览器发送正确的 Referer 字段。虽然 HTTP 协议对此字段的内容有明确的规定，但并无法保证来访的浏览器的具体实现，亦无法保证浏览器没有安全漏洞影响到此字段。并且也存在攻击者攻击某些浏览器，篡改其 Referer 字段的可能。

### 2. 同步表单 CSRF 校验

同步表单 CSRF 校验 就是在返回页面时将 token 渲染到页面上，在 form 表单提交的时候通过隐藏域或者作为查询参数把 CSRF token 提交到服务器。比如，在同步渲染页面时，在表单请求中增加一个 _csrf 的查询参数，这样当用户在提交这个表单的时候就会将 CSRF token 提交上来：

### 3. 双重 Cookie 防御

双重 Cookie 防御 就是将 token 设置在 Cookie 中，在提交（POST、PUT、PATCH、DELETE）等请求时提交 Cookie，并通过请求头或请求体带上 Cookie 中已设置的 token，服务端接收到请求后，再进行对比校验。

jQuery 设置 csrfToken:

```js
let csrfToken = Cookies.get('csrfToken');

function csrfSafeMethod(method) {
  // 以下HTTP方法不需要进行CSRF防护
  return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
}

$.ajaxSetup({
  beforeSend: function(xhr, settings) {
    if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
      xhr.setRequestHeader('x-csrf-token', csrfToken);
    }
  },

```

Axios 也是通过`双重 Cookie 防御`进行防御

```js
// lib/adapters/xhr.js
module.exports = function xhrAdapter(config) {
  return new Promise(function dispatchXhrRequest(resolve, reject) {
    var requestHeaders = config.headers;
    
    var request = new XMLHttpRequest();
    // 省略部分代码
    
    // 添加xsrf头部
    if (utils.isStandardBrowserEnv()) {
      var xsrfValue = (config.withCredentials || isURLSameOrigin(fullPath)) && config.xsrfCookieName ?
        cookies.read(config.xsrfCookieName) :
        undefined;

      if (xsrfValue) {
        requestHeaders[config.xsrfHeaderName] = xsrfValue;
      }
    }

    request.send(requestData);
  });
};
```
