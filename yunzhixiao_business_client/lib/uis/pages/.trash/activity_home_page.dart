import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/view_model/activity_model.dart';

import 'activity_list_page.dart';

class ShopManageActivityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopManageActivityPageState();
}

class _ShopManageActivityPageState extends State<ShopManageActivityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  List<String> tabs = ['待开始', '进行中', '已完成'];

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  String dropdownValue = '不限创建人';

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    var appBar = AppBar(
                      leading: BackButton(),
                      title: Text("我的活动"),
                      actions: <Widget>[
                        RaisedButton(
                          child: Text(
                            "设置",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                        )
                      ],
                    );

                    return Scaffold(
                      appBar: appBar,
                      body: Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TabBar(
                                          labelColor: Theme.of(context).primaryColor,
                                          unselectedLabelColor: Colors.grey,
                                          isScrollable: true,
                                          tabs: List.generate(
                                              tabs.length,
                                              (index) => Tab(
                                                    text: tabs[index],
                                                  ))),
                                      Container(
                                        height: 25.0,
                                        width: 2.0,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                      ),
                                      DropdownButton(
                                          items: <String>["不限创建人", "仅店主"]
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          value: dropdownValue,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              dropdownValue = newValue;
                                            });
                                          },
                                          style: TextStyle(fontSize: 14),
                                          underline: Container(),
                                          iconEnabledColor: Colors.black,
                                        ),
                                    ],
                                  )),
                            ],
                          ),
                          Expanded(
//                            height: MediaQuery.of(context).size.height -
//                                30 -
//                                appBar.preferredSize.height -
//                                45,
                            child: TabBarView(
                              children: [
                                ActivityListPage(type: 0,),
                                ActivityListPage(type: 1,),
                                ActivityListPage(type: 2,),
                              ],
                            ),
                          ),
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
