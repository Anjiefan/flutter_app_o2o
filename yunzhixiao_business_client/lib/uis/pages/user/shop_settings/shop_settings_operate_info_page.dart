import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_operate_info_datetime_page.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class ShopSettingsOperateInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShopSettingsOperateInfoPageState();
}

class ShopSettingsOperateInfoPageState
    extends State<ShopSettingsOperateInfoPage> {
  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("营业信息"),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("营业时间"),
                      Text(
                        "${userModel.user == null ? "" : userModel.user.shop.startTime}:${userModel.user == null ? "" : (userModel.user.shop.startTimeMinute >= 0 && userModel.user.shop.startTimeMinute < 10 ? "0${userModel.user.shop.startTimeMinute}" : userModel.user.shop.startTimeMinute)}-${userModel.user == null ? "" : userModel.user.shop.endTime}:${userModel.user == null ? "" : (userModel.user.shop.endTimeMinute >= 0 && userModel.user.shop.endTimeMinute < 10 ? "0${userModel.user.shop.endTimeMinute}" : userModel.user.shop.endTimeMinute)}",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(
                        context,
                        ShopSettingsOperateInfoDateTimePage(
                          title: '营业时间',
                          startHours: userModel.user.shop.startTime,
                          startMinutes:
                              userModel.user.shop.startTimeMinute >= 0 &&
                                      userModel.user.shop.startTimeMinute < 10
                                  ? "0${userModel.user.shop.startTimeMinute}"
                                  : userModel.user.shop.startTimeMinute,
                          endHours: userModel.user.shop.endTime,
                          endMinutes: userModel.user.shop.endTimeMinute >= 0 &&
                                  userModel.user.shop.endTimeMinute < 10
                              ? "0${userModel.user.shop.endTimeMinute}"
                              : userModel.user.shop.endTimeMinute,
                        ), (result) {
                      setState(() {
                        var item = result as OperateTimeItem;
                        userModel.updateUserShopInfo({
                          "start_time": item.startHours,
                          "start_time_minute": item.startMinutes,
                          "end_time": item.endHours,
                          "end_time_minute": item.endMinutes
                        }, context);
//                            _shopIntroduction =result.toString();
                      });
                    });
                  },
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("门店公告"),
                      Text(
                userModel.user.shop.show == null ? "" : '${userModel.user.shop.show.substring(
                            0,userModel.user.shop.show.length>=8?8:userModel.user.shop.show.length)}...',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(
                        context,
                        InputTextPage(
                          title: '门店公告',
                          hintText: '请填写门店公告',
                          textMaxLength: 30,
                          content: userModel.user == null
                              ? ""
                              : userModel.user.shop.show,
                        ), (result) {
                      setState(() {
                        userModel.updateUserShopInfo({"show": result}, context);
//                            _shopIntroduction =result.toString();
                      });
                    });
                  },
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("门店简介"),
                      Text(
                        userModel.user.shop.desc == null ? "" : '${userModel.user.shop.desc.substring(0,userModel.user.shop.desc.length>=8?8:userModel.user.shop.desc.length)}...',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(
                        context,
                        InputTextPage(
                          title: '门店简介',
                          hintText: '请填写门店简介',
                          textMaxLength: 30,
                          content: userModel.user == null
                              ? ""
                              : userModel.user.shop.desc,
                        ), (result) {
                      setState(() {
                        userModel.updateUserShopInfo({"desc": result}, context);
//                            _shopIntroduction =result.toString();
                      });
                    });
                  },
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
                            Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("打包费用"),
                      Text(
                        userModel.user == null ? "" : '${userModel.user.shop.packingCharge}元',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(
                        context,
                        InputTextPage(
                          title: '打包费用',
                          hintText: '请填写打包金额',
                          textMaxLength: 30,
                          keyboardType: TextInputType.number,
                          content: userModel.user == null
                              ? ""
                              : userModel.user.shop.packingCharge.toString()
                        ), (result) {
                      setState(() {
                        userModel.updateUserShopInfo({"packing_charge": result}, context);
//                            _shopIntroduction =result.toString();
                      });
                    });
                  },
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
