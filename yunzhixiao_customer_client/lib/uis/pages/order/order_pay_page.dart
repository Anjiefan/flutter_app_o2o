import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/models/red_packet.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_customer_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_commodity_detail_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_payment_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class OrderPaymentPage extends StatefulWidget {
  final Order order;
  const OrderPaymentPage({Key key, this.order}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage>
    with AutomaticKeepAliveClientMixin {
  List<String> pickUpTypeTexts = ["堂食就餐", "打包就餐"];
  List<String> pickUpTimeChoiceTexts = ["立即就餐", "半小时后就餐", "1小时后就餐", "2小时后就餐"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProviderWidget<ShopPaymentModel>(
      model: ShopPaymentModel(widget.order.shop.id, context),
      onModelReady: (model) {
        model.readOrderById(widget.order.id);
      },
      builder: (BuildContext context, ShopPaymentModel model, Widget child) {
        if (model.busy) {
          return ViewStateBusyWidget();
        }
        if (model.error) {
          return Container();
        }
        return Stack(
          children: <Widget>[
            CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: _sliverBuilder(model),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "¥${model.redPacket == null ? model.order.discountMoney : model.order.discountMoney - model.redPacket.promotionDiscountPrice}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: VerticalDivider(
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1.5),
                                  child: Text(
                                    "已优惠${model.redPacket == null ? 0 : (model.redPacket.promotionDiscountPrice)}元",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1.5),
                                  child: Text(
                                    "打包费${model.order.packingMoney}元",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width * 0.67,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        model.confirmOrder(context);
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "确认支付",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          ],
                        ),
                        width: MediaQuery.of(context).size.width * 0.33,
                        color: Colors.lightGreen.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }

  _sliverBuilder(ShopPaymentModel model) {
    var primaryColor = Theme.of(context).primaryColor;
    return <Widget>[
      SliverAppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        elevation: 1.0,
        expandedHeight: 20.0,
        pinned: true,
        title: Text(
          "确认订单",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: <Widget>[],
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          Stack(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: MyCard(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showPayTypeDialog(context, model);
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "支付方式",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${model.order.payType}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                             GestureDetector(
                              onTap: () {
                                showPickupTypeDialog(context, model);
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "取餐方式",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${pickUpTypeTexts[model.order.pickUpType]}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                showPickupTimeDialog(context, model);
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "取餐时间",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${pickUpTimeChoiceTexts[model.order.pickUpTimeChoice]}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigatorHelper.pushResult(
                                    context,
                                    InputTextPage(
                                      title: '联系电话',
                                      hintText: '请填写联系电话',
                                      textMaxLength: 30,
                                      content: model.order.phoneNum,
                                    ), (result) {
                                  model.order.phoneNum = result;
                                  model.notifyListeners();
                                });
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "联系电话",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      model.order.phoneNum,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: MyCard(
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
                                        model.order.shop.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: model.order
                                        .getOrderCommodityOrderRelate.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              WrapperImage(
                                                url: model
                                                    .order
                                                    .getOrderCommodityOrderRelate[
                                                        index]
                                                    .commodity
                                                    .img,
                                                width: 60,
                                                height: 60,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    model
                                                        .order
                                                        .getOrderCommodityOrderRelate[
                                                            index]
                                                        .commodity
                                                        .name,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                      "x${model.order.getOrderCommodityOrderRelate[index].quantity}")
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "¥${model.order.getOrderCommodityOrderRelate[index].commodity.price}",
                                            style: TextStyle(
                                                color: Colors.deepOrange),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
//                                  Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Text("手续费"),
//                                      Text("¥0.6")
//                                    ],
//                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                        context, RouteName.userRedPacket,
                                        arguments: model.shopId)
                                    .then((result) {
                                  RedPacket redPacket = result;
                                  model.promotionContent =
                                      "红包¥${redPacket.promotionDiscountPrice}";
                                  model.redPacket = redPacket;
                                  model.notifyListeners();
                                });
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "红包/抵用券",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      model.promotionContent,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                            Divider(
                              height: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigatorHelper.pushResult(
                                    context,
                                    InputTextPage(
                                      title: '订单备注',
                                      hintText: '请填写订单备注',
                                      textMaxLength: 30,
                                      content: model.order.remark == null
                                          ? ""
                                          : model.order.remark,
                                    ), (result) {
                                  model.order.remark = result;
                                  model.notifyListeners();
                                });
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "订单备注",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      model.order.remark == null
                                          ? "请填写备注信息"
                                          : (model.order.remark.length > 10
                                              ? model.order.remark
                                                  .substring(0, 10)
                                              : model.order.remark),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                            Divider(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("小计"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "¥${model.redPacket == null ? model.order.discountMoney : model.order.discountMoney - model.redPacket.promotionDiscountPrice}",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    ];
  }

  void showPayTypeDialog(BuildContext cxt, ShopPaymentModel model) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.payType = "余额支付";
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('余额支付')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.payType = "校园币支付";
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('校园币支付')),
            ],
          );
          return dialog;
        });
  }

  void showPickupTypeDialog(BuildContext cxt, ShopPaymentModel model) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.pickUpType = 0;
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('堂食就餐')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.pickUpType = 1;
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('打包就餐')),
            ],
          );
          return dialog;
        });
  }

  void showPickupTimeDialog(BuildContext cxt, ShopPaymentModel model) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.pickUpTimeChoice = 0;
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('立即就餐')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.pickUpTimeChoice = 1;
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('半小时后就餐')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.pickUpTimeChoice = 2;
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('1小时后就餐')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.order.pickUpTimeChoice = 3;
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('2小时后就餐')),
            ],
          );
          return dialog;
        });
  }

  @override
  bool get wantKeepAlive => true;
}
