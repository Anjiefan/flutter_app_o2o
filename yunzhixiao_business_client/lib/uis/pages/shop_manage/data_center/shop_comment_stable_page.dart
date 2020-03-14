

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/table_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/data_center/daily_commodity_model.dart';

class ShopCommentTablePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ShopCommentTableState();

}

class _ShopCommentTableState extends State<StatefulWidget>
    with AutomaticKeepAliveClientMixin
{
  @override
  void dispose() {
    // TODO: implement dispose
    valueNotifier.dispose();
    super.dispose();
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  List<String> tabs = ['本店好评', '本店差评'];
  TabController tabController;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return ValueListenableProvider<int>.value(
      value: valueNotifier,
      child: CommonShadowContainer(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(top: 8,left: 16,bottom: 8,right: 16),
            child: Container(
              alignment: Alignment.center,
              child: Text('商品评论',style: TextStyle(fontSize: 18),),
            ),
          ),
          DefaultTabController(
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
                    new Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*0.2
                          ,right: MediaQuery.of(context).size.width*0.2),
                      child: new TabBar(
                        indicatorColor: theme.primaryColor,
                        labelColor: theme.primaryColor,
                        unselectedLabelColor: Colors.black38,
                        controller: tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: new EdgeInsets.only(bottom: 0.0),
                        tabs: tabs.map((choice) {
                          return new Tab(
                            text: choice,
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.2
                          ))
                      ),
                    ),
                    Container(
                      width: width,
                      height: 200,
                      child: TabBarView(
                        children: [
                          ShopTable<DailyCommodityModel>(
                              header: ['排名','商品','好评量','好评率'],
                              widths:[0.2,0.4,0.2,0.2],
                              data:['commodity__name','good_num','good_rate'],
                              ordering: '-good_num',
                          ),
                          ShopTable<DailyCommodityModel>(
                              header: ['排名','商品','好评量','好评率'],
                              widths:[0.2,0.4,0.2,0.2],
                              data:['commodity__name','good_num','good_rate'],
                              ordering: 'good_num',
                          ),


                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        ],
      ),),
    );
  }

}