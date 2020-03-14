import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/order_model.dart';

class OrderPickUpListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPickUpListPageState();
}

class _OrderPickUpListPageState extends State<OrderPickUpListPage> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("取餐信息"),
        leading: BackButton(),
      ),
      body: Consumer<WaitingReciveListModel>(
          builder: (context, model, child) {
            if(loading==false){
              model.refresh();
              loading=true;
            }
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error) {
              return ViewStateErrorWidget(
                  error: model.viewStateError, onPressed: model.initData);
            }
            if (model.empty) {
              return ViewStateEmptyWidget(onPressed: model.initData);
            }

            return SmartRefresher(
                controller: model.refreshController,
                header: WaterDropMaterialHeader(
                  backgroundColor: Colors.white,
                  color: theme.primaryColor,
                ),
                onRefresh: model.refresh,
                enablePullUp: true,
                onLoading: model.loadMore,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return OrderCard<WaitingReciveListModel>(
                            order: model.list[index],
                          );
                        },
                        childCount: model.list.length,
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
