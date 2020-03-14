# flutter_app_o2o
flutter高校食堂o2o预定服务，商业级应用，持续升级，完全开源。
### notice:
- 本产品由北京邮电大学&东北石油大学在校创业者研发，当前处于产品公测&本校运营阶段，开源供全国高校在校生加盟开发、测试、线下运营使用，完全开源，期望以实现全国自由开发者、创业者共同完善升级迭代应用，实现中心化平台、工具，去中心化商业，不再重复制造产业，共同铸就市场。
- FLUTTER交流群：700014933，商务合作联系qq：66064540，微信：13091667316。
- 由于国内github网速的问题，我们内部开发选用coding源，github源每月更新大版本，获取最新项目进展以及协作开发可以前往coding，
- 用户端coding源[https://e.coding.net/Anjiefan/yunzhixiao_customer_client.git](https://e.coding.net/Anjiefan/yunzhixiao_customer_client.git)
- 商家端coding源[https://e.coding.net/Anjiefan/yunzhixiao_business_client.git](https://e.coding.net/Anjiefan/yunzhixiao_business_client.git)
---
# O2O - Flutter 版校园o2o食堂预定app

- [English](https://github.com/Anjiefan/flutter_app_o2o/blob/master/README_EN.md)

这是一款完整的、商业级开源应用，旨在解决全国高校校内餐饮、零售等服务的效率问题，实现数字化校园，智能化校园。
已实现的功能有：
- [x] 线上下单
- [x] 快速预定
- [x] 货币系统
- [x] 分销系统
- [x] 优惠卷系统
- [x] 店铺管理
- [x] 商品管理
- [x] 订单管理
- [x] 微信、qq分享

未来可能升级的功能有：
- 硬件系统
- 跑腿系统
- 校外餐饮优惠卷系统

## Download

**Android：** [Apk 下载地址](https://github.com/Mayandev/morec/raw/master/Morec.apk)

**iOS：** 审核上线中

**app官网：** 审核上线中

## 关键页面截图

### 1. 用户端页面截图
**处理中：** 审核上线中
### 2. 商家端页面截图
**处理中：** 审核上线中

## 基础环境
```dart
// 运行如下命令
flutter --version

// 正确环境如下
// Flutter 1.12.13+hotfix.5 • channel stable •
// https://github.com/flutter/flutter.git
// Framework • revision 27321ebbad (3 months ago) • 2019-12-10 18:15:01 -0800
// Engine • revision 2994f7e1e6
// Tools • Dart 2.7.0
```
## 架构
>- |--lib
>    - |-- common (常用类，Constants,Routers,Networks,Managers)
>        - |-- Constants（常量集合）
>        - |-- Routers（路由集合）
>        - |-- Networks（进一步封装dio系统架构）
>        - |-- Managers（管理类，如：获取文件、获取存储信息、完成文件缓存等）
>    - |-- models (实体类)
>    - |-- providers (进一步封装provider系统架构)
>    - |-- service (网络层业务逻辑)
>    - |-- ui (界面相关page，dialog，widgets)
>    - |-- utils (工具类)
>    - |-- view_model (操作service，provider的实体model类)

## 文档
**后端API：** [点击查看](http://stg-finerit.leanapp.cn/finerit/)

## 更新记录
- [x] 2019.1.20，完成项目策划，正式启动项目
- [x] 2020.1.30，完成前后端架构的搭建
- [x] 2020.2.30，完成商家端、用户端的大体模型及业务实现
- [x] 2020.3.30，完成前后端性能调优，ui交互调优，美化，api序列化优化，修复漏洞
- [x] 2020.3.14，完成大体测试，正式开源公测，预备上线
## 核心开发者
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
        <a href="https://github.com/jypjypjypjyp">@1GayWoliGiao</a>
      </td>
   </tr>
  </tbody>
</table>

## 版权
- [x] 黑龙江省符瑞科技有限公司
- [x] 大庆市凡尔网络科技有限责任公司
