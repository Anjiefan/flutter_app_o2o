import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_list_model.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/dropdown.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_card.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_filter_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_type_cat_model.dart';

class HomeShopListPage extends StatefulWidget {
  final ShopListParam shopListParam;

  const HomeShopListPage({Key key, this.shopListParam}) : super(key: key);

  @override
  _HomeShopListPageState createState() => _HomeShopListPageState();
}

class _HomeShopListPageState extends State<HomeShopListPage>
    with AutomaticKeepAliveClientMixin {
  ShopListModel globalModel;

  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> shopTypeCatValueNotifier;
  TabController shopTypeCatTabController;

  TabController filterTabController;
  List filter = ['推荐', '销量', '好评'];
  int cartBadgeNum = 0;
  @override
  void initState() {
    shopTypeCatValueNotifier = ValueNotifier(0);
    refreshCartBadgeNum();

    super.initState();
  }

  refreshCartBadgeNum() {
    ShopRepository.fetchCartNum().then((result) {
      setState(() {
        cartBadgeNum = result.cartNum;
      });
    });
  }

  @override
  void dispose() {
    shopTypeCatValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButton: Badge(
          showBadge: cartBadgeNum != 0,
          badgeContent: Text(
            cartBadgeNum.toString(),
            style: TextStyle(color: Colors.white),
          ),
          position: BadgePosition.topRight(top: -4, right: -4),
          child: FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.homeShopCart)
                  .then((result) {
                refreshCartBadgeNum();
              });
            },
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.grey,
            hoverColor: Colors.grey,
            splashColor: Colors.grey,
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteName.shopSearch, arguments: globalModel);
              },
              icon: Icon(Icons.search),
            )
          ],
          title: Text(widget.shopListParam.title),
        ),
        body: ProviderWidget2<ShopTypeCatModel, ShopListModel>(
            model1: ShopTypeCatModel(widget.shopListParam.fatherId),
            model2: ShopListModel(),
            onModelReady: (model1, model2) {
              model1.initData();
              model2.initData();
              globalModel = model2;
            },
            builder: (context, shopTypeCatModel, shopListModel, child) {
              var theme = Theme.of(context);
              if (shopTypeCatModel.busy) {
                return ViewStateBusyWidget();
              }
              if (shopTypeCatModel.error) {
                return ViewStateErrorWidget(
                    error: shopTypeCatModel.viewStateError,
                    onPressed: shopTypeCatModel.initData);
              }
              var primaryColor = Theme.of(context).primaryColor;
              return ValueListenableProvider<int>.value(
                value: shopTypeCatValueNotifier,
                child: DefaultTabController(
                  length: shopTypeCatModel.list.length + 1,
                  initialIndex: shopTypeCatValueNotifier.value,
                  child: Builder(
                    builder: (context) {
                      if (shopTypeCatTabController == null) {
                        shopTypeCatTabController =
                            DefaultTabController.of(context);
                        shopTypeCatTabController.addListener(() {
                          shopTypeCatValueNotifier.value =
                              shopTypeCatTabController.index;
                          if (shopTypeCatValueNotifier.value == 0) {
                            shopListModel.onRefreshType(null);
                          } else {
                            int typeId = shopTypeCatModel
                                .list[shopTypeCatValueNotifier.value - 1].id;
                            shopListModel.onRefreshType(typeId);
                          }
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          shopTypeCatTabController
                              .animateTo(widget.shopListParam.where);
                          print("where=${widget.shopListParam.where}");
                        });
                      }
                      return SmartRefresher(
                        controller: shopListModel.refreshController,
                        header: WaterDropMaterialHeader(),
                        onRefresh: shopListModel.refresh,
                        enablePullUp: true,
                        onLoading: shopListModel.loadMore,
                        child: Scaffold(
                          body: CustomScrollView(
                            slivers: <Widget>[
                              SliverAppBar(
                                pinned: true,
                                automaticallyImplyLeading: false,
                                title: PreferredSize(
                                  preferredSize: Size.fromHeight(30),
                                  child: Stack(
                                    children: [
                                      CategoryDropdownWidget(
                                          Provider.of<ShopTypeCatModel>(
                                              context)),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 25),
                                        color: primaryColor.withOpacity(1),
                                        child: TabBar(
                                            isScrollable: true,
                                            tabs: List.generate(
                                                shopTypeCatModel.list.length +
                                                    1, (index) {
                                              if (index == 0) {
                                                return Tab(
                                                  text: '全部',
                                                );
                                              }
                                              return Tab(
                                                text: shopTypeCatModel
                                                    .list[index - 1].name,
                                              );
                                            })),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: SliverAppBarDelegate(
                                    ShopFilter(
                                      model: shopListModel,
                                    ),
                                    105.0),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return ShopCard(
                                        shop: shopListModel.list[index]);
                                  },
                                  childCount: shopListModel.list.length,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }));
  }
}

class CategoryDropdownWidget extends StatelessWidget {
  final ViewStateListModel model;

  CategoryDropdownWidget(this.model);

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<int>(context);
    return Align(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          elevation: 0,
          value: currentIndex,
          style: Theme.of(context).primaryTextTheme.subhead,
          items: List.generate(model.list.length + 1, (index) {
            var theme = Theme.of(context);
            var subhead = theme.primaryTextTheme.subhead;
            return DropdownMenuItem(
              value: index,
              child: index != 0
                  ? Text(model.list[index - 1].name,
                      style: currentIndex == index
                          ? subhead.apply(
                              fontSizeFactor: 1.15,
                              color: theme.brightness == Brightness.light
                                  ? Colors.white
                                  : theme.accentColor)
                          : subhead.apply(color: subhead.color.withAlpha(200)))
                  : Text(
                      '全部',
                      style: currentIndex == index
                          ? subhead.apply(
                              fontSizeFactor: 1.15,
                              color: theme.brightness == Brightness.light
                                  ? Colors.white
                                  : theme.accentColor)
                          : subhead.apply(color: subhead.color.withAlpha(200)),
                    ),
            );
          }),
          onChanged: (value) {
            DefaultTabController.of(context).animateTo(value);
          },
          isExpanded: true,
          icon: Container(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        )),
      ),
      alignment: Alignment(1.1, -1),
    );
  }
}

class ShopListParam {
  final String title;
  final int fatherId;
  final int where;

  ShopListParam(this.title, this.fatherId, this.where);
}
