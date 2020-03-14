import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:yunzhixiao_customer_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/cart_info.dart';
import 'package:yunzhixiao_customer_client/models/commodity.dart';
import 'package:yunzhixiao_customer_client/models/shop_commodity_list.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_controller.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_coordinator.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_single_commodity_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_payment_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_cupertino_modal_popup.dart';
import 'package:yunzhixiao_customer_client/utils/auth_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_commodity_detail_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

class HomeShopDetailCommodityPage extends StatefulWidget {
  final ShopScrollCoordinator shopCoordinator;
  final int shopId;

  const HomeShopDetailCommodityPage(
      {@required this.shopCoordinator, Key key, this.shopId})
      : super(key: key);

  @override
  _HomeShopDetailCommodityPageState createState() =>
      _HomeShopDetailCommodityPageState();
}

class _HomeShopDetailCommodityPageState
    extends State<HomeShopDetailCommodityPage>
    with AutomaticKeepAliveClientMixin
    {
  @override
  bool get wantKeepAlive => true;
  ShopScrollCoordinator _shopCoordinator;
  ShopScrollController _listScrollController1;
  ShopScrollController _listScrollController2;
  var _keys = {};

  @override
  void initState() {
    _shopCoordinator = widget.shopCoordinator;
    _listScrollController1 = _shopCoordinator.newChildScrollController();
    _listScrollController2 = _shopCoordinator.newChildScrollController();

    super.initState();
  }
  ShopCommodityTypeListModel shopCommodityTypeListModel;
  ShopCommodityInfoListModel shopCommodityInfoListModel;
  ShopCartSelfModel shopCartListModel;
  ShopDetailModel shopDetailModel;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var listViewKey = RectGetter.createGlobalKey();
    List<int> getVisible() {
      /// First, get the rect of ListView, and then traver the _keys
      /// get rect of each item by keys in _keys, and if this rect in the range of ListView's rect,
      /// add the index into result list.
      var rect = RectGetter.getRectFromKey(listViewKey);
      var _items = <int>[];
      _keys.forEach((index, key) {
        var itemRect = RectGetter.getRectFromKey(key);
        if (itemRect != null &&
            !(itemRect.top > rect.bottom || itemRect.bottom < rect.top))
          _items.add(index);
      });

      /// so all visible item's index are in this _items.
      return _items;
    }


    return Consumer4<ShopCommodityTypeListModel, ShopCommodityInfoListModel,
        ShopCartSelfModel, ShopDetailModel>(
      builder: (BuildContext context,
          ShopCommodityTypeListModel shopCommodityTypeListModel,
          ShopCommodityInfoListModel shopCommodityInfoListModel,
          ShopCartSelfModel shopCartListModel,
          ShopDetailModel shopDetailModel,
          Widget child) {
        this.shopCommodityTypeListModel=shopCommodityTypeListModel;
        this.shopCommodityInfoListModel=shopCommodityInfoListModel;
        this.shopCartListModel=shopCartListModel;
        this.shopDetailModel=shopDetailModel;


        return Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      key: new PageStorageKey(0),
                      padding: EdgeInsets.all(0),
                      physics: ClampingScrollPhysics(),
                      controller: _listScrollController1,
                      itemCount: shopCommodityTypeListModel.list.length,
                      itemBuilder: (context, index) {
                      
                        return Container(
                          child: InkWell(
                              onTap: () {


                                int animateToIndex = 0;
                                for (int i = 0;
                                    i < shopCommodityInfoListModel.list.length;
                                    i++) {
                                  if (shopCommodityInfoListModel.list[i].id ==
                                      shopCommodityTypeListModel
                                          .list[index].index) {
                                    animateToIndex = i;
                                    print(
                                        "index=${shopCommodityInfoListModel.list[i].id}");
                                    break;
                                  }
                                }
                                _listScrollController2.animateTo(
                                  ((animateToIndex) * 100).toDouble(),
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear,
                                ).then((value){
                                     shopCommodityTypeListModel.onSelectedTypes(
                                      shopCommodityTypeListModel.list[index]);
                                  return value;
                                });


                              },
                              child: getTypeCard(shopCommodityTypeListModel.list[index], index)
                          ),
                        );
                      }),
                ),
                Expanded(
                  flex: 4,
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (notification) {
                      int firstOneIndex = getVisible()[0];
                      print('---firstOneIndex=${firstOneIndex}');
                      int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
                      if ((nowTimeStamp -
                                  shopCommodityTypeListModel.lastSelectedTime)
                              .abs() <=
                          3000) {
                        return true;
                      }
                      shopCommodityTypeListModel.list.forEach((types) {
                        if (types.id ==
                            shopCommodityInfoListModel
                                .list[firstOneIndex].type) {
                          print(
                              "shopCommodityTypeListModel.list.indexOf(types)=${shopCommodityTypeListModel.list.indexOf(types)}");
                          shopCommodityTypeListModel.onSelectedTypes(types);
                        }
                      });
                      return true;
                    },
                    child: RectGetter(
                      key: listViewKey,
                      child: ListView.builder(
                        key: new PageStorageKey(1),
                        padding: EdgeInsets.all(0),
                        physics: ClampingScrollPhysics(),
                        controller: _listScrollController2,
                        itemCount: shopCommodityInfoListModel.list.length,
                        itemBuilder: (context, index) {
                          _keys[index] = RectGetter.createGlobalKey();
                          return RectGetter(
                            key: _keys[index],
                            child: getCommodityCard(shopCommodityInfoListModel.list[index],index),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
                        shopDetailModel.shop.isOpen
                            ? _shopCartModalBottomSheet(context,
                                shopDetailModel.shop.id, shopCartListModel)
                            : showToast("门店已休息");
                      },
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 65,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 4, top: 4),
                                    child: Image.asset(
                                      ImageHelper.wrapAssets("openBox.png"),
                                      width: 42,
                                      height: 42,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      //I used some padding without fixed width and height
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        // You can use like this way or like the below line
                                        color: shopDetailModel.shop.isOpen
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      child: new Text(
                                          shopCartListModel.list.length
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "¥${shopCartListModel.totalPrice??0}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        width: MediaQuery.of(context).size.width * 0.67,
                        color: Colors.black.withOpacity(1.0).withAlpha(200),
                      ),
                    ),
                    GestureDetector(
                      onTap: shopDetailModel.shop.isOpen
                          ? () {
                              if (shopCartListModel.list.length == 0) {
                                showToast("购物车不能为空");
                                return;
                              }
                              Navigator.pushNamed(
                                      context, RouteName.homeShopPayment,
                                      arguments: ShopPaymentParam(
                                          shopDetailModel.shop.name,
                                          shopDetailModel.shop.id))
                                  .then((result) {
                                shopCartListModel.refresh();
                              });
                            }
                          : () {
                              showToast("门店已休息");
                            },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            shopDetailModel.shop.isOpen
                                ? Text(
                                    "去结算",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                : Text(
                                    "暂停接单",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                          ],
                        ),
                        width: MediaQuery.of(context).size.width * 0.33,
                        color: shopDetailModel.shop.isOpen
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
  getCommodityCard(Commodity commodity,int index){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: InkWell(
        onTap: shopDetailModel.shop.isOpen
            ? () {
          Navigator.pushNamed(
              context,
              RouteName
                  .homeShopDetailSingleCommodity,
              arguments: SingleCommodityParam(
                  shopCommodityInfoListModel,
                  shopCartListModel,
                  commodity,
                  shopDetailModel.shop.name,
                  shopDetailModel.shop.id))
              .then((value) {
            shopCartListModel.notifyListeners();
            shopCartListModel.refresh();
          });
        }
            : null,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft,
//                    height: 150,
                    padding: EdgeInsets.only(
                        right: 12,
                        left: 12,
                        top: 12,
                        bottom: 0),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: 12),
                          child: PhysicalModel(
                              clipBehavior:
                              Clip.antiAlias,
                              borderRadius:
                              BorderRadius.circular(
                                  8),
                              color: Colors.green,
                              child: WrapperImage(
                                url:
                                commodity
                                    .img,
                                height: 80,
                                width: 80,
                              )),
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: <Widget>[
                                Text(
                                  commodity.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                      EdgeInsets.only(
                                          right: 4),
                                      child: Text(
                                          '月售${commodity.sellNumMonth}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors
                                                  .grey[
                                              400])),
                                    ),
                                    Container(
                                        padding:
                                        EdgeInsets.only(
                                            right: 4),
                                        child: Text(
                                            '总销量${commodity.sellNum}',
                                            style: TextStyle(
                                                fontSize:
                                                12,
                                                color: Colors
                                                    .grey[
                                                400]))),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        '¥${commodity.price}',
                                        style: TextStyle(
                                            color: Colors
                                                .orange,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        child: checkIfExistInCart(
                                            commodity
                                                .id,
                                            shopCartListModel) !=
                                            null
                                            ? Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          children: <
                                              Widget>[
                                            SizedBox(
                                              width:
                                              12,
                                            ),
                                            GestureDetector(
                                              onTap: shopDetailModel.shop.isOpen
                                                  ? () {
                                                shopCartListModel.updateCartInfoNum(commodity.id, -1);
                                                shopCartListModel.notifyListeners();
                                                shopCartListModel.refresh();
                                              }
                                                  : null,
                                              child:
                                              Icon(
                                                Icons
                                                    .remove_circle_outline,
                                                color: shopDetailModel.shop.isOpen
                                                    ? Theme.of(context).primaryColor
                                                    : Colors.grey,
                                                size:
                                                22,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                              6,
                                            ),
                                            Text(
                                              "${checkIfExistInCart(commodity.id, shopCartListModel).quantity}",
                                              style: TextStyle(
                                                  fontSize:
                                                  18),
                                            ),
                                            SizedBox(
                                              width:
                                              6,
                                            ),
                                            GestureDetector(
                                              onTap: shopDetailModel.shop.isOpen
                                                  ? () {
                                                shopCartListModel.updateCartInfoNum(shopCommodityInfoListModel.list[index].id, 1);
                                                shopCartListModel.notifyListeners();
                                                shopCartListModel.refresh();
                                              }
                                                  : null,
                                              child: Icon(
                                                  Icons
                                                      .add_circle,
                                                  color: shopDetailModel.shop.isOpen
                                                      ? Theme.of(context).primaryColor
                                                      : Colors.grey,
                                                  size: 22),
                                            ),
//                                                                SizedBox(width: 12,),
                                          ],
                                        )
                                            : Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          children: <
                                              Widget>[
//                                                                SizedBox(width: 12,),
                                            GestureDetector(
                                              onTap: shopDetailModel.shop.isOpen
                                                  ? () {
                                                ErrorUtils.auth_401_error(context,(){
                                                  shopCartListModel.updateCartInfoNum(shopCommodityInfoListModel.list[index].id, 1);
                                                  shopCartListModel.notifyListeners();
                                                  shopCartListModel.refresh();
                                                });

                                              }
                                                  : null,
                                              child: Icon(
                                                  Icons
                                                      .add_circle,
                                                  color: shopDetailModel.shop.isOpen
                                                      ? Theme.of(context).primaryColor
                                                      : Colors.grey,
                                                  size: 22),
                                            ),
//                                                                SizedBox(width: 12,),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            index ==
                shopCommodityInfoListModel
                    .list.length -
                    1
                ? SizedBox(
              height: 60,
            )
                : Container()
          ],
        ),
      ),
    );
  }
  getTypeCard(Types types,int index){
    bool point = false;
    if (shopCommodityTypeListModel.selectedTypes == null) {
      point = false;
    } else {
      if (shopCommodityTypeListModel.selectedTypes.id ==
          types.id) {
        point = true;
      } else {
        point = false;
      }
    }
    return Column(
      children: <Widget>[
        Container(
          decoration: point
              ? BoxDecoration(
            color: Colors.white,
          )
              : BoxDecoration(),
          alignment: Alignment.centerLeft,
          height: 60,
          padding:
          EdgeInsets.only(right: 10, left: 10),
          child: Text(
            types.name,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
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
  @override
  void dispose() {
    _listScrollController1?.dispose();
    _listScrollController2?.dispose();
    _listScrollController1 = _listScrollController2 = null;
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
                                          await model.updateCartInfoNum(model.list[index].commodity.id, -1);
                                          if(model.list.length==0){
                                            Navigator.pop(context);
                                          }
                                          state(() {

                                          });
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
                                          if (model.list.length == 0) {
                                            Navigator.pop(context);
                                          }
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
                          controller: _listScrollController1,
                          itemCount: model.list.length,
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
//              return ProviderWidget<ShopCartSelfModel>(
//                onModelReady: (model)=>model.initData(),
//                model: ShopCartSelfModel(shopId),
//                builder: (BuildContext context, ShopCartSelfModel model, Widget child) {
//                  if (model.error
//                  ) {
//                    return ViewStateErrorWidget(
//                        error: model.viewStateError,
//                        onPressed: model.initData);
//                  }
//
//                },
//              );
            },
          );
        });
  }


}
