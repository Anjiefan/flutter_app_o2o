


import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_customer_client/utils/platform_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/system/system_static_model.dart';

class ChatUtils {

  static final ShareSDKPlatform qZone = ShareSDKPlatform(name: "QQ空间", id: 6);
  static final ShareSDKPlatform wechatSession =
  ShareSDKPlatform(name: "微信", id: 22);
  static final ShareSDKPlatform wechatTimeline =
  ShareSDKPlatform(name: "朋友圈", id: 23);
  static final ShareSDKPlatform weChatFavorites =
  ShareSDKPlatform(name: "喜欢", id: 37);
  static final ShareSDKPlatform qq = ShareSDKPlatform(name: "QQ", id: 24);

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
      showToast("无法启动QQ",context: context);
    }
  }
  static shareGrid(BuildContext context,{
    url=null
    ,title="云智校app"
    ,content="食堂线上下单、快速预定，告别排队"}){
    if(url==null){
      var model = Provider.of<SystemStaticModel>(context);
      url=model.systemStaticInfo.staticData.share;
    }

    SSDKMap params = SSDKMap()
      ..setGeneral(
        title,
        content,
        [""],
        'http://lc-aveFaAUx.cn-n1.lcfile.com/89b0dceff76af220dd18/ic_launcher.png',
        null,
        url,
        url,
        null,
        null,
        null,
        SSDKContentTypes.webpage,
      );
    SharesdkPlugin.showMenu(
        [qq
          ,qZone
          ,wechatSession,wechatTimeline
          ,weChatFavorites
    ]
        , params, (SSDKResponseState state, ShareSDKPlatform platform,
        Map userData,Map contentDntity, SSDKError error) {
    });
  }
}