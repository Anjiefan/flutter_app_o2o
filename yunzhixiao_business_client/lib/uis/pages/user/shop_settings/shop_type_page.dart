import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_business_client/models/shop_type.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/refresh_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_cancel_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_new_order_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_reminder_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_type_choose_page.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/order/order_skeleton.dart';
import 'package:yunzhixiao_business_client/uis/widgets/skeleton_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/shop_settings/shop_type_model.dart';


class ShopTypePage extends StatefulWidget {
  @override
  _ShopTypePageState createState() => _ShopTypePageState();
}

class _ShopTypePageState extends State<ShopTypePage>
//    with AutomaticKeepAliveClientMixin
    {
  //  bool get wantKeepAlive => true;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('品类选择'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: StatusBarUtils.systemUiOverlayStyle(context),
        child: ProviderWidget<ShopTypeListModel>(
            model: ShopTypeListModel(),
            onModelReady: (model){
              model.initData();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              } else if (model.error && model.list.isEmpty) {
                return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
              }
              var tabs = model.list;
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
                          automaticallyImplyLeading:false,
                          title: new TabBar(
                            isScrollable: true,
                            indicatorPadding:EdgeInsets.only(bottom: 5),
                            tabs: tabs.map((choice) {
                              return new Tab(
                                text: choice["name"],
                              );
                            }).toList(),
                          ),
                        ),
                        body: TabBarView(
                          children: buildChoosePages(tabs),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ProviderWidget<ShopTypeListModel>(
          model: ShopTypeListModel(),
          onModelReady: (model){
            model.initData();
          },
          builder: (context, model, child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
            }
            var tabs = model.list;
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
                        title: const Text('品类选择'),
                        bottom: new TabBar(
                          isScrollable: true,
                          indicatorPadding:EdgeInsets.only(bottom: 5),
                          tabs: tabs.map((choice) {
                            return new Tab(
                              text: choice["name"],
                            );
                          }).toList(),
                        ),
                      ),
                      body: TabBarView(
                        children: buildChoosePages(tabs),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }

  buildChoosePages(List tabs) {
    return List<ShopTypeChoosePage>.generate(tabs.length, (index){
      return ShopTypeChoosePage(shopType2List: tabs[index]["shoptype_self_relate"],);
    });
  }
}






