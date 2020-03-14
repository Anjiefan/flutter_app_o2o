import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/view_model/settings_model.dart';

class NotificationSettingsHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => NotificationSettingsHomePageState();
}

class NotificationSettingsHomePageState extends State<NotificationSettingsHomePage> {

  final notificationVoiceType = ["经典女声"];
  final notificationFreqType = ["提示1次", "提示3次", "循环提示", "关闭"];
  var voiceIndex = 0;
  var freqIndex = 0;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<SettingsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("通知与提示设置"),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("通知",  style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              Container(
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
                                    '授权新订单通知',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  trailing: CupertinoSwitch(
                                      value: model.settings.notificationSettings.latestOrderNotification,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value){
                                        model.saveNotificationSettings(
                                          latestOrderNotification: value
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("音量与振动",  style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              Container(
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
                                    '开启APP自动将声音调至最大',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  trailing: CupertinoSwitch(
                                      value: model.settings.notificationSettings.autoVolumeMax,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value){
                                        model.saveNotificationSettings(
                                          autoVolumeMax: value
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])),
              Container(
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
                                    '提示振动',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  trailing: CupertinoSwitch(
                                      value: model.settings.notificationSettings.vibrateNotification,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value){
                                        model.saveNotificationSettings(
                                          vibrateNotification: value
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("提示音设置",  style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("提示音"),
                    ],
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.saveNotificationSettings(
                                ringType: index
                              );
                            },
                            groupValue: model.settings.notificationSettings.ringType,
                            title: Text(notificationVoiceType[index],style: TextStyle(fontSize: 15),),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
//              Material(
//                color: Theme.of(context).cardColor,
//                child: ExpansionTile(
//                  initiallyExpanded: true,
//                  title: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("提示频率"),
//                    ],
//                  ),
////                  leading: Icon(
////                    Icons.wifi_tethering,
////                    color: iconColor,
////                  ),
//                  children: <Widget>[
//                    ListView.builder(
//                        shrinkWrap: true,
//                        itemCount: 4,
//                        itemBuilder: (context, index) {
//                          return RadioListTile(
//                            value: index,
//                            onChanged: (index) {
//                              model.saveNotificationSettings(
//                                  notificationFreq: index
//                              );
//                            },
//                            groupValue: model.settings.notificationSettings.notificationFreq,
//                            title: Text(notificationFreqType[index],style: TextStyle(fontSize: 15),),
//                          );
//                        })
//                  ],
//                ),
//              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
