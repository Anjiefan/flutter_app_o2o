import 'dart:async';

import 'package:fake_alipay/fake_alipay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/pay_order.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/order_repository.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_customer_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_payment_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class OrderCancelPage extends StatefulWidget {
  final int orderId;

  const OrderCancelPage({Key key, this.orderId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderCancelPageState();
}

class _OrderCancelPageState extends State<OrderCancelPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  _sliverBuilder() {
    var primaryColor = Theme.of(context).primaryColor;
    return <Widget>[
      SliverAppBar(
        leading: BackButton(),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        expandedHeight: 20.0,
        pinned: true,
        title: Text(
          "申请取消订单",
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[],
      ),
      SliverFillRemaining(
        child: ProviderWidget<OrderDetailModel>(
          model: OrderDetailModel(widget.orderId),
          onModelReady: (model) {
            model.refresh();
          },
          builder:
              (BuildContext context, OrderDetailModel model, Widget child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            }
            return Stack(
              children: <Widget>[
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
                                      "¥${model.order.sumMoney}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "退款将按原路返回",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                            if (model.orderCancelReason == null){
                              showToast("请选择一个退款原因。");
                              return;
                            }
                            model.confirmOrderCancel(context);
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "提交",
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
                ),

                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyCard(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "退款商品",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    model.order.getOrderCommodityOrderRelate.length,
                                itemBuilder: (context, i) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          WrapperImage(
                                            url: model
                                                .order
                                                .getOrderCommodityOrderRelate[i]
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
                                                    .getOrderCommodityOrderRelate[i]
                                                    .commodity
                                                    .name,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  "x${model.order.getOrderCommodityOrderRelate[i].quantity}")
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "¥${model.order.sumMoney}",
                                        style: TextStyle(color: Colors.deepOrange),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyCard(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "取消原因",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showDialog(context, model);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(model.orderCancelReason == null
                                            ? "点击选择原因（必选）"
                                            : model.orderCancelReason),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
                              child: Semantics(
                                multiline: true,
                                maxValueLength: 15,
                                child: TextField(
                                    maxLength: 15,
                                    maxLines: 1,
                                    autofocus: true,
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      hintText: "补充信息（选填）",
                                      border: InputBorder.none,
                                      //hintStyle: TextStyles.textGrayC14
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      )
    ];
  }

  void _showDialog(BuildContext cxt, OrderDetailModel model) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.orderCancelReason = "等待时间过长";
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('等待时间过长')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.orderCancelReason = "商家缺货，联系我取消";
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('商家缺货，联系我取消')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.orderCancelReason = "忘记使用红包";
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('忘记使用红包')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    model.orderCancelReason = "漏点/多点";
                    model.notifyListeners();
                    Navigator.pop(cxt);
                  },
                  child: Text('漏点/多点')),
            ],
          );
          return dialog;
        });
  }
}
