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
import 'package:yunzhixiao_customer_client/commons/constants/config.dart';
import 'package:yunzhixiao_customer_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/distribution.dart';

import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/service/data_repository.dart';
import 'package:yunzhixiao_customer_client/uis/icons/my_flutter_app_icons.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/utils/auth_utils.dart';
import 'package:yunzhixiao_customer_client/utils/chat_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/system/system_static_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/login_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Distribution _distribution = Distribution(
      todayDistributionNum: 0,
      yesterdayDistributionNum: 0,
      monthDistributionNum: 0,
      todayEarnNum: 0.0,
      yesterdayEarnNum: 0.0,
      monthEarnNum: 0.0,
      yesterdayIndirectDistributionNum: 0,
      todayIndirectDistributionNum: 0,
      monthIndirectDistributionNum: 0,
      promotionNum: 0,
      promotionSum: 0.0);
  UserModel model;

  @override
  void initState() {
    super.initState();
    DataRepository.fetchDistributionData().then((value) {
      if (mounted)
        setState(() {
          var item = value as Distribution;
          _distribution = item;
        });
    });
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).primaryColor;
    model = Provider.of<UserModel>(context);

    if (loading == false) {
      model.refreshUserInfo();
      loading = true;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: <Widget>[
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 12),
//                child: GestureDetector(
//                    onTap: () {},
//                    child: Icon(Icons.settings,
//                        color: Theme.of(context).primaryColor)),
//              )
            ],
          ),
          preferredSize: Size.fromHeight(30),
        ),
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
              expandedHeight: 90,
              centerTitle: true,
              flexibleSpace: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (StorageManager.sharedPreferences
                            .getBool(Config.IS_LOGIN_KEY)==null||
                            StorageManager.sharedPreferences
                                .getBool(Config.IS_LOGIN_KEY)==false)
                          Navigator.pushNamed(context, RouteName.login)
                              .then((result) {
                            if (result) {
                              model.refreshUserInfo();
                            }
                          });
                      },
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: ClipOval(
                                        child: WrapperImage(
                                      url: model.user == null
                                          ? 'http://lc-aveFaAUx.cn-n1.lcfile.com/89b0dceff76af220dd18/ic_launcher.png'
                                          : model.user.userinfo.headImg,
                                      width: 80,
                                      height: 80,
                                    )),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        child: Text(
                                          model.user == null
                                              ? "去登录"
                                              : model.user.userinfo.phoneNum,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          "线上点餐，下单预约，告别排队～",
                                          style: TextStyle(
                                            color: Colors.grey[300],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              pinned: false,
            ),
            SliverPersistentHeader(
              pinned: false,
              delegate: SliverAppBarDelegate(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              ErrorUtils.auth_401_error(context,(){
                                Navigator.pushNamed(
                                    context, RouteName.userDistribution);
                              });

                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width -
                                      30 -
                                      16) /
                                  2,
                              child: MyCard(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 12, 12, 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "分销 ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black87),
                                              ),
                                              Text(
                                                  "${_distribution.todayIndirectDistributionNum + _distribution.todayDistributionNum}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.black87)),
                                              Text(" 人",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.black87))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 4, 12, 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "盈利 ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black45),
                                              ),
                                              Text(
                                                  "${_distribution.todayEarnNum}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14)),
                                              Text(" 币",
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 14))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              ErrorUtils.auth_401_error(context,(){
                                Navigator.pushNamed(
                                    context, RouteName.userRedPacket,
                                    arguments: null);
                              });

                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width -
                                      30 -
                                      16) /
                                  2,
                              child: MyCard(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 12, 12, 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "红包 ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black87),
                                              ),
                                              Text(
                                                  "${_distribution.promotionNum}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.black87)),
                                              Text(" 个",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.black87))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 4, 12, 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "可省 ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black45),
                                              ),
                                              Text(
                                                  "${_distribution.promotionSum}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14)),
                                              Text(" 元",
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 14))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  100),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap16,
                    AspectRatio(
                      aspectRatio: 2.8,
                      child: MyCard(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text("我的钱包",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        ErrorUtils.auth_401_error(context,(){
                                          Navigator.pushNamed(
                                              context, RouteName.userWalletRMB);
                                        });

                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "人民币 >",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            model.user == null
                                                ? "0.0"
                                                : model.user.campusCode
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        ErrorUtils.auth_401_error(context,(){
                                          Navigator.pushNamed(context,
                                              RouteName.userWalletCampusCode);
                                        });

                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "校园币 >",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            model.user == null
                                                ? "0.0"
                                                : model.user.timeCode
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    Gaps.vGap16,
                    AspectRatio(
                      aspectRatio: 2.9,
                      child: MyCard(
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("我的收入",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        GestureDetector(
                                          onTap: () {
                                            ErrorUtils.auth_401_error(context,(){
                                              Navigator.pushNamed(
                                                  context,
                                                  RouteName
                                                      .userDistributionDetail);
                                            });

                                          },
                                          child: Text("查看详情",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_distribution.yesterdayEarnNum}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "昨日收入",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        width: 0.8,
                                        height: 35,
                                        color: Colors.white),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_distribution.todayEarnNum}",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "今日收入",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        width: 0.8,
                                        height: 35,
                                        color: Colors.white),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_distribution.monthEarnNum}",
                                          style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "本月收入",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 8),
              sliver: UserListWidget(),
            ),
          ],
        ));
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginModel>(
      model: LoginModel(Provider.of(context)),
      builder: (BuildContext context, LoginModel loginModel, Widget child) {
        return ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[

                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "客服服务",
                          style: TextStyle(fontSize: 16),
                        ),
                        MyFlutterApp.kefu,
                      ),
                      onTap: () async {
                        ChatUtils.qqChat(context);
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "APP官网",
                          style: TextStyle(fontSize: 16),
                        ),
                        MyFlutterApp.logo,
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
                        MyFlutterApp.inforation,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.userAppInfo);
                      },
                    ),
                    Divider(height: 0),
                    loginModel.userModel.user != null
                        ? ListTile(
                            title: ListTileCustom(
                              Text(
                                "修改密码",
                                style: TextStyle(fontSize: 16),
                              ),
                              MyFlutterApp.lock,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.changePassword);
                            },
                          )
                        : Container(),
                    Divider(height: 0),
                    loginModel.userModel.user != null
                        ? ListTile(
                            title: ListTileCustom(
                              Text(
                                "切换账号",
                                style: TextStyle(fontSize: 16),
                              ),
                              MyFlutterApp.alter,
                            ),
                            onTap: () {
                              loginModel.logout();
                              Navigator.pushNamed(context, RouteName.login);
                            },
                          )
                        : Container(),
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
                size: 19,
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
