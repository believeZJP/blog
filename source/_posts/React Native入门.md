---
layout: react
title: React Native入门
date: 2018-11-14 19:26:35
tags:
- react
- React Native
---
# 开发环境搭建

* Android studio
* python2
* java sdk 并配置java环境变量

```JavaScript
npm install -g react-native
npm install -g react-native-cli
```


# 启动虚拟器 
avd 是灰色 无法点击
配置AndroidSDK tools到path变量
删除.android文件，重新导入，即可

# 如果打包失败报错
```JavaScript
Error:Execution failed for task ':app:transformClassesWithInstantRunForAcproductionDebug'.
> Invalid signature file digest for Manifest main attributes
```
在android studio中的settings搜instant run，将enable instant run to hot swap关闭，取消选中。


# 调试js

打开模拟器后，按Ctrl+M,（ios按ctrl+D）

选择debug remote js.

浏览器会自动打开一个窗口，在那个窗口中按ctrl+shift+J ，在console窗口会看到打印出来的信息。

选择 Enable Hot Reloading,可以开启热加载

按(r,r) 刷新，（ios按command+r）


# 如果android模拟器无法连接本地服务
按ctrl+ M dev Setting 

Debug server host & port for device 

设置IP:8081



# 联调硬件
1. 先要给设备配网(按中间的按钮 5s)
2. 然后绑定设备



# react native 绑定事件

```JavaScript
onPressSwitch() {
    console.log('changed')
    let status =  this.props.powerStatus
    status == 'off' ? status = 'on' : status = 'off'
     this.props.callbackPowerChanged(status)
}

<!--之前的绑定事件是要用bind的 -->

 <TouchableOpacity onPress={this.onPressSwitch.bind(this)}>
        <Image  source={require('../../assets/light-close.png')}/>
        <Text style={styles.switchInfo}>轻触开启</Text>
</TouchableOpacity>
```

用es6的箭头函数之后，

```JavaScript
<!--这里是箭头函数-->
onPressSwitch = () => {
    console.log('changed')
    let status =  this.props.powerStatus
    status == 'off' ? status = 'on' : status = 'off'
     this.props.callbackPowerChanged(status)
}
```

这是用新的绑定 ，不要bind ，==[正确的写法]==

```JavaScript

 <TouchableOpacity onPress={this.onPressSwitch}>
        <Image  source={require('../../assets/light-close.png')}/>
        <Text style={styles.switchInfo}>轻触开启</Text>
</TouchableOpacity>
```

需要传参的写法 ==[传参的写法]==
```JavaScript
<TouchableOpacity onPress={() => this.onPressSwitch(item)}>
    <Image  source={getPicture('switch-'+item.status)}/>
</TouchableOpacity>
```
如果不传参的话，不能写为空如下：  ==[错误的写法]==
```JavaScript
<TouchableOpacity onPress={() => this.onPressSwitch}>
    <Image  source={getPicture('switch-'+item.status)}/>
</TouchableOpacity>
```
这样会无法进入点击事件！！！！！

解决办法就是不用() => {}

改用[正确的写法]




# setState 语法
setState括号里必须是个对象，不是会报错。
```JavaScript
this.setState({'item': newItem})
```

报错信息：
```JavaScript
setState(...): takes an object of state variables to update or a function which returns an object of state variables.
```

# 父与子组件传值

在父组件中定义props。通过props传入子组件中。

## 父组件传给子组件

父组件调用子组件
```JavaScript
<ControlArea powerStatus={this.state.powerStatus} callbackPowerChanged={this.changePowerStatus.bind(this)}></ControlArea>

```
其中powerSatatus是props，callbackPowerChanged是供子组件调用的方法。
changePowerStatus是在父组件中供子组件调用时执行的方法。


## 子组件调用父组件

子组件：
```JavaScript
onPressSwitch = () => {
   console.log('changed')
   let status =  this.props.powerStatus
   status == 'off' ? status = 'on' : status = 'off'

<!--这个是调用父组件的方法。把修改后的状态值传给父组件，供父组件修改状态，父组件修改状态后，子组件会自动根据状态值更新页面。-->
    this.props.callbackPowerChanged(status)
}
```
### 注意：

有些数据既可以放在pros，又可以放在state中，那么建议不要放在state中，

子组件修改props需调用父组件的方法，体现了从上至下的数据流


# 根据数组，循环生成dom
```JavaScript
<View style={[styles.topCon]}>
    {this.props.dataList.map((item, index) => (
        <TouchableOpacity key={index} onPress={() => this.onPressSwitch(item)}>
            <Image  source={getPicture('switch-'+item.status)}/>
            <Text style={styles.itemText}>{item.name}   ></Text>
        </TouchableOpacity>
    ))}
</View>
```
注意： 
- this.props.dataList是父组件传给子组件的数据。
- 循环数据用的map
- 一定要有key键值，否则报错
- 注意绑定事件的写法，会将当前循环的元素传给事件。注意箭头函数写法。




# 路由跳转
使用的是v0.50,官方推荐使用React Navigation

如果之前用的是其他路由，没有办法，只能全部换成这个了。

## 经验
如果一时半会看不明白的话，可以先照着官网和其他人的示例先做一个简单的出来，然后照着改项目里的代码。


### 遇到的问题

#### 1. 初始化导航后，需要给初始的组件传值。

看文档好不容易找到了screenProps.

 ```JavaScript
 <SimpleApp
  screenProps={{tintColor: 'blue'}}
/>
```

在组件内取值

```JavaScript
 this.state = {
    // deviceInfo: JSON.parse(this.props.deviceInfoStr), 其他路由的取值
    pageConfig: JSON.parse(this.props.screenProps.pageConfigStr),
    deviceInfo: JSON.parse(this.props.screenProps.deviceInfoStr),
}    
```

#### 2. 路由跳转

目前测试只能这样写，将navigate提取出来好像不可以。以后需做测试
```JavaScript
 render() {
    const { navigate } = this.props.navigation;
    return (
      <View>
        <Text>Hello, Chat App!</Text>
        <Button
          onPress={() => navigate('Chat')}
          title="Chat with Lucy"
        />
      </View>
    )
}    
```

#### 3. 导航跳转到的组件是父页面， 而子页面中想用导航的navigation，此时是无法用的，    需要在父组件中将navigation传给子组件，这样，子组件就可以用父组件的navigation

父组件中调用子组件，并把navigation传给子组件
```JavaScript
<Content pageConfig={this.state.pageConfig}
    navigation = {this.state.navigation}
    callbackPowerChanged={this.changePowerStatus.bind(this)}
/>
```

在子组件中
```JavaScript
 render() {
    const { navigate } = this.props.navigation
    
    return (
        <View style={[styles.container]}>
            <TouchableOpacity onPress={() =>{ console.log(this.props, 'click'); navigate('Detail', {info: '这是传入的参数'})}}>
                <Text style={styles.itemText}>啊啊</Text>
            </TouchableOpacity>
        </View>    
    )
}    
```

#### 4. 返回上一级
注意，用之前确保有navigation这个属性，没有的话看上面的例子。
```JavaScript
goBack = () => {
    this.props.navigation.goBack()
}

// 在按钮上加事件
onPress={this.goBack}
```




## 3.无关组件间传值

官方文档只找到这句话：

JavaScript模块可以通过使用DeviceEventEmitter模块来监听事件：

1. 引用
```JavaScript
import { View, DeviceEventEmitter } from 'react-native'
```

2. 监听事件
```JavaScript
componentDidMount() {
    this.subSwitchEmitter = DeviceEventEmitter.addListener('subSwitch', (e) => {
        this.changePowerStatus(e.item)
    });
    // 修改子页面名称用
    this.modifyItemEmitter = DeviceEventEmitter.addListener('modifyItemProp', (e) => {
        this.modifyItemProp(e.item)
    });
}
```
3. 触发监听事件，发出通知
```JavaScript
DeviceEventEmitter.emit('subSwitch', {item: this.state.item});
```

4. 移除监听
```JavaScript
 componentWillUnmount() {
    // 移除所有的事件
    DeviceEventEmitter.remove(); 
    // 单个移除
    this.subSwitchEmitter.remove();
    this.modifyItemEmitter.remove();
}
```
# ref的使用
1. 父传子，通过ref

```JavaScript
定义ref
<SonCompoent ref="son" />
获取子组件，执行指定方法，方法参数中传值
this.refs.son.receiveMoney(1000);
```

Ref 使用场景

1. 触发焦点，文本选择，媒体播放
2. 触发强制性动画
3. 集成第三方DOM库

给DOM 添加Refs,

[参考](https://www.jianshu.com/p/e5edfedc57a9)

# 弹框
用Modal组件


# mac配置连接windows的服务

```iOS
NSURL *jsCodeLocation;

[[RCTBundleURLProvider sharedSettings] setDefaults];
#if DEBUG
[[RCTBundleURLProvider sharedSettings] setJsLocation:@"192.168.1.101"];
#endif
jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
```


# reactnative 有的按钮点击事件无法触发

可能原因是布局问题，先给要点击的元素加边框，看所在位置，

再确认有没有其他元素占用了他的位置，遮挡在他上面了，导致无法点击。

# ios调试一直报无法连接package server，其实packageserver已经启动，
解决办法： 重新安装APP.



# setState设置状态后，直接console.log获取到的还是旧数据
```JavaScript
this.setState({data:data});
console.log(this.state.data);
```
解决办法：

setstate后，获取的数据还是旧的
原因：

1.setState异步调用 
2. 批量处理 并不是调用一次就会更新一次render

setState之后，需要走完RN生命周期，也就是走到render时，state的值才会变成setState的值，要立即使用state的值，需要直接更改，也即this.state.something = 'now';
这个没试过

正确写法
```JavaScript
this.setState(state,()=>{
    console.log(this.state);
});

this.setState({'dataList': this.state.lastStatus}, ()=>{
    console.log(this.state.dataList, '回调')
    this.changeBgColor()
})
```

## 第二种办法
在store中定义，根据action请求返回的值 ，根据逻辑处理需要显示的值


# mac调试总是提示：Xcode Error输出
```
Runtime is not ready for debugging. Make sure Packager server is running.
```
解决办法

在RCTWebSocketExecutor.m文件中，把localhost修改为与AppDelegate.m中相同的IP地址(一般为电脑IP).

```
    NSString *host = [[_bridge bundleURL] host] ?: @"localhost;

```

```
    NSString *host = [[_bridge bundleURL] host] ?: @"172.16.126.97";

```
http://www.jianshu.com/p/90ceb04da552


## 上行 下行

设备发给云端 设备上报 上行

app或者云端给设备发消息属于下行

# 修改为redux后，思路整理
我有一个state(deviceData),设备端有个对应的state,
deviceProperty 也有个对应的state,

然后三者要统一。


先在deviceProperty中根据设备返回的设置一模一样的参数，
，然后等上报以后根据不同的值，再整理值放到state中。

页面渲染，根据deviceProperty进行渲染。


最终结果，都放到了deviceProperty中了。


# 引入Redux后数据处理逻辑！！！

### 原来用父子组件处理state
1. 父组件中存有父组件相关的state, 子组件相关的state,
2. 子组件用父组件中的state时，父组件通过prop传给子组件
3. 子组件要修改父组件时，通过父组件传递过来的事件，调用父组件定义好的事件，由父组件更改状态， 子组件自动更新
4. 子组件中可以有一套自己的state

# redux的数据处理逻辑
1. 所有的数据都在store中定义好,可以有不同的对象
```JavaScript
const initState = {
    deviceInfo: {
        deviceId: 0,
    },
    deviceProperty: {
        id: 0,
        timestamp: 0,
        finalColor: 'rgba(56,171,193,0.90)',
    },
}

export default initState
```
在store中引用
```JavaScript
const store = createStore(
    reducers,
    initState,
    applyMiddleware(
        thunk,
        createPromise(),
        createLogger()
    )
)

export default store
```
2. 要更改store中的数据，都通过action去调用事件触发
```JavaScript
const powerOn = (subDomainName, physicalDeviceId, command) => ({
    type: types.powerOn,
    payload: {
        promise: BindManager.sendDevice(
            subDomainName,
            physicalDeviceId,
            {
                code: command.code,
                content: new Uint8Array(command.content)
            }
        ),
        data: {
        }
    }
})

```
3. action请求回调返回结果，根据返回成功失败，在reducer中分别处理store中的数据。
```JavaScript
case `${types.powerOn}_PENDING`:
    return Object.assign({}, state, {
        isFetching: true,
    })

case `${types.powerOn}_FULFILLED`:
    return Object.assign({}, state, {
        powerStatus: 'on',
        lineStart: state.finalColor,
        lineEnd: state.finalColor,
        isFetching: false
    })

case `${types.powerOn}_REJECTED`:
    if(action.payload.errorCode){
        console.log(getInfoByCode(action.payload.errorCode), '信息')
    }
    return Object.assign({}, state, {
        isFetching: false,
        toastTip: {
            showNum: state.toastTip.showNum + 1,
            text: '开启失败.'+action.payload
        }
    })
```



## 开关逻辑修改

设备只要传 id，对应的开关值，0,1 就行。

对应到代码：

发送command时，需要组合好开关id，状态。

指令发送成功需要根据开关id和值改变store中的值。

还要进行背景颜色的判断。

尼玛，修改名称找谁改。---干掉了

# 子页面的开关控制逻辑修改

之前是用的navigation将当前点击的item传入子页面

传入后根据事件监听触发修改，
用的是 ==DeviceEventEmitter== , 

改成redux后，

直接在store中读取props的属性根据传入item 的id找到当前的item,根据不同的状态值，

(注意，此处传入也是通过navigation传入的。)

再子页面中直接发送action，

reducer修改store中的数据后，

在子页面中用 ==componentWillReceiveProps== 来监听数据的变化，并根据相应的值，来切换状态。


# 国际化插件[react-native-i18n](https://www.npmjs.com/package/react-native-i18n)
这个插件需要改动android和iOS 的代码！！！！

1. 安装
    npm install react-native-i18n --save
2. 关联android
    react-native link
    
    注意： 这里执行命令后，android测试会报错。

    根据文档挨个检查对应的文件夹，看哪个没有添加，添加对应的调用语句即可。
    
    ./android/settings.gradle
    
    ./android/app/build.gradle
    
    (我这里↑没有自动添加，手动添加的)
    
    ./android/app/src/main/java/your/bundle/MainApplication.java

3. IOS还没有测试

## 使用

### 1. 封装一个单独的js出来，

新建一个文件夹i18n

index.js
```
import i18n from 'react-native-i18n';
import translations  from './translations';

// 这个为默认，的如果没有找到对应的语言，则为默认的。
i18n.defaultLocale = 'en';

i18n.fallbacks = true;
i18n.translations = {
    en: translations.en,
    zh: translations.zh,
};

export default i18n;

```
### 2. translations为中英文对应的文字信息

translations.js
```JavaScript
export default {
    en: {
        greeting: 'Greeting in en',
        exit: 'exit?',
        tapSwitch: 'Tap to switch',
        Switch: 'Switch',
        Timing: 'Timing',
        Countdown: 'Countdown',
    },
    zh: {
        greeting: '欢迎欢迎热烈欢迎',
        exit: '是否退出?',
        tapSwitch: '轻触可开关',
        Switch: '开关',
        Timing: '定时',
        Countdown: '倒计时',
    },
};
```
注意，这里的中英文可以单独出来，做成两个单独的文件。
zh.js
```JavaScript
export default {
    greeting: '欢迎欢迎热烈欢迎',
    exit: '是否退出?',
    tapSwitch: '轻触可开关',
    Switch: '开关',
    Timing: '定时',
    Countdown: '倒计时',
};
```
en.js

```JavaScript
export default {
    greeting: 'Greeting in en',
    exit: 'exit?',
    tapSwitch: 'Tap to switch',
    Switch: 'Switch',
    Timing: 'Timing',
    Countdown: 'Countdown',
};
```

在单独引入文件
```JavaScript
import i18n from 'react-native-i18n';
import en from './en';
import zh from './zh';

i18n.defaultLocale = 'en';
i18n.fallbacks = true;
i18n.translations = {
    en,
    zh,
};

export default i18n;
```

## 3. 业务层调用

```JavaScript
import {i18n} from '你预设的index的目录';

// js
i18n.t('Timing')
// html
<Text style={styles.text}>{i18n.t('Timing')}</Text>

```

### 总结

首先Native那里获取本手机的LocaleList然后格式化取第一个元素交由I18n.js处理，

然后I18n.js根据key选用一套有效的语言规则，

再之后流程就和使用时候的顺序一样了。 

# toast插件 [react-native-easy-toast](https://www.npmjs.com/package/react-native-easy-toast)

这个插件不需要改动android和ios代码

1. 安装
```JavaScript
npm i react-native-easy-toast --save
```

2. 引用
```JavaScript
import Toast, {DURATION} from 'react-native-easy-toast'
```
在html中需要写在View底部引用
```JavaScript
<Toast ref="toast"/>
```
3. js调用显示
```JavaScript
// 默认250ms消失
 this.refs.toast.show('hello world!');
 
 // 不消失
 this.refs.toast.show('hello world!', DURATION.FOREVER);
  
 // 默认2s消失
 this.refs.toast.show('hello world!', DURATION.LENGTH_LONG); 

// 自定义时间消失
 this.refs.toast.show('hello world!', 3000); 
```

### 问题：
在position设置为居中时，是去掉导航栏以外的区域居中的，所以感觉整体偏下，
可以改源码里的position为center时，减去positionValue的值。


但打包时怎么办，好像看到有的demo里是居中的，也有可能是自己代码css问题。



# 硬件APP开发功能点

1. 第一次打开APP获取设备状态，所有属性值都要
2. 设备不在线时对页面遮罩，禁用所有功能，
3. 设备上报获取所有属性，并根据不同值重置页面
4. 设备发送指令，成功后，修改APP状态
5. 失败后，提示信息显示，不能更改APP状态



# PropTypes

在编写组件时，希望每个地方都能用到，但别人怎么用，就不知道了。
所以需要制定一些规则，比如必须传什么参数，参数是什么类型的。

因为JavaScript语言特点，这种情况下，页面虽显示不正常，但不会报错。很难找到bug位置。

react提供了一种类型检测机制，用来确保接收到的参数是有效的。

例如，我们可以使用PropTypes.string 语句。当给 prop 传递了一个不正确的值时，JavaScript控制台将会显示一条警告。出于性能的原因，propTypes 仅在开发模式中检测。

首先，要安装react提供的第三方库 prop-types：(貌似只针对15.5.0之后的版本，公司项目15.4.2 并不需要install， 直接用就行了）
```
npm install --save prop-types
```

使用

```JavaScript
import PropTypes from 'prop-types';

class Greeting extends React.Component {
  render() {
    return (
      <h1>Hello, {this.props.name}</h1>
    );
  }
}

Greeting.propTypes = {
  name: PropTypes.string
};
```
1. React.PropTypes.element.isRequired，可以为组件指定必须项
2. defaultProps：为props指定一个默认值
```JavaScript
Greeting.defaultProps = {
  name: 'Stranger'
};
```




adb.exe
目录
C:\Users\z\AppData\Local\Android\Sdk\platform-tools
添加到系统环境变量，可以直接执行adb命令

adb install -r name.apk 
用命令行安装apk



# js用switch case实现区间

重点是switch(true){}
```javascript
function getAQIDegree(jq){
    switch(true){
        case jq<51:
            return '优'
            break
             
        case jq<101:
            return '良'
            break
        case jq<151:
            return '轻度污染'
            break
        case jq<201:
            return '中度污染'
            break
        case jq<301:
            return '重度污染'
            break
        case 300<jq:
            return '严重污染'
            break
        default:
            break

    }
}

```