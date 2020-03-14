import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_customer_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_payment_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_commodity_detail_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class HomeShopCartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeShopCartPageState();
}

class _HomeShopCartPageState extends State<HomeShopCartPage> {

  ShopCartListModel globalModel;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        title: Text(
          "购物车",
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          RaisedButton(
            color: primaryColor,
            elevation: 0.0,
            onPressed: () {
              globalModel.clearCartListInfo();
            },
            child: Text(
              "清空",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ProviderWidget<ShopCartListModel>(
        model: ShopCartListModel(),
        onModelReady: (model) {
          model.initData();
          globalModel = model;
        } ,
        builder: (BuildContext context, ShopCartListModel model, Widget child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          }
          if (model.error) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
          return CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: _sliverBuilder(model),
          );
        },
      ),
    );
  }

  _sliverBuilder(ShopCartListModel model) {
    return <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                child: MyCard(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Text(
                                  model.list[index].shop.name,
                                  style: TextStyle(fontSize: 18),
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
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                model.clearCartListInfo(shopId: model.list[index].shop.id);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.list[index].cartCommodityCartRelate.length,
//                    controller: _listScrollController,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    WrapperImage(
                                      url:
                                      model.list[index].cartCommodityCartRelate[i].commodity.img,
                                      width: 60,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          model.list[index].cartCommodityCartRelate[i].commodity.name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("x${model.list[index].cartCommodityCartRelate[i].quantity}")
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "¥${model.list[index].totalPrice}",
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                              ],
                            ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
//                          Row(
//                            children: <Widget>[
//                              Text(
//                                "还差",
//                                style: TextStyle(color: Colors.grey),
//                              ),
//                              Text(
//                                "140",
//                                style: TextStyle(color: Colors.deepOrange),
//                              ),
//                              Text(
//                                "元起送",
//                                style: TextStyle(color: Colors.grey),
//                              ),
//                            ],
//                          ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "合计",
                                  style: TextStyle(color: Colors.black, fontSize: 17),
                                ),
                                Text(
                                  "¥${model.list[index].totalPrice}",
                                  style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      child: Text("去下单", style: TextStyle(color: Theme.of(context).primaryColor),),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(2)
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.pushNamed(context, RouteName.homeShopPayment, arguments: ShopPaymentParam(
                                        model.list[index].shop.name, model.list[index].shop.id
                                    )).then((result){
                                      model.refresh();
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(
                      context, RouteName.homeShopDetail, arguments:model.list[index].shop.id).then((result){
                  });
                },
              ),
            );
          },
          childCount: model.list.length,
        ),
      )
    ];
  }
}
