import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/models/order_category_type.dart';
import 'package:yunzhixiao_business_client/utils/chat_utils.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class OrderCard<T extends OrderListModel> extends StatelessWidget {
  List<String> pickupTimeChoices = ["立即就餐", "半小时后就餐", "1小时后就餐", "2小时后就餐"];

  List<Color> cardColors = [
    Colors.red,
    Colors.orange,
    Colors.blue,    Colors.green
  ];
  Order order;
  BuildContext bc;
  bool operate;
  OrderCard({this.order, this.bc, this.operate = true});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(3),
                        child: Text(
                          '${order.serviceNumber}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        color: cardColors[order.pickUpTimeChoice],
                      ),
                      Container(
                        child: Text('时间：${order.date}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Container(
                    child: Text('${order.commodityStatus}',
                        style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -2.5),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, top: 10, bottom: 15, right: 20),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              order.userInfo.phoneNum,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.phone,
                          size: 16,
                        ),
                        onTap: () async {
                          var url = "tel:${order.userInfo.phoneNum}";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            showToast("拨号失败");
                          }
                        },
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text('${order.num} 件商品',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Gaps.hGap12,
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          "${order.pickUpType == 0 ? "堂食就餐" : "打包就餐"}",
                          style: TextStyle(
                              color: cardColors[order.pickUpTimeChoice],
                              fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: cardColors[order.pickUpTimeChoice])),
                      ),
                      Gaps.hGap12,
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          "${pickupTimeChoices[order.pickUpTimeChoice]}",
                          style: TextStyle(
                              color: cardColors[order.pickUpTimeChoice],
                              fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: cardColors[order.pickUpTimeChoice])),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  order.remark != null
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                '备注：',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.orange),
                              ),
                            ),
                            Container(
                              child: Text(
                                '${order.remark}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                ]
                  ..addAll(order.getOrderCommodityOrderRelate.map((commodity) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              commodity.commodity.name,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '*${commodity.quantity}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${commodity.commodity.price}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            width: width * 0.2,
                          ),
                        ],
                      ),
                    );
                  }).toList())
                  ..addAll([
                    order.afterSell != null && order.afterSell.reason != null
                        ? Divider()
                        : Container(),
                    order.afterSell != null && order.afterSell.reason != null
                        ? Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '退款原因：',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.orange),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${order.afterSell.reason}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    order.afterSell != null &&
                            order.afterSell.detailReason != null
                        ? Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '详细说明：',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.orange),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${order.afterSell.detailReason}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                          left: 0, top: 10, bottom: 10, right: 0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '取餐时间',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${order.pickUpTime}',
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                          left: 0, top: 10, bottom: 10, right: 0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '本单收入',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            child: Text(
                              '¥${order.discountMoney}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    operate
                        ? Consumer<T>(builder: (context, model, child) {
                            return Row(
                              children: get_bottun(context, model),
                            );
                          })
                        : Container()
                  ]),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2.5),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get_bottun(BuildContext context, T model) {
    var theme = Theme.of(context);
    switch (order.commodityStatusId) {
      case -1:
        return [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2.5),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              width: 100,
              alignment: Alignment.center,
              child: Text('拒单'),
            ),
            onTap: () {
              model.refuseOrder(order.id, context);
              if (bc != null) {
                Navigator.pop(bc);
              }
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2.5),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                alignment: Alignment.center,
                child: Text(
                  '接单',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                model.reciveOrder(order.id, context);
                if (bc != null) {
                  Navigator.pop(bc);
                }
              },
            ),
          )
        ];
      case 0:
        return [
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2.5),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                alignment: Alignment.center,
                child: Text(
                  '完成备餐',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                model.waitingTakeOrder(order.id, context);
                Navigator.pop(context);
              },
            ),
          )
        ];
      case 1:
        return [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2.5),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              width: 100,
              alignment: Alignment.center,
              child: Text('联系客服'),
            ),
            onTap: () {
              ChatUtils.qqChat(context);
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2.5),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                alignment: Alignment.center,
                child: Text(
                  '完成取餐',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                model.archiveTakeOrder(order.id, context);
                if (bc != null) {
                  Navigator.pop(bc);
                }
              },
            ),
          )
        ];
      case 2: //催单
        return [
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2.5),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                alignment: Alignment.center,
                child: Text(
                  '加急中',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () async {
                await model.reviceUrgent(order.id, context);
                if (bc != null) {
                  Navigator.pop(bc);
                }
              },
            ),
          )
        ];
      case 3: //取消订单
        return [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2.5),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              width: 100,
              alignment: Alignment.center,
              child: Text('拒绝'),
            ),
            onTap: () {
              model.refuseCancel(order.id, context);
              if (bc != null) {
                Navigator.pop(bc);
              }
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: theme.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2.5),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              alignment: Alignment.center,
              child: Text(
                '同意',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              model.agreeCancel(order.id, context);
              if (bc != null) {
                Navigator.pop(bc);
              }
            },
          ))
        ];
    }
  }
}
