import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_search/order_search_page.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_type_model.dart';


class OrderSearchHomePage extends StatefulWidget {
  @override
  _OrderSearchHomePageState createState() => _OrderSearchHomePageState();
}

class _OrderSearchHomePageState extends State<OrderSearchHomePage>
    {
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }
  var category=['进行中','已完成','出餐慢','取消单'];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ValueListenableProvider<int>.value(
        value: valueNotifier,
        child: DefaultTabController(
          length: category.length,
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
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.orderSearchAction);
                      },
                    )
                  ],
                  centerTitle: false,
                  title: const Text('订单查询'),
                  bottom: new TabBar(

                    isScrollable: true,
                    indicatorPadding:EdgeInsets.only(bottom: 5),
                    tabs: category.map((choice) {
                      return new Tab(
                        text: choice,
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  children: [
                    OrderSearchPage<DoingOrderModel>(),
                    OrderSearchPage<ArchiveOrderModel>(),
                    OrderSearchPage<LazyOrderModel>(),
                    OrderSearchPage<CancelOrderModel>(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}










