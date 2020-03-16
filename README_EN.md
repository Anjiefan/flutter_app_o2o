# flutter_app_o2o
flutter College canteen o2o reservation service, commercial application, continuous upgrading, completely open source.
### notice:
- This product by the Beijing university of posts and telecommunications & northeast petroleum university school entrepreneurs to research and development, the current products & our demo operation stage, open source for the national college students to join in development, testing, offline operation, fully open source, expect to achieve the national free common perfect upgrade iterative application, developers, entrepreneurs realize centralized platform, tools, and decentralized business, not repeat manufacture industry, casting market together.
- FLUTTER communication qq group: 700014933, business cooperation contact qq: 66064540,wechat: 13091667316.
- App test account, account: 19999999999 password: suibianle00
---
# O2O - Flutter version campus o2o canteen booking app

- [中文](https://github.com/Anjiefan/flutter_app_o2o/blob/master/README.md)

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

**Android：** [client download]() | [shop download](http://lc-aveFaAUx.cn-n1.lcfile.com/67f1e71b5d557927c74a/app-release.apk)

**iOS：** Review on line

**app website：** [http://stg-finerit.leanapp.cn/app/](http://stg-finerit.leanapp.cn/app/)

## screenshot

### 1. Screenshot of the client page
![Screenshot of the client page](http://lc-aveFaAUx.cn-n1.lcfile.com/a44e06a43b68b9cff731/%E5%AE%A2%E6%88%B7.png)
### 2. Business side page screenshot
![Business side page screenshot](http://lc-aveFaAUx.cn-n1.lcfile.com/f40eaaffc0e0cbe3b834/%E5%95%86%E5%AE%B6.png)

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
## Asosiy tuzuvchi 
<table>
  <tbody>
    <tr>
      <td align="center" width="80" valign="top">
        <img height="80" width="80" src="https://avatars0.githubusercontent.com/u/34623459?s=460&u=5dbbca37304268f8cd1c7ebb94821f0f295a60d4&v=4">
        <br>
        <a href="https://github.com/Anjiefan">@Anjiefan</a>
      </td>
      <td align="center" width="80" valign="top">
        <img height="80" width="80"  src="https://avatars0.githubusercontent.com/u/41356695?s=64&v=4">
        <br>
        <a href="https://github.com/morningstarwang">@morningstarwang</a>
      </td>
         <td align="center" width="80" valign="top">
        <img height="80" width="80"  src="https://avatars0.githubusercontent.com/u/47547284?s=460&v=4">
        <br>
        <a href="https://github.com/1GayWoliGiao">@1GayWoliGiao</a>
      </td>
       <td align="center" width="80" valign="top">
        <img height="80" width="80"  src="https://avatars2.githubusercontent.com/u/34328687?s=400&u=84f1d2b4ccdf3259a2296672dfbf903dd0c9304f&v=4">
        <br>
        <a href="https://github.com/jypjypjypjyp">@jypjypjypjyp</a>
      </td>
   </tr>
  </tbody>
</table>

## copyright
- [x] 黑龙江省符瑞科技有限公司
- [x] 大庆市凡尔网络科技有限责任公司

