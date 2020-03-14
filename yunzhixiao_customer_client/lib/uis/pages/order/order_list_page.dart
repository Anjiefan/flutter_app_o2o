
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/order_model.dart';

class OrderListPage<T extends OrderListModel> extends StatefulWidget {
  final bool is_comment;
  final bool is_after_sell;
  final int commodity_status;
  final int status;
  const OrderListPage({Key key,this.is_comment,this.is_after_sell,this.commodity_status,this.status,}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OrderListPageState<T>();
}

class _OrderListPageState<T extends OrderListModel> extends State<OrderListPage>
{

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Consumer<T>(builder: (_,model, __) {
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
            Expanded(child: ViewStateEmptyWidget(onPressed: model.initData))
          ],
        );
      }else if (model.unAuthorized) {
        return ViewStateUnAuthWidget(onPressed: ()  {
          print("onPressed");
          Navigator.of(context).pushNamed(RouteName.login).then((result) {
            print("success=$result");
            // 登录成功,获取数据,刷新页面
            if (result) {
              model.initData();
            }
          });
        });
      }
      else{
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
                      return OrderCard<T>(order: model.list[index],);
                    },
                    childCount: model.list.length,
                  ),
                )
              ],
            )
        );
      }

    });

  }


}





