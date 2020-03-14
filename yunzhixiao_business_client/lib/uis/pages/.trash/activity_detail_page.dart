import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/userful_code_snippets.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_flexible_space_bar_widget.dart';
import 'package:yunzhixiao_business_client/view_model/activity_model.dart';

class ActivityDetailPage extends StatefulWidget {
  final RewardList activityItem;

  ActivityDetailPage({this.activityItem});

  @override
  State<StatefulWidget> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: const Key("activity_detail_page"),
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  _sliverBuilder() {
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,
        leading: BackButton(),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        centerTitle: true,
//        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: Container(
            height: 100.0,
            color: Theme.of(context).primaryColor,
          ),
          centerTitle: true,
          titlePadding:
              const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: Text(
            '活动详情',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor, image: null),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                height: 300.0,
                child: MyCard(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 155,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.activityItem.rewardTitle}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ActionChip(
                          shape: BeveledRectangleBorder(),
                          backgroundColor: Colors.greenAccent,
                          labelStyle: TextStyle(color: Colors.green),
                          onPressed: () {},
                          label: Text(
                            "${widget.activityItem.catName}",
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Divider(
                            height: 2,
                          ),
                        ),
                        ActionChip(
                          backgroundColor: Theme.of(context).primaryColor,
                          labelStyle: TextStyle(color: Colors.white),
                          onPressed: () {},
                          label: Text(
                            "修改规则",
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
            190),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap16,
              _FirstCardItem(activityItem: widget.activityItem),
              Gaps.vGap16,
              _SecondCardItem(activityItem: widget.activityItem),
            ],
          ),
        ),
      )
    ];
  }
}

class _FirstCardItem extends StatelessWidget {
  //TODO 这个地方需要后续使用接口获取最新的数据然后使用model中的数据进行显示。
  final RewardList activityItem;

  _FirstCardItem({this.activityItem});

  final ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  final List<String> tabs = ['活动详情', '效果数据', '操作记录'];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: GestureDetector(
        onTap: () {},
        child: MyCard(
            child: ProviderWidget<ActivityListModel>(
                model: ActivityListModel(),
                onModelReady: (model) {
                  model.initData();
                },
                builder: (context, model, child) {
                  if (model.busy) {
                    return ViewStateBusyWidget();
                  } else if (model.error && model.list.isEmpty) {
                    return ViewStateErrorWidget(
                        error: model.viewStateError, onPressed: model.initData);
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

                          return Column(
                            children: <Widget>[
                              Stack(
                                children: [
                                  Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          TabBar(
                                              labelColor: Theme.of(context)
                                                  .primaryColor,
                                              unselectedLabelColor: Colors.grey,
                                              isScrollable: true,
                                              tabs: List.generate(
                                                  tabs.length,
                                                  (index) => Tab(
                                                        text: tabs[index],
                                                      ))),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 140,
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "优惠",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text("优惠规则"),
                                                Text("平台补贴"),
                                                Text("商户承担")
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Divider(
                                              height: 2,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text("${activityItem.catName}"),
                                                Text(
                                                  "${activityItem.applyPrice}元",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                    "${activityItem.applyPrice}元")
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text("2"),
                                    Text("3"),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}

class _SecondCardItem extends StatelessWidget {
  //TODO 这个地方需要后续使用接口获取最新的数据然后使用model中的数据进行显示。
  final RewardList activityItem;

  _SecondCardItem({this.activityItem});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.5,
        child: GestureDetector(
          onTap: () {},
          child: MyCard(
            child: ProviderWidget<ActivityListModel>(
              model: ActivityListModel(),
              onModelReady: (model) {
                model.initData();
              },
              builder: (context, model, child) {
                if (model.busy) {
                  return ViewStateBusyWidget();
                } else if (model.error && model.list.isEmpty) {
                  return ViewStateErrorWidget(
                      error: model.viewStateError, onPressed: model.initData);
                }

                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "时间",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("起止日期", style: TextStyle(color: Colors.grey),),
                                      Text("  ${activityItem.topEndTime} ~ ${activityItem.topEndTime}"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("自动延期", style: TextStyle(color: Colors.grey),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("  已开启", style: TextStyle(color: Colors.greenAccent),),
                                          Text("  ${activityItem.rewardTitle}", style: TextStyle(fontSize: 14),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("生效时段", style: TextStyle(color: Colors.grey),),
                                      Text("  每天，全天"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
