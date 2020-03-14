
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/models/order_category_type.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/skeleton_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/sliver_header_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/time_filter_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class OrderSearchPage<T extends OrderListModel> extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderSearchPageState<T>();
}

class _OrderSearchPageState<T extends OrderListModel> extends State<OrderSearchPage>
{
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return  Consumer<T>(
      builder: (context, model, child) {
        if(loading==false){
          model.refresh();
          loading=true;
        }
        if (model.busy) {
          return ViewStateBusyWidget();
        } else if (model.error) {
          return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
        }
        else if (model.empty) {
          return Column(
            children: <Widget>[
              TimeFilterWidget<T>(),
              Expanded(child: ViewStateEmptyWidget(onPressed: model.initData))
            ],
          );
        }
        else{
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropMaterialHeader(),
              onRefresh: model.refresh,
              enablePullUp: true,
              onLoading: model.loadMore,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      minHeight: 30.0,
                      maxHeight: 40.0,
                      child: TimeFilterWidget<T>(),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return OrderCard(order: model.list[index],operate: false,);
                      },
                      childCount: model.list.length,
                    ),
                  )
                ],
              )
          );
        }
      },


    );
  }


}





