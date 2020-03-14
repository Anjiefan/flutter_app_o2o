import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';

class ShopSettingsHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ShopSettingsHomePageState();
}

class ShopSettingsHomePageState extends State<ShopSettingsHomePage> {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text("门店设置"),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text("基本信息"),
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.userShopSettingsBasicInfo);
                  },
                  leading: Icon(
                    Icons.info,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text("营业信息"),
                  onTap: () async {
                    Navigator.pushNamed(context, RouteName.userShopSettingsOperateInfo);
                  },
                  leading: Icon(
                    Icons.open_with,
                    color: Colors.green,
                  ),
                  trailing: Icon(Icons.chevron_right),

                ),
              ),
//              Material(
//                color: Theme.of(context).cardColor,
//                child: ListTile(
//                  title: Text("资质认证"),
//                  onTap: () async {
//
//                  },
//                  leading: Icon(
//                    Icons.verified_user,
//                    color: Colors.amber,
//                  ),
//                  trailing: Icon(Icons.chevron_right),
//
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}