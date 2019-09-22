《IT换换》基于Flutter开发，是一款完全开源、跨平台的一个资源共享社区APP，目前项目还是初期阶段，项目搜集全网的精品资源教程，进行筛选分类，让用户可以快速找到自己中意的资源（可以快速导出android版本、iOS版本），如果你喜欢或项目对你有帮助，欢迎给个star鼓励一波~~~

## 下载
![android 下载二维码](screenshots/apk_download.png)

* 因为苹果审核不可抗力的原因，暂不上线

## 版本更新记录
**1.** [注册增加验证码和忘记密码流程](https://www.jianshu.com/p/84393a45935f)

## 先上图
![1.png](screenshots/1.jpg)

![2.png](screenshots/2.jpg)

![3.png](screenshots/3.jpg)

## 项目结构
```
├── common - 一些通用的常量定义
├── model - 项目中使用的后台返回的数据模型
├── net - 基于dio的网络请求封装
│   └── interceptors - 网络请求的拦截器
├── pages  - 页面
│   ├── classify - 分类页面
│   ├── create - 资源创建编辑页面
│   ├── detail - 资源详情页面
│   ├── home - 首页
│   ├── login - 登录注册页面
│   ├── my_product_list - 我发布资源列表页面
│   ├── profile - 个人中心页面
│   └── web - web页面
├── route - 基于fluro的路由
├── utils - 项目中使用的工具类
├── vo - 前端页面组合的VO
└── widgets - 一些通用Widget
```

## JSON 数据解析
项目开发过程中，使用json_serializable，但在编写模型的时候依然较为繁琐，索性在之前[JSONConverter](https://github.com/iosyaowei/JSONConverter)添加了对Flutter的支持。
JSONConverter 是MAC上iOS开发的辅助小工具，可以快速的把JSON数据转换生成对应的模型类属性，目前支持Objective-C、Swift、Flutter以及目前流行的Swift第三方库: [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)、[HandyJSON](https://github.com/alibaba/HandyJSON)，[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper),可以灵活选择构建class/struct，并支持配置类名前缀等,省去手敲模型的麻烦，借此提高我们的开发效率。

![4.png](screenshots/4.png)

## 待完成事项
1. 注册邮箱验证码功能 (v1.0.1已完成)
2. 资源评论功能
3. 基于微信的资源详情H5分享
4. 收藏功能
5. 搜索功能
6. 。。。

## 第三方声明
*  cached_network_image: ^1.1.0
*  pull_to_refresh: ^1.3.3
*  dio: ^2.1.1
*  shared_preferences: ^0.4.2
*  connectivity: ^0.4.3+6
*  event_bus: ^1.1.0
*  json_annotation: ^2.0.0
*  intl: ^0.15.8
*  flutter_spinkit: "^3.1.0"
*  oktoast: ^2.1.9
*  image_picker: ^0.6.0+10
*  multi_image_picker: ^4.5.1
*  flutter_webview_plugin: ^0.3.5
*  flutter_swiper : ^1.1.6
*  fluro: "^1.5.1"

## 注意
* 源码仅作学习，接口进行次数限制.

## 开源协议
```
BSD License

Copyright (c) 2019-present, IT Resource Exchange Group Holding Limited. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

 * Neither the name of the copyright holder nor the names of its contributors may be used to
   endorse or promote products derived from this software without specific
   prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
```
