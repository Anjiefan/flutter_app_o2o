import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/view_model/settings_model.dart';

class OrderSettingsHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderSettingsHomePageState();
}

class OrderSettingsHomePageState extends State<OrderSettingsHomePage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var model = Provider.of<SettingsModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("订单设置"),
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '自动接单',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(height: 0,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "高效率接单，防止漏单，本设备自动接单",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          '本设备自动接单',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: CupertinoSwitch(
                            value: model.settings.orderSettings.autoOrder,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              model.saveOrderSettings(autoOrder: value);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '接单保障',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(height: 0,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "建议开启或阅读一下信息，提前做好设置，避免漏单\n"
                          "1. 开启短信提醒，新订单10分钟未处理，微信将会收到短信提醒\n"
                          "2. 请勿锁屏，锁屏后将无法收到新订单铃声、推送",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("检查通知权限"),
                          ],
                        ),
                        onTap: () {
                          NotificationPermissions
                                    .requestNotificationPermissions(
                                        iosSettings: const NotificationSettingsIos(
                                            sound: true,
                                            badge: true,
                                            alert: true), openSettings: true).then(
                                              (result){
                                                if (PermissionStatus.granted == result){
                                                  showToast("通知权限已经开启");
                                                }
                                              }
                                            );
                        },
                        trailing: Icon(Icons.chevron_right),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("短信提醒"),
                          ],
                        ),
                        onTap: () {},
                        trailing: CupertinoSwitch(
                            value: model.settings.orderSettings.smsNotification,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              model.saveOrderSettings(smsNotification: value);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
