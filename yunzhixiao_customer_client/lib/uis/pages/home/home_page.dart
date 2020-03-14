import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';
import 'package:yunzhixiao_customer_client/uis/icons/my_flutter_app_icons.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_list_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/banner_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_card.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_filter_widget.dart';
import 'package:yunzhixiao_customer_client/utils/auth_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/system/system_static_model.dart';

import '../../../providers/view_state_widget.dart';
import '../../widgets/image_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Consumer2<SystemStaticModel, ShopListModel>(
        builder: (_, systemModel, model, __) {
      if (loading == false) {
        model.refresh();
        systemModel.refreshOrderNum();
        loading = true;
      }
      if (systemModel.busy || model.busy) {
        return ViewStateBusyWidget();
      } else if (systemModel.error) {
        return ViewStateErrorWidget(
            error: systemModel.viewStateError, onPressed: systemModel.initData);
      } else if (model.error) {
        return ViewStateErrorWidget(
            error: model.viewStateError, onPressed: model.initData);
      }

      return SmartRefresher(
        controller: model.refreshController,
        onRefresh: model.refresh,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: model.loadMore,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actions: <Widget>[
                Badge(
                  showBadge: false,
                  position: BadgePosition.topRight(top: 8, right: 3),
                  child: IconButton(
                    icon: Icon(
                      MyFlutterApp.qrcode,
                      color: Colors.black54,
                      size: 17,
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(context, RouteName.qrcodeView)
                          .then((cameraScanResult) async {
                        try {
                          Iterable<Match> matches
                          =RegExp(r".+shop=(\d+)").allMatches(cameraScanResult);
                          int result;
                          for(Match m in matches){
                            result=int.parse(m.group(1));
                          }
                          Shop shop = await ShopRepository.fetchShopDetail(
                              result);
                          Navigator.pushNamed(context, RouteName.homeShopDetail,
                              arguments: shop.id);
                        } catch (e) {
                          if (cameraScanResult != null) showToast("二维码异常，请重试。");
                        }
                        print(cameraScanResult);
                      });
                    },
                  ),
                ),
                Badge(
                  showBadge: systemModel.systemMessageNumDetail != null &&
                      systemModel.systemMessageNumDetail.unreadNum != 0,
                  position: BadgePosition.topRight(top: 8, right: 3),
                  badgeContent: Text(
                      systemModel.systemMessageNumDetail != null
                          ? systemModel.systemMessageNumDetail.unreadNum
                              .toString()
                          : "".toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                  child: IconButton(
                    icon: Icon(
                      MyFlutterApp.message,
                      color: Colors.black54,
                      size: 18,
                    ),
                    onPressed: () {
                      ErrorUtils.auth_401_error(context, () {
                        Navigator.of(context).pushNamed(RouteName.userMessage);
                      });
                    },
                  ),
                ),
              ],
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: theme.primaryColor,
                  ),
                  Text(
                    '东北石油大学',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white, image: null),
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        width: width,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[100],
                            ),
                            width: width,
                            height: 35,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: new Icon(
                                    Icons.search,
                                    color: Colors.grey[300],
                                    size: 18,
                                  ),
//                                            padding: EdgeInsets.only(left: 10,right: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '请输入商家或商品名称',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteName.shopSearch);
                          },
                        ),
                      ),
                    ),
                  ),
                  55.0),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
              sliver: SliverGrid.count(
                childAspectRatio: 0.9,
                crossAxisCount: 4,
                children: systemModel.systemStaticInfo.homePageData.cateTypes
                    .map((product) {
                  return GestureDetector(
                      onTap: () {
                        //? 取餐
                        if (product.name == "取餐") {
                          Navigator.pushNamed(context, RouteName.orderPickUp);
                        } else {
                          Navigator.pushNamed(context, RouteName.homeShopList,
                              arguments:
                                  ShopListParam(product.name, product.id, 0));
                        }


                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Badge(
                              position: BadgePosition.topRight(top: -10,),
                              showBadge: product.name == "取餐" &&
                                  systemModel.orderNum != null
//                                  && systemModel.orderNum.waitReceive != 0
                              ,
                              badgeContent: Text(
                                  systemModel.orderNum != null
                                      ? systemModel.orderNum.waitReceive.toString()
                                      : "".toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              child:  Container(
                                width: 60,
                              ),
                            ),
                            Container(
                              child: ClipOval(
                                  child: WrapperImage(
                                    url: product.image,
                                    width: 60,
                                    height: 60,
                                  )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              child: Text(
                                product.name,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                          ],
                        ),
                      )
                      );
                }).toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: PhysicalModel(
                  color: Colors.white, //设置背景底色透明
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias, //注意这个属性
                  child: BannerWidget(
                    list: systemModel.systemStaticInfo.homePageData.swiperPage,
                    height: 70,
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(ShopFilter(model: model), 105.0),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ShopCard(
                    shop: model.list[index],
                  );
                },
                childCount: model.list.length,
              ),
            )
          ],
        ),
      );
    });
  }
}

class PromotionLable extends StatelessWidget {
  final String text;
  final bool isGrey;
  PromotionLable({this.text, this.isGrey = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6, top: 0, bottom: 1.5),
      decoration: BoxDecoration(
        color: isGrey ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
            color: !isGrey ? Colors.red[100] : Colors.grey, width: 0.8),
      ),
      child: Text(
        text.trim(),
        style:
            TextStyle(color: !isGrey ? Colors.red : Colors.white, fontSize: 10),
      ),
      margin: EdgeInsets.only(right: 5),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  FilterButton({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.grey[200]),
      child: Text(text),
    );
  }
}
