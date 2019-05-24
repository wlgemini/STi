# STi

Swift templet for iOS app.

## Pods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/wlgemini/Specs.git'

target 'MyApp' do
  use_frameworks!

  pod 'STi'
end
```

## Usage

### Configs

其实是一些空类，主要用于配制信息归类到这些类中。

`Config`: 主要保存一些默认配置信息，比如保存一个scheme字段

`Api`: 用于保存网络请求接口

`Color`: 用于保存app主题颜色配置

`Font`: 用于保存字体相关配置

### Views

如：`EdgeInsetsLabel`, `CountDownButton`, `CollectionViewCell`, `Window`

### Controllers

`ViewController`: 一个基础的VC，提供了相对规范的页面初始化调用方法，内置会自动取消的网络请求方法，自动移除通知

`GenericViewController`: 基于`ViewController`的范型VC，可以范型一个ContentView，该VC主要用于实现与View的分离

### Network

封装的`Alamofire`框架, app初始化时需要进行一些配置

### Util

内置了常用的工具方法，如`debugOnly()`方法，`log()`方法，相关的异步方法如`asyncInMain()`等

```swift
Util.asyncInMain {
    // some code here
}
```

### Extenion

很多扩展方法，会根据需要逐步增加。

## License

STi is available under the MIT license. See the LICENSE file for more info.
