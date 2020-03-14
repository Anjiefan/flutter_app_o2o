import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';

import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/userful_code_snippets.dart';
import 'package:yunzhixiao_business_client/uis/widgets/banner_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/utils/chat_utils.dart';
import 'package:yunzhixiao_business_client/view_model/system_static_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/banner_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/login_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var model = Provider.of<UserModel>(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            ProviderWidget<LoginModel>(
                model: LoginModel(Provider.of(context)),
                builder: (context, model, child) {
                  return SizedBox.shrink();
                })
          ],
          backgroundColor: Colors.white,
          expandedHeight: 120,
          centerTitle: true,
          flexibleSpace: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: ClipOval(
                                  child: WrapperImage(
                                url: model.user == null? "":(model.user.shop == null
                                    ? ""
                                    : model.user.shop.logo),
                                width: 80,
                                height: 80,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        model.user == null
                                            ? "未登录"
                                            : (model.user.shop == null?"":model.user.shop.name),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      child: (model.user == null
                                              ? false
                                              : (model.user.shop == null? "":model.user.shop.isOpen))
                                          ? GestureDetector(
                                              onTap: () {
                                                model.openOrCloseShop(context);
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 60,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("营业中",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12)),
                                                      SizedBox(
                                                        width: 1,
                                                      ),
                                                      Icon(
                                                        Icons.album,
                                                        size: 12,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  )),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                model.openOrCloseShop(context);
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 60,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey[300]
                                                              .withOpacity(0.5),
                                                          width: 1)),
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("已关店",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[300]
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 12)),
                                                      Icon(
                                                        Icons.adjust,
                                                        size: 14,
                                                        color: Colors.grey[300]
                                                            .withOpacity(0.5),
                                                      )
                                                    ],
                                                  )),
                                            )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          pinned: false,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).scaffoldBackgroundColor
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    image: null),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  height: 80.0,
                  child: MyCard(
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: <Widget>[
                        const _UserHomeTab('店铺设置', 0),
                        Container(
                          width: 0.8,
                          height: 36,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const _UserHomeTab('营业设置', 1),
                        Container(
                          width: 0.8,
                          height: 36,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const _UserHomeTab('订单设置', 2),
                        Container(
                          width: 0.8,
                          height: 36,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const _UserHomeTab('通知与提示', 3),
                      ],
                    ),
                  ),
                ),
              ),
              80.0),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 12),
          sliver: UserListWidget(),
        ),
      ],
    ));
  }
}

class _UserHomeTab extends StatelessWidget {
  const _UserHomeTab(this.title, this.index);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    IconData _iconData = null;
    switch (index) {
      //门店设置
      case 0:
        _iconData = Icons.store;
        break;
      //订单设置
      case 1:
        _iconData = Icons.timer;
        break;
//    //打印机管理
      case 2:
        _iconData = Icons.assignment;
        break;
      //通知与提醒
      case 3:
        _iconData = Icons.notifications_active;
        break;
    }
    return Expanded(
      child: MergeSemantics(
        child: InkWell(
          onTap: () {
            switch (index) {
              case 0:
                Navigator.pushNamed(
                    context, RouteName.userShopSettingsBasicInfo);
                break;
              case 1:
                Navigator.pushNamed(
                    context, RouteName.userShopSettingsOperateInfo);
                break;
              case 2:
                Navigator.of(context)
                    .pushNamed(RouteName.userOrderSettingsHome);
                break;
              case 3:
                Navigator.of(context)
                    .pushNamed(RouteName.userNotificationSettingsHome);
            }
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconData,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                Gaps.vGap4,
                Text(title, style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return ProviderWidget<LoginModel>(
      model: LoginModel(Provider.of(context)),
      builder: (BuildContext context, LoginModel loginModel, Widget child) {
        return ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: SliverList(
            delegate: SliverChildListDelegate([
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color(0x80DCE7FA),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 8.0,
                          spreadRadius: 0.0),
                    ]),
                    child: PhysicalModel(
                      color: Colors.transparent, //设置背景底色透明
                      borderRadius: BorderRadius.circular(12),
                      clipBehavior: Clip.antiAlias, //注意这个属性
                      child: BannerWidget(
                        height: 100,
                        list: staticModel.systemStaticInfo.homePageData.swiperPage,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "客服服务",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icons.home,
                      ),
                      onTap: () async {
                        ChatUtils.qqChat(context);
                      },
                    ),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "APP官网",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icons.public,
                      ),
                      onTap: () async {
                        var model = Provider.of<SystemStaticModel>(context);
                        if (await canLaunch(model.systemStaticInfo.staticData.website)) {
                          await launch(model.systemStaticInfo.staticData.website);
                        } else {
                          throw 'Could not launch ${model.systemStaticInfo.staticData.website}';
                        }
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "关于我们",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icons.person,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.appInfo);
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "修改密码",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icons.lock,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.userChangePassword);
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "切换账号",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icons.swap_horiz,
                      ),
                      onTap: () {
                        loginModel.logout();
                        Navigator.pushReplacementNamed(
                            context, RouteName.login);
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}


class ListTileCustom extends StatelessWidget {
  final Text title;
  final IconData icon;

  const ListTileCustom(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                this.icon,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 40,
                width: 5,
              ),
              this.title,
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Icon(Icons.chevron_right)],
            ),
          )
        ],
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  BannerImage(this.url, {this.fit: BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>
            Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: fit);
  }
}
