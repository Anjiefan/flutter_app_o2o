import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/apis/api.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class ShopSettingsBasicInfoQRCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShopSettingsBasicInfoQRCodePageState();
}

class ShopSettingsBasicInfoQRCodePageState
    extends State<ShopSettingsBasicInfoQRCodePage> {

  var qrCodeLink = "";

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var width = MediaQuery.of(context).size.width;
    qrCodeLink='${Api.BASE_URL}shop_o2o_erweima?shopid=${userModel.user.shop.id}';
    return Scaffold(
      appBar: AppBar(
        title: Text("门店二维码"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(top: 10),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text(
//                          userModel.user.shop.name,
//                          style: TextStyle(fontSize: 18),
//                        ),
//                      ],
//                    ),
//                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "保存二维码，贴至店铺前。",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          "让更多人更快找到我的店铺。",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        //让更多人更快找到我的店铺
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: WrapperImage(
                url: qrCodeLink,
                width: 270,
                height: 480,
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text(
                      "云智校店铺二维码",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 10,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200)
                      ),
                      onPressed: () async {
                        var response = await Dio().get(qrCodeLink, options: Options(responseType: ResponseType.bytes));
                        var result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
                        if (result != null) {
                          showToast("店铺二维码已经保存到图库");
                        }else {
                          showToast("保存失败，请尝试截屏");
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "保存二维码",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
