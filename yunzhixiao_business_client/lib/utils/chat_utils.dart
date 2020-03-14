


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_business_client/view_model/system_static_model.dart';

class ChatUtils {
  static qqChat(BuildContext context) async {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    var url;
    if (Platform.isAndroid) {
      url = 'mqqwpa://im/chat?chat_type=wpa&uin=${staticModel.systemStaticInfo.staticData.serviceQq}';
    } else {
      url =
      'mqq://im/chat?chat_type=wpa&uin=${staticModel.systemStaticInfo.staticData.serviceQq}&version=1&src_type=web';
    }
    if (await canLaunch(url)) {
    await launch(url);
    } else {
      showToast("无法启动QQ");
    }
  }
}