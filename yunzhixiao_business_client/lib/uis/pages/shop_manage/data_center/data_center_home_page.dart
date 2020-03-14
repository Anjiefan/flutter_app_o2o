import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/data_center/business_data_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/data_center/service_data_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/data_center/shop_data_page.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';


class DataHomePage extends StatefulWidget {
  @override
  _DataHomePageState createState() => _DataHomePageState();
}

class _DataHomePageState extends State<DataHomePage>
    with AutomaticKeepAliveClientMixin
    {
  @override
  bool get wantKeepAlive => true;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  List<String> tabs = ['营业数据', '商品数据', '服务数据'];
  @override
  void dispose() {

    valueNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ProviderWidget<OrderListModel>(
          model: OrderListModel(),
          builder: (context, model, child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
            }
            return ValueListenableProvider<int>.value(
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
                        centerTitle: false,
                        title: const Text('数据分析'),
                        bottom: new TabBar(
                          isScrollable: true,
                          indicatorPadding:EdgeInsets.only(bottom: 5),
                          tabs: tabs.map((choice) {
                            return new Tab(
                              text: choice,
                            );
                          }).toList(),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          BusinessDataPage(),
                          ShopDataPage(),
                          ServiceDataPage(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}






