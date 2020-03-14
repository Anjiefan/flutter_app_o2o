import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/commons/utils/image_utils.dart';
import 'package:yunzhixiao_business_client/models/school_list.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_basic_info_school.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_type_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class ShopSettingsBasicInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShopSettingsBasicInfoPageState();
}

class ShopSettingsBasicInfoPageState extends State<ShopSettingsBasicInfoPage> {
  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("基本信息"),
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
                      Text("门店头像"),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Opacity(
                          opacity: 0.6,
                          child: WrapperImage(
                            url: userModel.user.shop.logo
                            ,width: 40,height: 40,),
//                          Image.network(
//                            userModel.user == null ? "" : userModel.user.shop.logo,
//                            width: 40,
//                            height: 40,
//
//                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () async {
                    try {
                      var _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800);
                      ImageUtils.putFile(_imageFile, (value) async {
                        Map uploadInfo = json.decode(value);
                        String realUrl = uploadInfo["url"];
                        userModel.updateUserShopInfo({
                          "logo": realUrl
                        }, context);
                      });
                      setState(() {});
                    } catch (e) {
                      showToast('请先授权相册权限。');
                    }
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
                      Text("门店名称"),
                      Text(
                        userModel.user == null ? "" : userModel.user.shop.name,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(context,
                        InputTextPage(
                          title: '门店名称',
                          hintText: '请填写门店名称',
                          textMaxLength: 15,
                          content: userModel.user == null ? "" : userModel.user.shop.name,
                        ), (result) {
                          setState(() {
                            userModel.updateUserShopInfo({
                              "name": result
                            }, context);
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
                      Text("门店ID"),
                      Text(
                        userModel.user == null ? "" : userModel.user.shop.id.toString(),
                        style: TextStyle(color: Colors.grey,fontSize: 14),
                      )
                    ],
                  ),
                  trailing: SizedBox(
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("订餐电话"),
                      Text(
                        userModel.user == null ? "" : userModel.user.shop.phoneNum,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(context,
                        InputTextPage(
                          title: '订餐电话',
                          hintText: '请填写订餐电话',
                          textMaxLength: 30,
                          content: userModel.user == null ? "" : userModel.user.shop.phoneNum,
                        ), (result) {
                          setState(() {
                            userModel.updateUserShopInfo({
                              "phone_num": result
                            }, context);
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
                      Text("门店地址"),
                      Text(
                        userModel.user == null ? "" : userModel.user.shop.address,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(context,
                        InputTextPage(
                          title: '门店地址',
                          hintText: '请填写门店地址',
                          textMaxLength: 30,
                          content: userModel.user == null ? "" : userModel.user.shop.address,
                        ), (result) {
                          setState(() {
                            userModel.updateUserShopInfo({
                              "address": result
                            }, context);
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
                      Text("门店品类"),
                      Text(
                        userModel.user == null ? "" : userModel.user.shop.type.name,
                        style: TextStyle(color: Colors.grey,  fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(context,
                        ShopTypePage(

                        ), (result) {
                          setState(() {
                            userModel.updateUserShopInfo({
                              "type": result
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
                      Text("学校"),
                      Text(
                        userModel.user == null ? "" : userModel.user.shop.school.name,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    NavigatorHelper.pushResult(context,
                        ShopSettingsBasicInfoSchoolPage(
                          title: '选择学校',
                          hintText: '搜索学校',
                          textMaxLength: 30,
                          content: "",
                        ), (result) {
                            var item = result as SchoolItem;
                            int id = item.id;
                            setState(() {
                              userModel.updateUserShopInfo({
                                "school": id
                              }, context);
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
                      Text("门店二维码"),
                      Icon(
                        Icons.select_all,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.userShopSettingsBasicInfoQRCode);
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
