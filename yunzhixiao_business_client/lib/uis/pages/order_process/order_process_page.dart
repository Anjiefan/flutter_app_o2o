import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:random_color/random_color.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/order_dialog_utils.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

import 'package:yunzhixiao_business_client/view_model/push_model.dart';
import 'package:yunzhixiao_business_client/view_model/settings_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class OrderProcessPage<T extends OrderListModel> extends StatefulWidget {
  OrderProcessPage({key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderProcessNewOrderPageState<T>();
}

class _OrderProcessNewOrderPageState<T extends OrderListModel>
    extends State<OrderProcessPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;
  RandomColor _randomColor = RandomColor();
  PermissionStatus _permissionStatus;
  List<Color> cardColors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green
  ];
  @override
  void initState() {
    super.initState();
    NotificationPermissions.getNotificationPermissionStatus().then((result) {
      setState(() {
        _permissionStatus = result;
      });
    });
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    var pushModel = Provider.of<PushModel>(context);
    var orderHomeInfoModel = Provider.of<OrderHomeInfoModel>(context);
    return Consumer<T>(builder: (context, model, child) {
      if (loading == false) {
        model.refresh();
        if (T == NewOperateOrder) {
          print("!!!!!NewOperateOrder");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            pushModel.onNewOrderListModelReady(model);
            orderHomeInfoModel.currentOrderListModel = model;
          });
        } else if (T == WaitOperateOrder) {
          print("!!!!!WaitOperateOrder");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            pushModel.onPrepareOrderListModelReady(model);
            orderHomeInfoModel.currentOrderListModel = model;
          });
        }
        loading = true;
      }
      if (model.busy) {
        return ViewStateBusyWidget();
      } else if (model.error && model.list.isEmpty) {
        return ViewStateErrorWidget(
            error: model.viewStateError, onPressed: model.initData);
      } else if (model.empty && T == NewOperateOrder) {
        var settingsModel = Provider.of<SettingsModel>(context);
        var userModel = Provider.of<UserModel>(context);
        return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropMaterialHeader(),
          onRefresh: model.refresh,
          onLoading: null,
          enablePullUp: false,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: theme.primaryColor,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: SizedBox(),
                          title: Text(
                            userModel.user.shop.isOpen ? "营业中" : "已关店",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                        ListTile(
                          leading: CirclePointWidget(),
                          title: Text(
                            '开启自动接单',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          subtitle: Text(
                            '接单更高效',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          trailing: CupertinoSwitch(
                              value: settingsModel
                                  .settings.orderSettings.autoOrder,

                              ///默认打开且禁止关闭
                              activeColor: theme.primaryColor,

                              ///自定义颜色为蓝色
                              onChanged: (value) {
                                settingsModel.saveOrderSettings(
                                    autoOrder: value);
                              }),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            orderHomeInfoModel.onSwitchTab(1);
                          },
                          child: ListTile(
                            leading: CirclePointWidget(
                              color: orderHomeInfoModel.orderNums["等待备餐"] == 0
                                  ? null
                                  : Colors.red,
                            ),
                            title: Badge(
                              position: BadgePosition.topRight(top: 8),
                              showBadge:
                                  orderHomeInfoModel.orderNums["等待备餐"] != 0,
                              badgeContent: Text(
                                orderHomeInfoModel.orderNums["等待备餐"].toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              child: Text(
                                orderHomeInfoModel.orderNums["等待备餐"] == 0
                                    ? '暂无待出餐'
                                    : '等待备餐',
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ),
                            subtitle: Text(
                              '查看已接订单',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RouteName.userNotificationSettingsHome);
                          },
                          leading: CirclePointWidget(),
                          title: Text(
                            '铃声提醒设置',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          trailing: Text('去设置',
                              style: TextStyle(
                                  fontSize: 12, color: theme.primaryColor)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  child: Container(
                    child: Text('提升接单率', style: TextStyle(fontSize: 12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 5,
//                                spreadRadius: 1
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RouteName.userNotificationSettingsHome);
                          },
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.notifications,
                              size: 20,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          dense: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '订单铃声提醒',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              settingsModel.settings.notificationSettings
                                      .latestOrderNotification
                                  ? Text(
                                      '已开启',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : Text(
                                      '未开启',
                                      style: TextStyle(color: Colors.black54),
                                    )
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                        ListTile(
                          onTap: () async {
                            await NotificationPermissions
                                .requestNotificationPermissions(
                                    iosSettings: const NotificationSettingsIos(
                                        sound: true, badge: true, alert: true),
                                    openSettings: true);
                            showToast("请在打开的设置界面中开启通知权限！");
                            setState(() {
                              _permissionStatus = PermissionStatus.granted;
                            });
                          },
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.android,
                              size: 20,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          dense: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '应用推送提醒',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              (_permissionStatus == null ||
                                      _permissionStatus ==
                                          PermissionStatus.denied ||
                                      _permissionStatus ==
                                          PermissionStatus.unknown)
                                  ? Text(
                                      '前往开启',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(
                                      '已开启',
                                      style: TextStyle(color: Colors.green),
                                    )
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropMaterialHeader(),
          onRefresh: model.refresh,
          enablePullUp: false,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                sliver: SliverGrid.count(
                  childAspectRatio: 1,
                  crossAxisCount: 5,
                  children: model.list
                      .asMap()
                      .map((i, element) {
                        return MapEntry(
                            i,
                            InkWell(
                              onTap: () {
                                OrderDialogUtils<T>().orderDialog(
                                    context, model.list[i], orderHomeInfoModel);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: MyCard(
                                  borderRadius: BorderRadius.circular(8),
                                  color: element.pickUpTimeChoice == null
                                      ? theme.primaryColor
                                      : cardColors[element.pickUpTimeChoice],
                                  child: Center(
                                      child: Text(
                                    element.serviceNumber.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 32),
                                  )),
                                ),
                              ),
                            ));
                      })
                      .values
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
