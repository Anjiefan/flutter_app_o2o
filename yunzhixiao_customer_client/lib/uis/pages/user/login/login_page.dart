import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/login/login_phone_code_panel.dart';
import 'dart:ui';

import 'login_username_password_panel.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin
{
  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }
  int tabIndex;
  TabController tabController;
  List<String> tabs = ['密码登录', '验证码登录'];
  ValueNotifier<int> valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var primaryColor = Theme.of(context).primaryColor;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ValueListenableProvider<int>.value(
        value: valueNotifier,
        child: DefaultTabController(
          length: tabs.length,
          initialIndex: valueNotifier.value,
          child: Builder(
            builder: (context) {
              if (tabController == null) {
                tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  valueNotifier.value = tabController.index;
                });
              }
              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                  ),
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    RaisedButton(
                      elevation: 0,
                      focusElevation: 0,
                      child: Text(
                        "注册",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      color: primaryColor,
                      disabledColor: primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteName.register).then((result){
                          if (result) {
                            Navigator.of(context).pop(true);
                          }
                        });
                      },
                    )
                  ],
                  centerTitle: true,
                  title: const Text('登录'),
                  bottom: new TabBar(
                    isScrollable: true,
                    indicatorPadding:EdgeInsets.only(bottom: 5),
                    tabs: tabs.map((choice) {
                      return new Tab(
                        text: choice,
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  children: [
                    LoginUsernamePasswordPanel(),
                    LoginPhoneCodePanel()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
          actions: <Widget>[
            RaisedButton(
              elevation: 0,
              focusElevation: 0,
              child: Text("注册", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),),
              color: primaryColor,
              disabledColor: primaryColor,
              onPressed: (){
                Navigator.of(context).pushNamed(RouteName.register);
              },
            )
          ],
        ),
        body: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Builder(
              builder: (context) {
                if (tabController == null) {
                  tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    tabIndex = tabController.index;
                  });
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Stack(
                      alignment: Alignment.bottomCenter,
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: primaryColor.withOpacity(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              TabBar(
                                  isScrollable: true,
                                  tabs: [Text("账号登录"), Text("手机登录")]),
                            ],
                          ),
                        )
                      ],
                    ),

                  ),
                  body: TabBarView(
                    children: [
                      LoginUsernamePasswordPanel(),
                      LoginPhoneCodePanel()
                    ]
                  ),
                );
              },
            )));
  }
}
