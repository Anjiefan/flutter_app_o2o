import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_customer_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/cart_info.dart';
import 'package:yunzhixiao_customer_client/models/commodity.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/models/shop_comment.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_controller.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_coordinator.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_comment_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_commodity_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_info_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_payment_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/comment_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_cupertino_modal_popup.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/utils/auth_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_commodity_detail_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class HomeShopDetailSingleCommodityPage extends StatefulWidget {
  final SingleCommodityParam param;

  HomeShopDetailSingleCommodityPage({Key key, this.param}) : super(key: key);

  @override
  _HomeShopDetailSingleCommodityPageState createState() =>
      _HomeShopDetailSingleCommodityPageState();
}

class _HomeShopDetailSingleCommodityPageState
    extends State<HomeShopDetailSingleCommodityPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

//  buildPromotionWidgets(Shop shop) {
//    var promotions = shop.promotionList;
//    List<Widget> returnList = [];
//    int i = 0;
//    promotions.forEach((value) {
//      if (i == 3) {
//        return;
//      }
//      returnList.add(PromotionLable(
//        text: value,
//      ));
//      i++;
//    });
//    if (returnList.length <= 3) {
//      return [
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: returnList,
//        ),
//      ];
//    }
//  }

  @override
  Widget build(BuildContext context) {
    mediaQuery ??= MediaQuery.of(context);
    screenHeight ??= mediaQuery.size.height;
    statusBarHeight ??= mediaQuery.padding.top;

    CartCommodityCartRelate checkIfExistInCart(
        int commodityId, ShopCartSelfModel model) {
      CartCommodityCartRelate cartCommodityCartRelate;
      model.list.forEach((item) {
        if (item.commodity.id == commodityId) {
          cartCommodityCartRelate = item;
          return;
        }
      });
      return cartCommodityCartRelate;
    }

    return Scaffold(
        body: ProviderWidget2<ShopCartSelfModel,CommodityCommentListModel>(
            model1: ShopCartSelfModel(widget.param.commodity.shop),
            model2: CommodityCommentListModel(widget.param.commodity.id),
            onModelReady: (model1,model2) {
              model1.initData();
              model2.initData();
            },
            builder:
                (BuildContext context,model,model2, Widget child) {
              if (model.busy||model2.busy) {
                return ViewStateBusyWidget();
              }

              if (model.error) {
                return ViewStateErrorWidget(
                    error: model.viewStateError, onPressed: model.initData);
              }
              if (model2.error) {
                return ViewStateErrorWidget(
                    error: model2.viewStateError, onPressed: model2.initData);
              }
              return CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: screenHeight / 2-20,
                      elevation: 0.0,
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: 30,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: new Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.grey[500].withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {

                        return Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              height: 300,
                                              child: Stack(
                                                children: <Widget>[
                                                  WrapperImage(
                                                      width: double.infinity,
                                                      height: 300,
                                                      url: widget
                                                          .param.commodity.img),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Text(
                                            widget.param.commodity.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                              '月售${widget.param.commodity.sellNumMonth}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[400])),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                '¥${widget.param.commodity.price}',
                                                style: TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(right: 10),
                                                  color: Colors.white,
                                                  child: checkIfExistInCart(
                                                      widget.param
                                                          .commodity.id,
                                                      model) !=
                                                      null
                                                      ? Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .end,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          model.updateCartInfoNum(
                                                              widget
                                                                  .param
                                                                  .commodity
                                                                  .id,
                                                              -1);
                                                          model
                                                              .notifyListeners();
                                                          model.refresh();
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColor,
                                                          size: 22,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        "${checkIfExistInCart(widget.param.commodity.id, model).quantity}",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          model.updateCartInfoNum(
                                                              widget
                                                                  .param
                                                                  .commodity
                                                                  .id,
                                                              1);
                                                          model
                                                              .notifyListeners();
                                                          model.refresh();
                                                        },
                                                        child: Icon(
                                                            Icons
                                                                .add_circle,
                                                            color: Theme.of(
                                                                context)
                                                                .primaryColor,
                                                            size: 22),
                                                      ),
//                                                                SizedBox(width: 12,),
                                                    ],
                                                  )
                                                      : Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .end,
                                                    children: <Widget>[
//                                                                SizedBox(width: 12,),
                                                      GestureDetector(
                                                        onTap: () {
                                                          ErrorUtils.auth_401_error(context,(){
                                                            model.updateCartInfoNum(
                                                                widget
                                                                    .param
                                                                    .commodity
                                                                    .id,
                                                                1);
                                                            model
                                                                .notifyListeners();
                                                            model.refresh();
                                                          });

                                                        },
                                                        child: Icon(
                                                            Icons
                                                                .add_circle,
                                                            color: Theme.of(
                                                                context)
                                                                .primaryColor,
                                                            size: 22),
                                                      ),
//                                                                SizedBox(width: 12,),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                  SliverFillRemaining(
                    child: Stack(
                      children: <Widget>[
                        Consumer<CommodityCommentListModel>(
                          builder: (BuildContext context,
                              CommodityCommentListModel model1,
                              Widget child) {
                            return SmartRefresher(
                                controller: model1.refreshController,
                                enablePullUp: true,
                                enablePullDown: false,
                                onLoading: model1.loadMore,
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: SliverAppBarDelegate(Container(
                                        color: Colors.white,
                                        child: Container(
                                          height: 50,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: _buildChoiceList(model1
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                          50),
                                    ),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) {
                                          CommodityCommentItem item=model1.list[index];
                                          return CommentCard(username: item.userInfo.username
                                            ,img: item.userInfo.headImg,good: item.isGood,date: item.date,content: item.content,);
                                        },
                                        childCount:  model1.list.length,
                                      ),
                                    )
                                  ],

                                )
                            );
                          },
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
                                  onTap: () {
                                    _shopCartModalBottomSheet(context,
                                        widget.param.commodity.shop, model);
                                  },
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 65,
                                          child: Stack(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    bottom: 4,
                                                    top: 4),
                                                child: Image.asset(
                                                  ImageHelper.wrapAssets(
                                                      "openBox.png"),
                                                  width: 42,
                                                  height: 42,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  //I used some padding without fixed width and height
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    // You can use like this way or like the below line
                                                    color: Colors.red,
                                                  ),
                                                  child: new Text(
                                                      model.list.length
                                                          .toString(),
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                          12.0)), // You can add a Icon instead of text also, like below.
                                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "¥${model.totalPrice??0}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
//                                Text(
//                                  "另需手续费5元",
//                                  style: TextStyle(
//                                      color: Colors.grey, fontSize: 10),
//                                )
                                          ],
                                        )
                                      ],
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.67,
                                    color: Colors.black
                                        .withOpacity(1.0)
                                        .withAlpha(200),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (model.list.length == 0) {
                                      showToast("购物车不能为空");
                                      return;
                                    }
                                    Navigator.pushNamed(
                                        context, RouteName.homeShopPayment,
                                        arguments: ShopPaymentParam(
                                            widget.param.shopName,
                                            model.shopId))
                                        .then((result) {
                                      model.refresh();
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "去结算",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _shopCartModalBottomSheet(context, int shopId, ShopCartSelfModel model) {
    showMyCupertinoModalPopup(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (bc, state) {
              return Material(
                child: Container(
                  child: new Wrap(
                    children: <Widget>[
                      Container(
                        color: Colors.grey[200],
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "已选商品",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  model.clearCartSelfInfo();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    Text(
                                      "清空",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.white,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.list[index].commodity.name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "¥${model.list[index].commodity.price}",
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 18),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await model.updateCartInfoNum(
                                              model.list[index].commodity.id,
                                              -1);
                                          if (model.list.length == 0) {
                                            Navigator.pop(context);
                                          }
                                          state(() {});
                                        },
                                        icon: Icon(
                                          Icons.remove_circle_outline,
                                          color: Theme.of(context).primaryColor,
                                          size: 22,
                                        ),
                                      ),
                                      Text(
                                        "${model.list[index].quantity}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await model.updateCartInfoNum(
                                              model.list[index].commodity.id,
                                              1);
                                          state(() {});
                                        },
                                        icon: Icon(Icons.add_circle,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 22),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          padding: EdgeInsets.all(0),
                          physics: ClampingScrollPhysics(),
                          itemCount: model.list.length,
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  List selectedChoices = [0];

  _buildChoiceList(model1) {
    List<Widget> choices = List();

    [
      ['全部 ${widget.param.commodity.commentNum??0}', 0],
      ['好评 ${widget.param.commodity.likeCommentNum??0}', 1],
      ['差评 ${widget.param.commodity.dislikeCommentNum??0}', 2]
    ].forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          label: Text(
            item[0],
            style: TextStyle(
                color: Colors.white,
                fontWeight: selectedChoices.contains(item[1])
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          backgroundColor: item[1] == 2 ? Colors.grey[400] : Colors.blue[200],
          selectedColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          selected: selectedChoices.contains(item[1]),
          onSelected: (selected) {
            setState(() {
              if (selectedChoices.contains(item[1])) {
              } else {
                selectedChoices.clear();
                selectedChoices.add(item[1]);
                switch (item[1]) {
                  case 0:
                    model1.onRefreshIsGood(null);
                    break;
                  case 1:
                    model1.onRefreshIsGood(1);
                    break;
                  case 2:
                    model1.onRefreshIsGood(0);
                    break;
                }
              }
            });
          },
        ),
      ));
      choices.add(SizedBox(
        width: 10,
      ));
    });

    return choices;
  }
}

class SingleCommodityParam {
  final ShopCommodityInfoListModel shopCommodityInfoListModel;
  final ShopCartSelfModel shopCartListModel;
  final Commodity commodity;
  final String shopName;
  final int shopId;

  SingleCommodityParam(this.shopCommodityInfoListModel, this.shopCartListModel,
      this.commodity, this.shopName, this.shopId);
}
