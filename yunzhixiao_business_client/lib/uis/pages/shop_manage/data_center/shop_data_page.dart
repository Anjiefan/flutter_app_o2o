
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/data_center/shop_comment_stable_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/data_center/shop_sell_table_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_column_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/data_row_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/table_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/time_filter_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/data_center/daily_commodity_model.dart';

class ShopDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopDataPageState();
}

class _ShopDataPageState extends State<ShopDataPage>
    with AutomaticKeepAliveClientMixin
{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return  ProviderWidget<DailyCommodityModel>(
        model: DailyCommodityModel(),
        onModelReady: (model)=>model.initData(),
        builder: (context, model, child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          } else if (model.error && model.list.isEmpty) {
            return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
          }
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      Container(
                        child: Column(
                          children:  <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  CommonShadowContainer(child: TimeFilterWidget<DailyCommodityModel>(),padding:EdgeInsets.only(left: 8,bottom: 16)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            ShopSellTablePage(),
                            SizedBox(height: 10),
                            ShopCommentTablePage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          );


        });
  }
}

