import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_customer_client/service/order_repository.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_list_page.dart';
import 'package:yunzhixiao_customer_client/view_model/order_model.dart';


class OrderHomePage extends StatefulWidget {
  @override
  _OrderHomePageState createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage>
//    with AutomaticKeepAliveClientMixin
    {
//  @override
//  bool get wantKeepAlive => true;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  Map<String, int> orderNums = {
    "全部订单": 0,
    "待付款": 0,
    "待取餐": 0,
    "售后": 0
  };

  @override
  void initState() {
    super.initState();
    refreshOrderNum();
  }

  refreshOrderNum() {
    OrderRepository.fetchOrderNum().then((result){
      setState(() {
        orderNums["全部订单"];
        orderNums["待付款"] = result.waitPay;
        orderNums["待取餐"] = result.waitReceive;
        orderNums["售后"] = result.waitCancel;
      });
    });
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }
  var tabs = [
    "全部订单",'待付款', "待取餐", "售后"
  ];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ValueListenableProvider<int>.value(
              value: valueNotifier,
              child: DefaultTabController(
                length: tabs.length,
                initialIndex: valueNotifier.value,
                child: Builder(
                  builder: (context) {
                    if (tabController == null) {
                      tabController = DefaultTabController.of(context);
                      tabController.addListener(() {
                        valueNotifier.value = tabController.index;
                      });
                    }
                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          )
                        ],
                        centerTitle: false,
                        title: const Text('我的订单',style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.bold),),
                        bottom: new TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 16),
                          labelColor: Colors.black,
                          indicatorColor:Theme.of(context).primaryColor,
                          isScrollable: true,
                          controller: tabController,
                          indicatorWeight: 3,
                          indicatorPadding:EdgeInsets.only(bottom: 2,left: 16,right: 16),
                          tabs: tabs.map((choice) {
                            return Badge(
                              position: BadgePosition.topRight(top: 8, right: -20),
                              showBadge: orderNums[choice] != 0,
                              badgeContent: Text(orderNums[choice].toString(), style: TextStyle(
                                color: Colors.white
                              ),),
                              child: new Tab(
                                text: choice,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          OrderListPage<AllOrderListModel>(),
                          OrderListPage<WaitingPayListModel>(),
                          OrderListPage<WaitingReciveListModel>(),
                          OrderListPage<AfterSellListModel>(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
    );
  }
}











