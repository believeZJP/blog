---
title: Bundler源码编写
date: 2019-11-28 17:16:30
updated: 2019-11-28 17:16:30
tags:
---

安装依赖-[相关文档](https://babeljs.io/docs/en/babel-parser)

`npm install @babel/parser @babel/traverse @babel/core @babel/preset-env --save`

index.js

```js
import message from './message.js';
console.log(message);
```

message.js

```js
import { word } from './word.js';
const message = `say ${word}`;
export default message;
```

<!-- more -->

word.js

```js
export const word = 'hello';
```

bundler.js

```js
const fs = require('fs');
const path = require('path');
const parser = require('@babel/parser');
const babel = require('@babel/core');
const traverse = require('@babel/traverse').default;

// 分析入口文件和依赖
const moduleAnalyser = (filename) => {
    // 读取文件内容
    const content = fs.readFileSync(filename, 'utf-8');
    // 使用babel解析文件成抽象语法树
    const ast = parser.parse(content, {
        sourceType: 'module'
    });
    const dependencies = {};
    traverse(ast, {
        // 声明
        ImportDeclaration({ node }) {
            // 获取绝对路径的文件
            const dirname = path.dirname(filename);
            const newFile = './' + path.join(dirname, node.source.value);
            dependencies[node.source.value] = newFile;
        }
    });
    // babel转化es6代码到es5
    const { code } = babel.transformFromAst(ast, null, {
        presets:: ['@babel/preset-env']
    });
    // 返回入口文件和依赖文件
    return {
        filename,
        dependencies,
        code
    }

}
// 测试入口文件解析是否正常
// moduleAnalyser('./src/index.js');

// 依赖图谱，分析入口文件及入口文件中引入文件的依赖
const makeDependenciesGraph = (entry) => {
    const entryModule = moduleAnalyser(entry);
    const graphArr = [entryModule];
    for(let i = 0; i < graphArr.length; i++) {
        const item = graphArr[i];
        const { dependencies } = item;
        if (dependencies) {
            for(let j in dependencies) {
                graphArr.push(moduleAnalyser(dependencies[j]));
            }
        }
    }
    const graph = {};
    graphArr.forEach(item => {
        graph[item.filename] = {
            dependencies: item.dependencies,
            code: item.code
        };
    });
    return graph;
};

// 生成最终的代码
const generageCode = (entry) => {
    const graph = JSON.stringify(makeDependenciesGraph(entry));
    // 拿到entry, 执行entry对应的代码
    return `
        (function(graph) {
            function require(module) {
                function localRequire(relativePath) {
                    return require(graph[module].dependencies[relativePath]);
                }
                var exports = {};
                (function(require, exports, code){
                    eval(code)
                })(localRequire, exports, graph[module].code)
                return exports;
            };
            require('${entry}');
        })(${graph});
    `;
}
// const graphInfo = makeDependenciesGraph('./src/index.js');
const code = generageCode('./src/index.js');

```
