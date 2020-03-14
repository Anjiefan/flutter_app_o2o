import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/commons/utils/image_utils.dart';
import 'package:yunzhixiao_business_client/models/school_list.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_basic_info_school.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_type_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/verification_edit_model.dart';

class LoginRegisterVerifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginRegisterVerifyPageState();
}

class LoginRegisterVerifyPageState extends State<LoginRegisterVerifyPage> {
  var _imageFile;
  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      model: VerificationEditModel(context),
      builder:
          (BuildContext context, VerificationEditModel model, Widget child) {
        if (model.busy) {
          return ViewStateBusyWidget();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("店铺信息审核"),
            leading: BackButton(onPressed: (){
              Navigator.pushReplacementNamed(context, RouteName.login);
            },),

          ),
          body: SingleChildScrollView(
            child: ListTileTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            model.status == -1 ? "当前状态：填写中" : "当前状态：审核中",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
                          Text("门店头像"),
                          _imageFile == null
                              ? WrapperImage(
                                  url: model.verificationInfo.logo,
                                  width: 40,
                                  height: 40,
                                )
//                      Image.network(
//                              userModel.user == null
//                                  ? ""
//                                  : userModel.user.shop.logo,
//                              width: 40,
//                              height: 40,
//                            )
                              : Image.file(
                                  _imageFile,
                                  width: 40,
                                  height: 40,
                                )
                        ],
                      ),
                      onTap: () {
                        try {
                          ImagePicker.pickImage(
                                  source: ImageSource.gallery, maxWidth: 800)
                              .then((value) {
                            setState(() {
                              _imageFile = value;
                              ImageUtils.putFile(_imageFile, (value) async {
                                Map uploadInfo = json.decode(value);
                                String realUrl = uploadInfo["url"];
                                model.verificationInfo.logo = realUrl;
                                model.notifyListeners();
                              });
                            });
                          });
                        } catch (e) {
                          print(e);
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
                            model.verificationInfo.name,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorHelper.pushResult(
                            context,
                            InputTextPage(
                              title: '门店名称',
                              hintText: '请填写门店名称',
                              textMaxLength: 15,
                              content: model.verificationInfo.name,
                            ), (result) {
                          model.verificationInfo.name = result;
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
                          Text("订餐电话"),
                          Text(
                            model.verificationInfo.phoneNum,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorHelper.pushResult(
                            context,
                            InputTextPage(
                              title: '订餐电话',
                              hintText: '请填写订餐电话',
                              textMaxLength: 11,
                              content: model.verificationInfo.phoneNum,

                            ), (result) {
                          model.verificationInfo.phoneNum = result;
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
                            model.verificationInfo.address,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorHelper.pushResult(
                            context,
                            InputTextPage(
                              title: '门店地址',
                              hintText: '请填写门店地址',
                              textMaxLength: 30,
                              content: model.verificationInfo.address,
                            ), (result) {
                          model.verificationInfo.address = result;
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
                            model.typeName,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorHelper.pushResult(context, ShopTypePage(),
                            (result) {
                          print(result);
                          var m = result as List;
                          model.typeId = m[0];
                          model.typeName = m[1];
                          model.notifyListeners();
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
                          Text("所属学校"),
                          Text(
                            model.schoolName,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorHelper.pushResult(
                            context,
                            ShopSettingsBasicInfoSchoolPage(
                              title: '选择学校',
                              hintText: '搜索学校',
                              textMaxLength: 30,
                              content: "",
                            ), (result) {
                          var item = result as SchoolItem;
                          int id = item.id;
                          model.schoolId = id;
                          model.schoolName = item.name;
                          model.notifyListeners();
                        });
                      },
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (
                            model.verificationInfo.logo.trim() == "" ||
                            model.verificationInfo.name.trim() == "" ||
                            model.verificationInfo.phoneNum.trim() == "" ||
                            model.verificationInfo.address.trim() == "" ||
                            model.typeName.trim() == "" ||
                            model.schoolName.trim() == ""
                           ){
                             showToast("信息填写不完整");
                             return;
                           }
                          
                          if (model.status == -1) {
                            //create
                            model.createVerificationInfo(context);
                          } else if (model.status == 0) {
                            model.updateVerificationInfo(context);
                          }

                        },
                        child: Text(
                          model.status == -1 ? "申请审核" : "修改审核",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      // SizedBox(width: 50,),
                      // RaisedButton(
                      //   color: Colors.red,
                      //   onPressed: () {
                      //     userModel.clearUser();
                      //     Navigator.pushReplacementNamed(context, RouteName.login);
                      //   },
                      //   child: Text(
                      //     "放弃审核",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
