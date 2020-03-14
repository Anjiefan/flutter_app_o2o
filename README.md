# flutter_app_o2o
flutter高校食堂o2o预定服务，商业级应用，持续升级，完全开源。
### notice:
- 本产品由北京邮电大学&东北石油大学在校创业者研发，当前处于产品公测&本校运营阶段，开源供全国高校在校生加盟开发、测试、线下运营使用，完全开源，期望以实现全国自由开发者、创业者共同完善升级迭代应用，实现中心化平台、工具，去中心化商业，不再重复制造产业，共同铸就市场。
- FLUTTER交流群：700014933，商务合作联系qq：66064540。
---
# O2O - Flutter 版校园o2o食堂预定app

- [English](https://github.com/Mayandev/morec/blob/master/README_EN.md)

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

## 版权
**黑龙江省符瑞科技有限公司
**大庆市凡尔网络科技有限责任公司
