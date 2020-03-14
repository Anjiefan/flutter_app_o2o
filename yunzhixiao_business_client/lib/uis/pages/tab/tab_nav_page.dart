import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getuiflut/getuiflut.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/order_process_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_search/order_search_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/shop_manage_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/user_home_page.dart';
import 'package:yunzhixiao_business_client/view_model/push_model.dart';
import 'package:yunzhixiao_business_client/view_model/settings_model.dart';

List<Widget> pages = <Widget>[
  OrderProcessHomePage(),
  OrderSearchHomePage(),
  ShopManageHomePage(),
  UserPage()
];

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  Future<void> initPlatformState() async {
    String platformVersion;
    String payloadInfo = "default";
    String notificationState = "default";
    // Platform messages may fail, so we use a try/catch PlatformException.

    if (Platform.isIOS) {
      //TODO Release需要更换
      Getuiflut().startSdk(
          appId: "5C2le8MZLc7IDW4My6CgV5",
          appKey: "X9FRFnNR9A6U0eYYDEUha1",
          appSecret: "0t2BtO7F0NAD7KX5IifzO6");
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
        UserRepository.updatePushInfo(platform, message, 0);
      },
      onReceiveMessageData: (Map<String, dynamic> msg) async {
        print("flutter onReceiveMessageData: $msg");
      },
      onNotificationMessageArrived: (Map<String, dynamic> msg) async {
        print("flutter onNotificationMessageArrived");
        var model = Provider.of<PushModel>(context);
        model.refreshSystemMessageNum();
        //需要刷新新订单页面
        if (pushModel != null) {
          pushModel.onRefreshOrderHomeInfoModel();
        }
        String content = msg["content"];
        //TODO 对到来消息进行处理

        if (content == "由于过久未回复催单信息，用户申请取消订单") {
          //05
          var player = AudioCache();
          player.play('ring/cancel.mp3');
        }
        if (content == "用户申请取消订单") {
          //06
          var player = AudioCache();
          player.play('ring/cancel.mp3');
        }
        if (content == "用户正在催单") {
          //07
          var player = AudioCache();
          player.play('ring/hurry.mp3');
        }
        if (content == "收到新订单") {
          //09
          var player = AudioCache();
          player.play('ring/ring.mp3');
          //需要判断是否自动接单
          if (settingsModel != null) {
            if (settingsModel.settings.orderSettings.autoOrder) {
              if (pushModel != null) {
                print("!!!!!!!!!!here");
                await pushModel.onAutoOrder(context);
                await pushModel.onRefreshOrderHomeInfoModel();
              }
            }
          }
          //需要刷新新订单页面
          if (pushModel != null) {
            try {
              pushModel.onRefreshNewOrderListModel();
              pushModel.onRefreshOrderHomeInfoModel();
            } catch (e) {
              pushModel.onRefreshOrderHomeInfoModel();
            }
          }
        }
      },
      onNotificationMessageClicked: (Map<String, dynamic> msg) async {
        print("flutter onNotificationMessageClicked");
      },
      onRegisterDeviceToken: (String message) async {
        print("flutter deviceToken: $message");
      },
      onReceivePayload: (Map<String, dynamic> message) async {
        print("lutter onReceivePayload: $message");
        var model = Provider.of<PushModel>(context);
        model.refreshSystemMessageNum();
        //需要刷新新订单页面
        if (pushModel != null) {
          pushModel.onRefreshOrderHomeInfoModel();
        }
        String content = json.decode(message["payloadMsg"])["content"];
        print("content=$content");
        //TODO 对到来消息进行处理
        if (content == "1234") {
          var player = AudioCache();
          player.play('ring/return.mp3');
        }
        if (content == "由于过久未回复催单信息，用户申请取消订单") {
          //05
          var player = AudioCache();
          player.play('ring/cancel.mp3');
        }
        if (content == "用户申请取消订单") {
          //06
          var player = AudioCache();
          player.play('ring/cancel.mp3');
        }
        if (content == "用户正在催单") {
          //07
          var player = AudioCache();
          player.play('ring/hurry.mp3');
        }
        if (content == "收到新订单") {
          //09
          var player = AudioCache();
          player.play('ring/ring.mp3');
          //需要判断是否自动接单
          if (settingsModel != null) {
            if (settingsModel.settings.orderSettings.autoOrder) {
              if (pushModel != null) {
                await pushModel.onAutoOrder(context);
                await pushModel.onRefreshOrderHomeInfoModel();
              }
            }
          }
          //需要刷新新订单页面
          if (pushModel != null) {
            try {
              pushModel.onRefreshNewOrderListModel();
              pushModel.onRefreshOrderHomeInfoModel();
            } catch (e) {
              pushModel.onRefreshOrderHomeInfoModel();
            }
          }
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

  // Push _push = Push();

  // StreamSubscription<String> _receiveDeviceToken;
  // StreamSubscription<Message> _receiveMessage;
  // StreamSubscription<Message> _receiveNotification;
  // StreamSubscription<String> _launchNotification;
  // StreamSubscription<String> _resumeNotification;
  PushModel pushModel;
  SettingsModel settingsModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      Wakelock.enable();
      initPlatformState();
      // You could also use Wakelock.toggle(on: true);
    });
    // _receiveDeviceToken =
    //     _push.receiveDeviceToken().listen(_handleReceiveDeviceToken);
    // _receiveMessage = _push.receiveMessage().listen(_handleReceiveMessage);
    // _receiveNotification =
    //     _push.receiveNotification().listen(_handleReceiveNotification);
    // _launchNotification =
    //     _push.launchNotification().listen(_handleLaunchNotification);
    // _resumeNotification =
    //     _push.resumeNotification().listen(_handleResumeNotification);

    // _push.startWork(enableDebug: true);

    // SharedPreferences.getInstance().then((SharedPreferences sharedPref) {
    //   if (sharedPref.getBool('firstStart') ?? true) {
    //     sharedPref.setBool('firstStart', false);
    //   } else {
    //     _push.areNotificationsEnabled().then((bool isEnabled) {
    //       if (!isEnabled) {
    //         showCupertinoDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return CupertinoAlertDialog(
    //               title: const Text('提示'),
    //               content: const Text('开启通知权限可收到更多优质内容'),
    //               actions: <Widget>[
    //                 CupertinoDialogAction(
    //                   child: const Text('取消'),
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                 ),
    //                 CupertinoDialogAction(
    //                   child: const Text('设置'),
    //                   onPressed: () {
    //                     _push.openNotificationsSettings();
    //                     Navigator.of(context).pop();
    //                   },
    //                 ),
    //               ],
    //             );
    //           },
    //         );
    //       }
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    // if (_receiveDeviceToken != null) {
    //   _receiveDeviceToken.cancel();
    // }
    // if (_receiveMessage != null) {
    //   _receiveMessage.cancel();
    // }
    // if (_receiveNotification != null) {
    //   _receiveNotification.cancel();
    // }
    // if (_launchNotification != null) {
    //   _launchNotification.cancel();
    // }
    // if (_resumeNotification != null) {
    //   _resumeNotification.cancel();
    // }
    super.dispose();
  }

  // void _handleReceiveDeviceToken(String deviceToken) async {
  //   String deviceToken = await _push.getDeviceToken();
  //   print('receiveDeviceToken: $deviceToken - ${deviceToken}');
  //   int platform;
  //   if (Platform.isAndroid) {
  //     platform = 1;
  //   } else if (Platform.isIOS) {
  //     platform = 0;
  //   }
  //   UserRepository.updatePushInfo(platform, deviceToken, 0);
  // }

  // //TODO 这里接受隐式透传消息
  // void _handleReceiveMessage(Message message) {
  //   print(
  //       'receiveMessage: ${message.title} - ${message.content} - ${message.customContent}');
  // }

  // //TODO 这里接受显式通知
  // Future<void> _handleReceiveNotification(Message notification) async {
  //   print(
  //       'receiveNotification: ${notification.title} - ${notification.content} - ${notification.customContent}');
  //   if (notification.content == "有退单需要处理") {
  //     //01
  //     var player = AudioCache();
  //     player.play('ring/return.mp3');
  //   }
  //   if (notification.content == "由于过久未回复催单信息，用户申请取消订单") {
  //     //05
  //     var player = AudioCache();
  //     player.play('ring/cancel.mp3');
  //   }
  //   if (notification.content == "用户申请取消订单") {
  //     //06
  //     var player = AudioCache();
  //     player.play('ring/cancel.mp3');
  //   }
  //   if (notification.content == "用户正在催单") {
  //     //07
  //     var player = AudioCache();
  //     player.play('ring/hurry.mp3');
  //   }
  //   if (notification.content == "收到新订单") {
  //     //09
  //     var player = AudioCache();
  //     player.play('ring/ring.mp3');
  //     //需要判断是否自动接单
  //     if (settingsModel != null) {
  //       if (settingsModel.settings.orderSettings.autoOrder) {
  //         if (pushModel != null) {
  //           await pushModel.onAutoOrder(context);
  //           await pushModel.onRefreshOrderHomeInfoModel();
  //         }
  //       }
  //     }
  //     //需要刷新新订单页面
  //     if (pushModel != null) {
  //       print("123456");
  //       try {
  //         pushModel.onRefreshNewOrderListModel();
  //         pushModel.onRefreshOrderHomeInfoModel();
  //       } catch (e) {
  //         pushModel.onRefreshOrderHomeInfoModel();

  //       }
  //     }
  //   }
  // }

  // void _handleLaunchNotification(String customContent) {
  //   print('launchNotification: $customContent');
  // }

  // void _handleResumeNotification(String customContent) {
  //   print('resumeNotification: $customContent');
  // }

  @override
  Widget build(BuildContext context) {
    pushModel = Provider.of<PushModel>(context);
    settingsModel = Provider.of<SettingsModel>(context);
    return Scaffold(
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
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text("订单处理"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text("订单查询"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.desktop_mac),
            title: Text("店铺"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("设置"),
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
