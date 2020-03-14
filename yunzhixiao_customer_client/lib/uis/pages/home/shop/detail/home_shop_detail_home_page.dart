import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yunzhixiao_customer_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_controller.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_coordinator.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_comment_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_commodity_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_info_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/utils/chat_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_commodity_detail_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class HomeShopDetailPage extends StatefulWidget {
  final int shopId;

  HomeShopDetailPage({Key key, this.shopId}) : super(key: key);

  @override
  _HomeShopDetailPageState createState() => _HomeShopDetailPageState();
}

class _HomeShopDetailPageState extends State<HomeShopDetailPage>
    with SingleTickerProviderStateMixin
    ,AutomaticKeepAliveClientMixin
{
  @override
  bool get wantKeepAlive => true;
  ShopScrollCoordinator _shopCoordinator;
  ShopScrollController _pageScrollController;

  TabController _tabController;

  final double _tabBarHeight = 50;
  double _sliverAppBarMaxHeight;
  var appBarHeightFromTop = 0.0;

  @override
  void initState() {
    super.initState();
    _shopCoordinator = ShopScrollCoordinator();
    _tabController = TabController(vsync: this, length: 3);
  }

  buildPromotionWidgets(Shop shop) {
    var promotions = shop.promotionList;
    List<Widget> returnList = [];
    int i = 0;
    promotions.forEach((value) {
      if (i == 3) {
        return;
      }
      returnList.add(PromotionLable(
        text: value,
      ));
      i++;
    });
    if (returnList.length <= 3) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: returnList,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mediaQuery ??= MediaQuery.of(context);
    screenHeight ??= mediaQuery.size.height;
    statusBarHeight ??= mediaQuery.padding.top;

    _sliverAppBarMaxHeight ??= screenHeight;
    _pageScrollController ??=
        _shopCoordinator.pageScrollController(screenHeight * 0.72);
    _shopCoordinator.pinnedHeaderSliverHeightBuilder ??= () {
      return statusBarHeight + kToolbarHeight + _tabBarHeight;
    };
    return ProviderWidget4<ShopCommodityTypeListModel, ShopCommodityInfoListModel,ShopCartSelfModel,ShopDetailModel>(

      model1: ShopCommodityTypeListModel(widget.shopId),
      model2: ShopCommodityInfoListModel(widget.shopId),
      model3: ShopCartSelfModel(widget.shopId),
      model4: ShopDetailModel(widget.shopId),
                  onModelReady: (model1,model2,model3,model) {
                      model.refresh();
                      model1.initData();
                      model2.initData();
                      model3.initData();
                  },
                  builder: (BuildContext context,model1,model2,model3
                      , model, Widget child) {
                    if (model1.busy ||
                        model2.busy ||
                        model3.busy ||
                        model.busy
                    ) {
                      return ViewStateBusyWidget();
                    }
                    if (model1.error
                    ) {
                      return ViewStateErrorWidget(
                          error: model1.viewStateError,
                          onPressed: model1.initData
                      );
                    }
                    if (model2.error
                    ) {
                      return ViewStateErrorWidget(
                          error: model2.viewStateError,
                          onPressed: model2.initData);
                    }
                    if (model3.error
                    ) {
                      return ViewStateErrorWidget(
                          error: model3.viewStateError,
                          onPressed: model3.initData);
                    }
                    if (model.error
                    ) {
                      return ViewStateErrorWidget(
                          error: model.viewStateError,
                          onPressed: model.refresh);
                    }
                    return Scaffold(
                      body: Listener(
                        onPointerUp: _shopCoordinator.onPointerUp,
                        child: CustomScrollView(
                          controller: _pageScrollController,
                          physics: ClampingScrollPhysics(),
                          slivers: <Widget>[
                            SliverAppBar(
                                pinned: true,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                expandedHeight: screenHeight,
                                elevation: 0.0,
                                actions: <Widget>[
                                  IconButton(
                                    onPressed: (){
                                      ChatUtils.shareGrid(context);
                                    },
                                    icon: Icon(Icons.share),
                                  )
                                ],
                                bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(10),
                                  child: Container(
                                    color: Colors.white,
                                    child: TabBar(
                                      labelColor: Colors.black,
                                      indicatorWeight: 3.0,
                                      indicatorPadding:
                                      EdgeInsets.only(
                                          bottom: 0,
                                          left: 40,
                                          right: 40),
                                      indicatorColor:
                                      Theme.of(context)
                                          .primaryColor,
                                      unselectedLabelColor: Colors.black54,
                                      controller: _tabController,
                                      tabs: <Widget>[
                                        Tab(text: "商品"),
                                        Tab(text: "评价"),
                                        Tab(text: "商家"),
                                      ],
                                    ),
                                  ), // Add this code
                                ),
                                flexibleSpace:LayoutBuilder(builder:
                                    (BuildContext context, BoxConstraints constraints) {
                                  appBarHeightFromTop = constraints.biggest.height;
                                  return Container(
                                    color: Colors.white,
                                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Wrap(
                                            children: [
                                              Column(
                                                children: <Widget>[
                                                  Container(

//                                    color: Theme.of(context).primaryColor,
                                                    height: 145,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        WrapperImage(
                                                            width: double.infinity,
                                                            height: 100,
                                                            url:
                                                            "http://lc-aveFaAUx.cn-n1.lcfile.com/bf167f920ac9f9a2c433/topbg.png"),
                                                        Positioned(
                                                          top: 55,
                                                          left: MediaQuery.of(context).size.width /
                                                              2 -
                                                              45,
                                                          child: AnimatedOpacity(
                                                            opacity: appBarHeightFromTop <= 195
                                                                ? 0.0
                                                                : 1.0,
                                                            duration: Duration(milliseconds: 500),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(12)),
                                                              child: WrapperImage(
                                                                  width: 86,
                                                                  height: 86,
                                                                  url: model.shop.logo),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text("${model.shop.name}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20)),
                                                  SizedBox(height: 2,),
                                                  Text(
                                                    "评价${model.shop.level}  月售${model.shop.sellNumMounth}",
                                                    style:
                                                    TextStyle(color: Colors.grey, fontSize: 12),
                                                  ),
                                                  Stack(
                                                    children: <Widget>[
                                                      //简略信息
                                                      IgnorePointer(
                                                        ignoring: appBarHeightFromTop >
                                                            screenHeight * 0.35,
                                                        child: AnimatedOpacity(
                                                          opacity: appBarHeightFromTop >
                                                              screenHeight * 0.35
                                                              ? 0.0
                                                              : 1.0,
                                                          duration: Duration(milliseconds: 500),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 20, vertical: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Row(
                                                                  children: <Widget>[]..addAll(
                                                                      buildPromotionWidgets(
                                                                          model.shop)),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _pageScrollController.animateTo(
                                                                      0,
                                                                      duration: Duration(
                                                                          milliseconds: 500),
                                                                      curve: Curves.linear,
                                                                    );
                                                                  },
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Text(
                                                                        "等${model.shop.promotionDict.length}个优惠",
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 10),
                                                                      ),
                                                                      Transform.rotate(
                                                                        angle: 90 * pi / 180,
                                                                        child: Icon(
                                                                          Icons.arrow_forward_ios,
                                                                          color: Colors.grey,
                                                                          size: 10,
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
                                                      //完整信息
                                                      IgnorePointer(
                                                        ignoring: appBarHeightFromTop <=
                                                            screenHeight * 0.35,
                                                        child: AnimatedOpacity(
                                                          opacity: appBarHeightFromTop <=
                                                              screenHeight * 0.35
                                                              ? 0.0
                                                              : 1.0,
                                                          duration: Duration(milliseconds: 500),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 20, vertical: 10),
                                                            child: Column(
                                                              children: <Widget>[
                                                                //优惠标题
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      "优惠",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.bold),
                                                                    ),
                                                                    Transform.rotate(
                                                                      angle: 270 * pi / 180,
                                                                      child: IconButton(
                                                                        icon: Icon(
                                                                          Icons.arrow_forward_ios,
                                                                          color: Colors.grey,
                                                                          size: 14,
                                                                        ),
                                                                        onPressed: () {
                                                                          _pageScrollController
                                                                              .animateTo(
                                                                            screenHeight * 0.72,
                                                                            duration: Duration(
                                                                                milliseconds: 500),
                                                                            curve: Curves.linear,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //优惠内容
                                                                Column(
                                                                  children: <Widget>[
                                                                  ]..addAll(buildPromotionDetails(model)),
                                                                ),
                                                                //公告标题
                                                                Gaps.vGap8,
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      "公告",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //公告内容
                                                                Gaps.vGap8,
                                                                Row(
                                                                  children: <Widget>[
                                                                    Text(
                                                                      "${model.shop.show}",
                                                                      style: TextStyle(
                                                                          color: Colors.grey, fontSize: 12),
                                                                    ),
                                                                  ],
                                                                ),
                                                                screenHeight - screenHeight * 0.6 - _pageScrollController.offset >=0?SizedBox(height: screenHeight - screenHeight * 0.6 - _pageScrollController.offset,):Container(),
                                                                //折叠按钮
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Transform.rotate(
                                                                      angle: 270 * pi / 180,
                                                                      child: IconButton(
                                                                        onPressed: (){
                                                                          _pageScrollController
                                                                              .animateTo(
                                                                            screenHeight * 0.72,
                                                                            duration: Duration(
                                                                                milliseconds: 500),
                                                                            curve: Curves.linear,
                                                                          );
                                                                        },
                                                                        icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })

                            ),
                            SliverFillRemaining(
                              child: Column(
                                children: <Widget>[
                                  Divider(
                                    height: 5,
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: <Widget>[
                                        HomeShopDetailCommodityPage(
                                            shopCoordinator: _shopCoordinator, shopId: widget.shopId),
                                        HomeShopDetailCommentPage(shopCoordinator: _shopCoordinator, shopId: widget.shopId),
                                        HomeShopDetailInfoPage(shopId: widget.shopId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );

  }

  @override
  void dispose() {
    _tabController?.dispose();
    _pageScrollController?.dispose();
    super.dispose();
  }

  buildPromotionDetails(ShopDetailModel model) {
    return List<Widget>.generate(model.shop.promotionDict.length, (index){
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              PromotionLable(
                text: model.shop.promotionDict[index].key,
              ),
              Text(model.shop.promotionDict[index].value,style: TextStyle(color: Colors.grey, fontSize: 12),)
            ],
          ),
          Gaps.vGap4,
        ],
      );
    });
  }
}
