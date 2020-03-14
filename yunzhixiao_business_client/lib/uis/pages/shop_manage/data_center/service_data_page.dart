
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/models/daliy_service.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_column_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_row_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/time_filter_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/data_center/daily_service_model.dart';

class ServiceDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServiceDataPageState();
}

class _ServiceDataPageState extends State<ServiceDataPage>
    with AutomaticKeepAliveClientMixin
{
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return  ProviderWidget<DailyServiceModel>(
        model: DailyServiceModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          } else if (model.error && model.list.isEmpty) {
            return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
          }
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropMaterialHeader(),
              onRefresh: model.refresh,
              onLoading: null,
              enablePullUp: false,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: EdgeInsets.all(0),
                    sliver: new SliverList(
                      delegate: new SliverChildListDelegate(
                        <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                CommonShadowContainer(child: TimeFilterWidget<DailyServiceModel>(),padding:EdgeInsets.only(left: 8,bottom: 16)),
                                SizedBox(height: 10,),
                                CommonShadowContainer(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8,left: 12,bottom: 4),
                                      child: Container(
                                        child: Text('接单分析',style: TextStyle(fontSize: 16),),
                                      ),
                                    ),
                                    Divider(height: 0,),
                                    DataRowCard(columns: <Widget>[
                                      DataColumnCard(title: '拒单数',value: model.list[0].rejectNum.toString(), color: Colors.redAccent,),
                                      DataColumnCard(title: '拒单率',value: model.list[0].rejectRate, color: Colors.redAccent),
                                    ],),

                                  ],
                                ),),
                                SizedBox(height: 10,),
                                CommonShadowContainer(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8,left: 12,bottom: 4),
                                      child: Container(
                                        child: Text('出餐分析',style: TextStyle(fontSize: 16),),
                                      ),
                                    ),
                                    Divider(height: 0,),
                                    DataRowCard(columns: <Widget>[
                                      DataColumnCard(title: '催单数',value: model.list[0].hurryNum.toString(), color: Colors.orangeAccent),
                                      DataColumnCard(title: '催单率',value: model.list[0].hurryRate, color: Colors.orangeAccent),
                                    ],),
                                  ],
                                )),
                                SizedBox(height: 10,),
                                CommonShadowContainer(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8,left: 12,bottom: 4),
                                      child: Container(
                                        child: Text('无效单分析',style: TextStyle(fontSize: 16),),
                                      ),
                                    ),
                                    Divider(height: 0,),
                                    DataRowCard(columns: <Widget>[
                                      DataColumnCard(title: '取消单数',value: model.list[0].cancelNum.toString(), color: Colors.blueAccent),
                                      DataColumnCard(title: '取消单率',value: model.list[0].cancelRate, color: Colors.blueAccent),
                                    ],),
                                  ],
                                )),
                                SizedBox(height: 10,),
                                CommonShadowContainer(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8,left: 12,bottom: 4),
                                      child: Container(
                                        child: Text('评论分析',style: TextStyle(fontSize: 16),),
                                      ),
                                    ),
                                    Divider(height: 0,),
                                    DataRowCard(columns: <Widget>[
                                      DataColumnCard(title: '差评',value: model.list[0].badNum.toString(), color: Colors.redAccent),
                                      DataColumnCard(title: '差评率',value: model.list[0].badRate, color: Colors.redAccent),
                                    ],),
                                  ],
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              )
          );
        });
  }
}

