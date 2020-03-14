import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_customer_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_payment_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class OrderDetailPage extends StatefulWidget {
  final int orderId;

  const OrderDetailPage({Key key, this.orderId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      ProviderWidget(model: OrderDetailModel(widget.orderId),
        onModelReady: (model){
          model.refresh();
        },
        builder: (BuildContext context, OrderDetailModel model, Widget child) {
          if (model.busy){
            return ViewStateBusyWidget();
          }
          return Stack(
            children: <Widget>[
              CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: _sliverBuilder(model),
              ),
            ],
          );
        },

      ),
    );
  }

  _sliverBuilder(OrderDetailModel model) {
    var primaryColor = Theme.of(context).primaryColor;
    return <Widget>[
      SliverAppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: (){
            Navigator.pushReplacementNamed(context, RouteName.tab, arguments: 2);
          },
        ),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        elevation: 1.0,
        expandedHeight: 20.0,
        pinned: true,
        title: Text(
          "订单详情",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: <Widget>[],
      ),
      SliverPersistentHeader(
        pinned: false,
        delegate: SliverAppBarDelegate(
            Column(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: null,
                  ),
                  child: Container(
//                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    height: 120.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 15),
                      child: MyCard(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                model.order.status,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RouteName.userWalletRMBDetail);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            model.order.serviceNumber.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 34,fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
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
              ],
            ),
            120.0),
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
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: MyCard(
                        borderRadius: BorderRadius.circular(12),
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
                                    itemCount: model.order.getOrderCommodityOrderRelate.length,
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
                                              PhysicalModel(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.transparent,
                                                clipBehavior: Clip.antiAlias,
                                                child: WrapperImage(
                                                  url: model.order.getOrderCommodityOrderRelate[index].commodity.img,
                                                  width: 60,
                                                  height: 60,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    model.order.getOrderCommodityOrderRelate[index].commodity.name,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text("x${model.order.getOrderCommodityOrderRelate[index].quantity}")
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "¥${model.order.getOrderCommodityOrderRelate[index].commodity.price}",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                              fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Divider(
                              height: 4,
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "订单备注",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    model.order.remark == null? "无":model.order.remark,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14
                                    ),
                                  ),
                                ],
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
                                children: <Widget>[Text("小计"), SizedBox(width: 10,), Text("¥${model.order.discountMoney}", style: TextStyle(fontSize: 20),)],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: MyCard(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "订单信息",
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
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "订单号",
                                    style:
                                    TextStyle(),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        model.order.id.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                      Container(child: VerticalDivider(color: Colors.grey,), height: 10,),
                                      Text("复制", style: TextStyle(color: primaryColor),)
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            Divider(
                              height: 4,
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "支付方式",
                                    style:
                                    TextStyle(),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        model.order.payType == "校园币"?"人民币余额支付":"校园币余额支付",
                                        style: TextStyle(fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            Divider(
                              height: 4,
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "下单时间",
                                    style:
                                    TextStyle(),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        model.order.date,
                                        style: TextStyle(fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
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
}
