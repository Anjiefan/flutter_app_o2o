import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/service/order_repository.dart';
import 'package:yunzhixiao_business_client/uis/helpers/refresh_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_cancel_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_new_order_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/order_process_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_reminder_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_take_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/abandon/order_process_waiting_page.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_type_model.dart';
import 'package:yunzhixiao_business_client/view_model/push_model.dart';

class OrderProcessHomePage extends StatefulWidget {
  @override
  _OrderProcessHomePageState createState() => _OrderProcessHomePageState();
}

class _OrderProcessHomePageState extends State<OrderProcessHomePage>
//    with AutomaticKeepAliveClientMixin
{
  @override
//  bool get wantKeepAlive => true;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  var category = ['新订单', '等待备餐', '等待取餐', '催单', '取消单'];
  @override
  Widget build(BuildContext context) {
    PushModel pushModel = Provider.of<PushModel>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ProviderWidget<OrderHomeInfoModel>(
          model: OrderHomeInfoModel(),
          onModelReady: (model) {
            model.refresh();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              pushModel.onOrderHomeInfoModelReady(model);
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              pushModel.refreshSystemMessageNum();
            });
          },
          builder: (context, model2, child) {
            return ValueListenableProvider<int>.value(
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
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        model2.onSetTabController(tabController);
                      });
                    }
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        actions: <Widget>[
                          Badge(
                            showBadge: false,
                            child: IconButton(
                              icon: Icon(Icons.help),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      title: new Text("订单卡片颜色说明"),
                                      content:Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Colors.red
                                                ),
                                              ),
                                              Gaps.hGap8,
                                              Text("立即取餐")
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange
                                                ),
                                              ),
                                              Gaps.hGap8,
                                              Text("半小时后取餐")
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                ),
                                              ),
                                              Gaps.hGap8,
                                              Text("1小时后取餐")
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Colors.green
                                                ),
                                              ),
                                              Gaps.hGap8,
                                              Text("2小时后取餐")
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("我知道了"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            
                                          },
                                        ),
                                        
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Badge(
                              showBadge: pushModel.systemMessageNumDetail !=
                                      null &&
                                  pushModel.systemMessageNumDetail.unreadNum !=
                                      0,
                              position:
                                  BadgePosition.topRight(top: 4, right: 4),
                              badgeContent: Text(
                                  pushModel.systemMessageNumDetail != null
                                      ? pushModel
                                          .systemMessageNumDetail.unreadNum
                                          .toString()
                                      : "".toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              child: IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteName.systemMessage);
                                },
                              )),
                          Badge(
                            child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteName.orderProcessSearch);
                              },
                            ),
                          ),
                        ],
                        centerTitle: false,
                        title: const Text('订单处理'),
                        bottom: new TabBar(
                          isScrollable: true,
                          indicatorPadding:
                              EdgeInsets.only(bottom: 5, left: 3, right: 3),
                          tabs: category.map((choice) {
                            return Badge(
                              position: BadgePosition.topRight(top: 0),
                              showBadge: model2.orderNums[choice] != 0,
                              badgeContent: Text(
                                model2.orderNums[choice].toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              child: new Tab(
                                text: choice,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      body: TabBarView(children: [
                        OrderProcessPage<NewOperateOrder>(),
                        OrderProcessPage<WaitOperateOrder>(),
                        OrderProcessPage<TakeOperateOrder>(),
                        OrderProcessPage<UrgeOperateOrder>(),
                        OrderProcessPage<CancelOperateOrder>(),
                      ]),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
