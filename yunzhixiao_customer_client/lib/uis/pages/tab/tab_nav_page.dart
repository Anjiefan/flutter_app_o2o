import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getuiflut/getuiflut.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'package:yunzhixiao_customer_client/service/user_repository.dart';
import 'package:yunzhixiao_customer_client/uis/icons/my_flutter_app_icons.dart';
import 'package:yunzhixiao_customer_client/uis/pages/earn/earn_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/user_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/home_page.dart';
import 'package:yunzhixiao_customer_client/view_model/system/system_static_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  EarnHomePage(),
  OrderHomePage(),
  UserPage(),
];

class TabNavigator extends StatefulWidget {
  final int where;
  TabNavigator({Key key, this.where}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController;
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  void initState() {
    super.initState();
    setState(() {
      Wakelock.enable();
      // You could also use Wakelock.toggle(on: true);
    });

    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.where != null) {
        print("where=${widget.where}");
        _selectedIndex = widget.where;
        _pageController.jumpToPage(widget.where);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPlatformState(UserModel userModel) async {

    if (userModel.user == null){
      print("!!!!!!!loginToInitPush");
      return;
    }
    print("!!!!!!!userModel.hasInitPush=${userModel.hasInitPush}");
    if (userModel.hasInitPush) {
      print("!!!!!!!hasInitPush");
      return;
    }

    String platformVersion;
    String payloadInfo = "default";
    String notificationState = "default";
    // Platform messages may fail, so we use a try/catch Plat formException.
    print("!!!!!!!!!initPlatformState");
    if (Platform.isIOS) {
      //TODO release需要修改
      Getuiflut().startSdk(
          appId: "WK7Vy36WSx7w8NKa7RgmF6",
          appKey: "K13YXlFo6A8ys0xz92WJT8",
          appSecret: "xWmFAQFLCq5e0EVsVOjOe7");
    } else {
      initGetuiSdk();
    }

    try {
      platformVersion = await Getuiflut.platformVersion;

      print('platformVersion' + platformVersion);
    } on Exception {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    Getuiflut().addEventHandler(
      onReceiveClientId: (String message) async {
        print("flutter onReceiveClientId: $message");
          //TODO 上传ClientID给服务端
          int platform;
          if (Platform.isAndroid) {
            platform = 1;
          } else if (Platform.isIOS) {
            platform = 0;
          }
          UserRepository.updatePushInfo(platform, message, 1);
          userModel.setHasInitPush();
      },
      onReceiveMessageData: (Map<String, dynamic> msg) async {
        print("flutter onReceiveMessageData: $msg");
      },
      onNotificationMessageArrived: (Map<String, dynamic> msg) async {
        print("flutter onNotificationMessageArrived");
        String content = msg["content"];
        var model = Provider.of<SystemStaticModel>(context);
        model.refreshSystemMessageNum();
        //TODO 对到来消息进行处理
        if (content == "商家已经完成备餐") {
          var player = AudioCache();
          player.play('ring/ring.mp3');
        }
      },
      onNotificationMessageClicked: (Map<String, dynamic> msg) async {
        print("flutter onNotificationMessageClicked");
      },
      onRegisterDeviceToken: (String message) async {
        print("flutter deviceToken: $message");
      },
      onReceivePayload: (Map<String, dynamic> message) async {
        print("flutter onReceivePayload: $message");
        var model = Provider.of<SystemStaticModel>(context);
        model.refreshSystemMessageNum();
        String content = message["payloadMsg"]["content"];
        //TODO 对到来消息进行处理
        if (content == "商家已经完成备餐") {
          var player = AudioCache();
          player.play('ring/ring.mp3');
        }
      },
      onReceiveNotificationResponse: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationResponse: $message");
      },
      onAppLinkPayload: (String message) async {
        print("flutter onAppLinkPayload: $message");
      },
      onRegisterVoipToken: (String message) async {
        print("flutter onRegisterVoipToken: $message");
      },
      onReceiveVoipPayLoad: (Map<String, dynamic> message) async {
        print("flutter onReceiveVoipPayload: $message");
      },
    );
  }

  Future<void> initGetuiSdk() async {
    try {
      Getuiflut.initGetuiSdk;
    } catch (e) {
      e.toString();
    }
  }
  // void _handleReceiveNotification(Message notification) {
  //   print(
  //       'receiveNotification: ${notification.title} - ${notification.content} - ${notification.customContent}');
  //   if (notification.content == "商家已经完成备餐") {
  //     var player = AudioCache();
  //     player.play('ring/ring.mp3');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: Stack(children: <Widget>[
          PageView.builder(
            itemBuilder: (ctx, index) => pages[index],
            itemCount: pages.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          FutureBuilder(
            future: Wakelock.isEnabled,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              // The use of FutureBuilder is necessary here to await the bool value from isEnabled.
              if (!snapshot.hasData)
                return Container(); // The Future is retrieved so fast that you will not be able to see any loading indicator.
              return Container();
            },
          ),
          Consumer(
            builder: (_, UserModel userModel, __) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                initPlatformState(userModel);
              });
              return Container();
            },
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.logo,
              size: 20,
            ),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.moeny,
              size: 21,
            ),
            title: Text("赚钱"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.order,
              size: 20,
            ),
            title: Text("订单"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.user,
              size: 20,
            ),
            title: Text("我的"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
