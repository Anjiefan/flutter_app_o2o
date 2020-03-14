import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/apis/api.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/service/user_repository.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class OrderQRCodePage extends StatefulWidget {
  Order order;
  OrderQRCodePage({this.order});
  @override
  State<StatefulWidget> createState() => OrderQRCodePageState();
}

class OrderQRCodePageState
    extends State<OrderQRCodePage> {

  var qrCodeLink = "";

  @override
  void initState() {
    super.initState();
    qrCodeLink='${Api.BASE_URL}shop_erweima/?shopid=${widget.order.shop.id}';
//    UserRepository.getShopQRCode(widget.order.shop.id).then((value){
//      setState(() {
//        qrCodeLink = value["info"];
//      });
//    });

  }

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final height =size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("取餐二维码"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: MyCard(
                    borderRadius:BorderRadius.circular(12),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    "提示",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "请凭餐号前往对应餐铺取餐，平台退还保证金。",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          //                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          height: 120.0,

                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6, left: 37, right: 37),
                            child: Container(
                              alignment: Alignment.center,

                              child: MyCard(
                                borderRadius: BorderRadius.circular(12),
                                color: theme.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '取餐号',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  widget.order.serviceNumber.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 34,fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width*0.8,
                            height: width*0.8,
                            child: WrapperImage(
                              url: qrCodeLink,
                              width: width*0.8,
                              height: width*0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
