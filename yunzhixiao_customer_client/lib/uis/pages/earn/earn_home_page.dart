import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/banner_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_card.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_father_card.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_share_card.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_share_model.dart';
import 'package:yunzhixiao_customer_client/view_model/system/system_static_model.dart';

class EarnHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EarnHomePageState();
}

class EarnHomePageState extends State<EarnHomePage>
//    with AutomaticKeepAliveClientMixin
{
  int shopLockedNum = 0;
  String monthBenefit = "0.00";
  String allBenefit = "0.00";
  Shop shareShop;
  @override
  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    ShopRepository.fetchShareShopList(1).then((value) {
      setState(() {
        shareShop = value[0];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool loading = false;
  buildDiscountChips() {
    var widgetList = <Widget>[];
    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CardTag(
            name: "首次消费减5",
          ),
        ),
        CardTag(
          name: "锁客用户7折",
        ),
      ],
    ));
    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CardTag(
            name: "满10减3",
          ),
        ),
        CardTag(
          name: "分享红包5元",
        ),
      ],
    ));
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Consumer2<SystemStaticModel, ShopShareListModel>(
        builder: (_, systemModel, model, __) {
      if (loading == false) {
        model.refresh();
        loading = true;
      }
      if (systemModel.busy || model.busy) {
        return ViewStateBusyWidget();
      } else if (systemModel.error) {
        return ViewStateErrorWidget(
            error: systemModel.viewStateError, onPressed: systemModel.initData);
      }
//      else if (model.error && !model.unAuthorized) {
//        return ViewStateErrorWidget(
//            error: model.viewStateError, onPressed: model.initData);
//      } else if (model.unAuthorized) {
//        return ViewStateUnAuthWidget(onPressed: ()  {
//          print("onPressed");
//          Navigator.of(context).pushNamed(RouteName.login).then((result) {
//            print("success=$result");
//             登录成功,获取数据,刷新页面
//            if (result) {
//              model.initData();
//            }
//          });
//        });
//      }

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
              title: Text(
                "我的锁客商家",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              leading: null,
              centerTitle: false,
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ShopFatherCard(
                    devide: false,
                    shop:
                        model.lockedShopList.length > 0 ? model.list[0] : null,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: PhysicalModel(
                  color: Colors.white, //设置背景底色透明
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias, //注意这个属性
                  child: BannerWidget(
                    list: systemModel
                        .systemStaticInfo.earnMoneyPageData.swiperPage,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  "分享优店赚取红包",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ShopShareCard(
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

class CardTag extends StatelessWidget {
  final String name;

  const CardTag({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(200),
            border: Border.all(color: Theme.of(context).primaryColor)),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Text(this.name,
            style:
                TextStyle(fontSize: 12, color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
