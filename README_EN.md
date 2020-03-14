# flutter_app_o2o
flutter College canteen o2o reservation service, commercial application, continuous upgrading, completely open source.
### notice:
- This product by the Beijing university of posts and telecommunications & northeast petroleum university school entrepreneurs to research and development, the current products & our demo operation stage, open source for the national college students to join in development, testing, offline operation, fully open source, expect to achieve the national free common perfect upgrade iterative application, developers, entrepreneurs realize centralized platform, tools, and decentralized business, not repeat manufacture industry, casting market together.
- FLUTTER communication qq group: 700014933, business cooperation contact qq: 66064540,wechat: 13091667316.
---
# O2O - Flutter version campus o2o canteen booking app

- [中文](https://github.com/Anjiefan/flutter_app_o2o/edit/master/README.md)

This is a complete, commercial-grade open source application, which aims to solve the efficiency problem of on-campus catering, retail and other services in colleges and universities across the country, and realize digital campus and intelligent campus.
The implemented functions are：
- [x] Online shopping
- [x] Quick reservation
- [x] The monetary system
- [x] The distribution system
- [x] Coupon system
- [x] The store management
- [x] Commodity management
- [x] The order management
- [x] WeChat, qq share

Possible future upgrades include:
- The hardware system
- Running errands system
- Off-campus catering voucher system

## Download

**Android：** [Apk Download address](https://github.com/Mayandev/morec/raw/master/Morec.apk)

**iOS：** Review on line

**app website：** Review on line

## screenshot

### 1. Screenshot of the client page
**处理中：** 审核上线中
### 2. Business side page screenshot
**处理中：** 审核上线中

## Based on the environment
```dart
// Run the following command
flutter --version

// The correct environment is as follows
// Flutter 1.12.13+hotfix.5 • channel stable •
// https://github.com/flutter/flutter.git
// Framework • revision 27321ebbad (3 months ago) • 2019-12-10 18:15:01 -0800
// Engine • revision 2994f7e1e6
// Tools • Dart 2.7.0
```
## architecture
>- |--lib
>    - |-- common (Commonly used class，Constants,Routers,Networks,Managers)
>        - |-- Constants（Constant collection）
>        - |-- Routers（Routing collection）
>        - |-- Networks（Further encapsulate the dio system architecture）
>        - |-- Managers（Management classes, such as: get files, get storage information, complete file cache, and so on）
>    - |-- models (Entity class)
>    - |-- providers (Further encapsulate the provider architecture)
>    - |-- service (Network layer business logic)
>    - |-- ui (page，dialog，widgets)
>    - |-- utils (Utility class)
>    - |-- view_model (The entity model class that operates on the service, provider)

## The document
**The server side API：** [Click to view](http://stg-finerit.leanapp.cn/finerit/)

## Update record
- [x] 2019.1.20 Complete the project planning and officially launch the project
- [x] 2020.1.30，Complete the construction of front and rear architecture
- [x] 2020.2.30，Complete the general model and business realization of the merchant side and the client side
- [x] 2020.3.30，Complete front and rear performance tuning, UI interaction tuning, beautification, API serialization optimization, and bug fixing
- [x] 2020.3.14，Complete general test, official open source public test, ready to go online

## copyright
- [x] 黑龙江省符瑞科技有限公司
- [x] 大庆市凡尔网络科技有限责任公司
