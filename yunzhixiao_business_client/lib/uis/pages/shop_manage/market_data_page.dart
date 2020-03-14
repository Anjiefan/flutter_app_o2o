
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/models/daily_promotion_effect.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_column_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_row_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/time_filter_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/daily_promotion_effect_model.dart';

class MarketDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MarketDataPageState();
}

class _MarketDataPageState extends State<MarketDataPage>
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
    return Scaffold(
      appBar:  AppBar(
        title: Text('成效分析'),
      ),
      body:  ProviderWidget<DailyPromotionEffectModel>(
          model: DailyPromotionEffectModel(),
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
                                  CommonShadowContainer(child: TimeFilterWidget<DailyPromotionEffectModel>(),padding:EdgeInsets.only(left: 8,bottom: 16)),
                                  SizedBox(height: 10,),
                                  CommonShadowContainer(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8,left: 12,bottom: 4),
                                        child: Container(
                                          child: Text('店铺满减',style: TextStyle(fontSize: 16),),
                                        ),
                                      ),
                                      Divider(height: 0,),
                                      DataRowCard(columns: <Widget>[
                                        DataColumnCard(title: '用券订单',value: model.list[0].moneyOffOrderNum.toString(), color: Colors.redAccent,),
                                        DataColumnCard(title: '客单价',value: model.list[0].moneyOffPerCustomerTransaction.toString(), color: Colors.redAccent),
                                        DataColumnCard(title: '营业额',value: model.list[0].moneyOffSalesOfAmount.toString(), color: Colors.redAccent),
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
                                          child: Text('锁客红包',style: TextStyle(fontSize: 16),),
                                        ),
                                      ),
                                      Divider(height: 0,),
                                      DataRowCard(columns: <Widget>[
                                        DataColumnCard(title: '用券订单',value: model.list[0].lockedRedPacketOrderNum.toString(), color: Colors.orangeAccent),
                                        DataColumnCard(title: '成功锁客',value:  model.list[0].lockedRedPacketLockedUser.toString(), color: Colors.orangeAccent),
                                        DataColumnCard(title: '营业额',value: model.list[0].lockedRedPacketSalesOfAmount.toString(), color: Colors.orangeAccent),
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
                                          child: Text('分享优惠券',style: TextStyle(fontSize: 16),),
                                        ),
                                      ),
                                      Divider(height: 0,),
                                      DataRowCard(columns: <Widget>[
                                        DataColumnCard(title: '成功锁客',value: model.list[0].shareRedPacketOckedUser.toString(), color: Colors.blueAccent),
                                        DataColumnCard(title: '营业额',value: model.list[0].shareRedPacketSalesOfAmount.toString(), color: Colors.blueAccent),
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
                                          child: Text('锁客折扣',style: TextStyle(fontSize: 16),),
                                        ),
                                      ),
                                      Divider(height: 0,),
                                      DataRowCard(columns: <Widget>[
                                        DataColumnCard(title: '用券订单',value: model.list[0].lockedDiscountOrderNum.toString(), color: Colors.redAccent),
                                        DataColumnCard(title: '营业额',value: model.list[0].lockedDiscountSalesOfAmount.toString(), color: Colors.redAccent),
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
          }),
    );
  }
}

