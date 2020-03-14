
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_column_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_row_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/time_filter_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/data_center/daily_business_info_model.dart';

class BusinessDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BusinessDataPageState();
}

class _BusinessDataPageState extends State<BusinessDataPage>
    with AutomaticKeepAliveClientMixin
{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return  ProviderWidget<DailyBusinessInfoModel>(
        model: DailyBusinessInfoModel(),
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
                              CommonShadowContainer(child: TimeFilterWidget<DailyBusinessInfoModel>(),padding:EdgeInsets.only(left: 8,bottom: 16)),
                              SizedBox(height: 10,),
                              CommonShadowContainer(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8,left: 12,bottom: 8),
                                    child: Container(
                                      child: Text('本日盈利分析',style: TextStyle(fontSize: 18),),
                                    ),
                                  ),
                                  Divider(height: 0),
                                  DataRowCard(columns: <Widget>[
                                    DataColumnCard(title: '有效订单',value: model.list[0].dailyEarnList[0].validOrdersNum.toString(), color: Colors.lightGreen,),
                                    DataColumnCard(title: '营业总额',value: model.list[0].dailyEarnList[0].totalSell.toString(), color: Colors.lightGreen,),
                                  ],),

                                  DataRowCard(columns: <Widget>[
                                    DataColumnCard(title: '相关订单',value: model.list[0].dailyEarnList[0].relateOrdersNum.toString(), color: Colors.lightBlueAccent,),
                                    DataColumnCard(title: '锁客消费分成',value: model.list[0].dailyEarnList[0].invitesDivideNum.toString(), color: Colors.lightBlueAccent,),
                                  ],),
                                  DataRowCard(columns: <Widget>[
                                    DataColumnCard(title: '无效订单',value: model.list[0].dailyEarnList[0].invalidOrdersNum.toString(), color: Colors.redAccent,),
                                    DataColumnCard(title: '损失总额',value: model.list[0].dailyEarnList[0].totalLoss.toString(), color: Colors.redAccent,),
                                  ],),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8,left: 20,bottom: 16,right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('营业总额',),
                                        Text(model.list[0].dailyEarnList[0].totalBusiness.toString(),style: theme.textTheme.title,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),),
                              SizedBox(height: 10,),
                              CommonShadowContainer(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8,left: 12,bottom: 8),
                                    child: Container(
                                      child: Text('本日锁客分析',style: TextStyle(fontSize: 18),),
                                    ),
                                  ),
                                  Divider(height: 0,),

                                  DataRowCard(columns: <Widget>[
                                    DataColumnCard(title: '本日锁客数',value: model.list[0].dailyInviteList[0].invitesNum.toString(),  color: Colors.orangeAccent,),
                                    DataColumnCard(title: '总锁客数',value: model.list[0].dailyInviteList[0].invitesNumAll.toString(),  color: Colors.orangeAccent,),
                                  ],),
                                ],
                              )),
                              SizedBox(height: 10,),
                              CommonShadowContainer(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8,left: 12,bottom: 8),
                                    child: Container(
                                      child: Text('锁客下单分析',style: TextStyle(fontSize: 18),),
                                    ),
                                  ),
                                  Divider(height: 0,),
                                  DataRowCard(columns: <Widget>[
                                    DataColumnCard(title: '本店下单',value: model.list[0].dailyInviteList[0].invitesConsumeThis.toString(), color: Colors.lightBlueAccent,),
                                    DataColumnCard(title: '消费分成',value: model.list[0].dailyInviteList[0].invitesDivideThis.toString(), color: Colors.orangeAccent,),
                                    DataColumnCard(title: '销售额',value: model.list[0].dailyInviteList[0].invitesSellThis.toString(), color: Colors.lightGreen,),
                                  ],),
                                  Divider(height: 0,),
                                  DataRowCard(columns: <Widget>[
                                    DataColumnCard(title: '其他店下单',value: model.list[0].dailyInviteList[0].invitesConsumeOthers.toString(), color: Colors.teal,),
                                    DataColumnCard(title: '消费分成',value: model.list[0].dailyInviteList[0].invitesDivideOthers.toString(), color: Colors.teal,),
                                  ],),
                                  Divider(height: 0,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16,left: 20,bottom: 16,right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('锁客营业总额',),
                                        Text(model.list[0].dailyInviteList[0].invitesSellSum.toString(),style: theme.textTheme.title,),
                                      ],
                                    ),
                                  ),
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

