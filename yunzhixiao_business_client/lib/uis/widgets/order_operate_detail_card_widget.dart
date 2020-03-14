import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/utils/chat_utils.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class OrderOperateCard<T extends OrderListModel> extends StatelessWidget {
  List<String> pickupTimeChoices = ["立即就餐", "半小时后就餐", "1小时后就餐", "2小时后就餐"];

  List<Color> cardColors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green
  ];

  Order order;
  BuildContext bc;
  bool operate;
  final OrderHomeInfoModel orderHomeInfoModel;
  OrderOperateCard(
      {this.order, this.bc, this.operate = true, this.orderHomeInfoModel});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: width,
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
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
                        "${order.serviceNumber}",
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
          Container(
            height: 50,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text('${order.num} 件商品',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          Gaps.hGap12,
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "${order.pickUpType == 0? "堂食就餐": "打包就餐"}",
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
                      Expanded(child: Container()),
                      IconButton(
                          icon: Icon(
                            Icons.phone_in_talk,
                            size: 20,
                            color: theme.primaryColor,
                          ),
                          onPressed: () async {
                            var url = "tel:${order.userInfo.phoneNum}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              showToast("拨号失败");
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Divider(
              height: 1,
            ),
            color: Colors.white,
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: height / 1.5 - 335,
            color: Colors.white,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: order.getOrderCommodityOrderRelate.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            order.getOrderCommodityOrderRelate[index].commodity
                                .name,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '*${order.getOrderCommodityOrderRelate[index].quantity}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${order.getOrderCommodityOrderRelate[index].commodity.price}',
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
                }),
          ),
          Container(
            child: Divider(
              height: 1,
            ),
            color: Colors.white,
          ),
          Container(
            height: 100,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 2, bottom: 2, right: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '备注：',
                          style: TextStyle(fontSize: 16, color: Colors.orange),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${order.remark == null ? '无' : order.remark}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                order.afterSell != null && order.afterSell.reason != null
                    ? Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          bottom: 2,
                          right: 20,
                        ),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '退款原因：',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${order.afterSell.reason}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                order.afterSell != null && order.afterSell.reason != null
                    ? Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          bottom: 2,
                          right: 20,
                        ),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '详细原因：',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange),
                              ),
                            ),
                            Expanded(
                              child:
//                  Text('拨号失败拨号失败拨号失败拨号失败adfadfdfsdfsdfdfaf}',style: TextStyle(fontSize: 16),),

                                  Text(
                                '${order.afterSell.detailReason}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),

          Container(
            child: Divider(
              height: 1,
            ),
            color: Colors.white,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
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
//  Container(
//             child: Divider(height: 1,),
//             color: Colors.white,
//           ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
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
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Divider(
              height: 1,
            ),
            color: Colors.white,
          ),
          Container(
            height: 80,
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            child: Consumer<T>(builder: (context, model, child) {
              return Row(
                children: get_bottun(context, model),
              );
            }),
            color: Colors.white,
          ),
//          Expanded(child: Container(color: Colors.white,))
        ],
      ),
    );
  }

  List<Widget> get_bottun(BuildContext context, T model) {
    var theme = Theme.of(context);
    model.orderHomeInfoModel = orderHomeInfoModel;
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
