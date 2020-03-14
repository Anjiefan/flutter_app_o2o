import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/commons/managers/provider_manager.dart';

import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/commons/routers/app_router.dart';
import 'package:yunzhixiao_customer_client/generated/i18n.dart';
import 'package:yunzhixiao_customer_client/view_model/theme_model.dart';


main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera,PermissionGroup.notification, PermissionGroup.photos, PermissionGroup.storage]);
  await StorageManager.init();
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {

  @override
  void initState() {


    ShareSDKRegister register = ShareSDKRegister();
    register.setupWechat(
        "wx58fbd34964417acc", "c2d771775f6435471a47007a315edcc1", "https://hwapp.finerit.com");
    register.setupQQ("101859784", "16a9053c2e11954f59cd48ccdc8aca32");
    SharesdkPlugin.regist(register);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
            providers: providers,
            child: Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return RefreshConfiguration(
                hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                child: Center(
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: themeModel.themeData(),
                    darkTheme: themeModel.themeData(platformDarkMode: true),
                    localizationsDelegates: const [
                      S.delegate,
                      RefreshLocalizations.delegate, //下拉刷新
                      GlobalCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    onGenerateRoute: Router.generateRoute,
                    initialRoute: RouteName.splash,
                  ),
                ),
              );
            })));
  }
}
