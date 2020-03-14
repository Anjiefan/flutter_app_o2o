import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/constants/config.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_business_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_business_client/generated/i18n.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/view_model/user/login_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Animation<double> _animation;
  AnimationController _countdownController;

  @override
  void initState() {
    _logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    _logoController.forward();

    _countdownController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _countdownController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(
              ImageHelper.wrapAssets(
                  Theme.of(context).brightness == Brightness.light
                      ? 'splash_bg_none.png'
                      : 'splash_bg_dark.png'),
//              colorBlendMode: BlendMode.srcOver,//colorBlendMode方式在android等机器上有些延迟,导致有些闪屏,故采用两套图片的方式
//              color: Colors.black.withOpacity(
//                  Theme.of(context).brightness == Brightness.light ? 0 : 0.65),
              fit: BoxFit.fill),
          AnimatedFlutterLogo(
            animation: _animation,
          ),
          Align(
            alignment: Alignment(0.0, -0.4),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.54,
              child: Image.asset(
                  ImageHelper.wrapAssets('splash_bg_roundcloud.png'),
//              colorBlendMode: BlendMode.srcOver,//colorBlendMode方式在android等机器上有些延迟,导致有些闪屏,故采用两套图片的方式
//              color: Colors.black.withOpacity(
//                  Theme.of(context).brightness == Brightness.light ? 0 : 0.65),
                  fit: BoxFit.contain),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.34),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.44,
              child: Image.asset(ImageHelper.wrapAssets('splash_bg_title.png'),
                  fit: BoxFit.contain),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.7),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.26,
              child: Image.asset(ImageHelper.wrapAssets('splash_bg_brief.png'),
                  fit: BoxFit.contain),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedAndroidLogo(
                  animation: _animation,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  nextPage(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black.withAlpha(100),
                  ),
                  child: AnimatedCountdown(
                    context: context,
                    animation: StepTween(begin: 3, end: 0)
                        .animate(_countdownController),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      (value == 0 ? '' : '$value | ') + S.of(context).splashSkip,
      style: TextStyle(color: Colors.white),
    );
  }
}

class AnimatedFlutterLogo extends AnimatedWidget {
  AnimatedFlutterLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container();
    return AnimatedAlign(
      duration: Duration(milliseconds: 10),
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      curve: Curves.bounceOut,
      child: Image.asset(
        ImageHelper.wrapAssets('splash_flutter.png'),
        width: 280,
        height: 120,
      ),
    );
  }
}

class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
//        Image.asset(
//          ImageHelper.wrapAssets('splash_fun.png'),
//          width: 140 * animation.value,
//          height: 80 * animation.value,
//        ),
//        Image.asset(
//          ImageHelper.wrapAssets('splash_android.png'),
//          width: 200 * (1 - animation.value),
//          height: 80 * (1 - animation.value),
//        ),
      ],
    );
  }
}

Future<void> nextPage(context) async {
  var isLogin = StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
  if (isLogin == null) {
    String token = StorageManager.sharedPreferences.getString(Config.TOKEN_KEY);
    if (token != null) {
      Navigator.pushReplacementNamed(context, RouteName.registerVerify);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteName.login);
    }
  } else if (isLogin) {
    var statusInfo = await UserRepository.getVerificationStatus();
    int status = statusInfo["status"];
    if (status != 2) {
      Navigator.pushReplacementNamed(context, RouteName.registerVerify);
      return;
    }
    var model = Provider.of<UserModel>(context);
    model.refreshUserInfo();
    if (model.user != null) {
      Navigator.of(context).pushReplacementNamed(RouteName.tab);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteName.login);
    }
  } else {
    Navigator.of(context).pushReplacementNamed(RouteName.login);
  }
}
