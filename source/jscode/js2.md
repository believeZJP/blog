js 通过匿名空间隔开公有私有

```JavaScript
(function() {
    var abc = 5;
    function TabView(cfg) {
        this.a = cfg.a;
        this.b = cfg.b;
    }

    TabView.prototype = {
        c: function() { abc++;},
        d: function() { abc--;}
    }

    window.TabView = TabView;
})();


(function() {
    var abc = 100;
    function TreeView(cfg) {
        this.a = cfg.a;
        this.b = cfg.b;
    }

    TreeView.prototype = {
        c: function() { abc *= 2;},
        d: function() { abc /= 2;}
    }

    window.TreeView = TreeView;
});
```

# 基于 require.js 重写代码

```javascript
// animate.js
define(function() {
  function Animate() {}
  return { Animate: Animate };
});

// treeview.js
define(function() {
  function TreeView() {}
  return {
    TreeView: TreeView
  };
});

// tabview.js
define(["animate"], function(a) {
  function TabView() {
    this.animate = new a.Animate();
  }
  return {
    TabView: TabView
  };
});

// main.js
require(["tabview", "treeview"], function(tab, tree) {
  var tabView = new tab.TabView(),
    treeView = new tree.TreeView();
});
```
