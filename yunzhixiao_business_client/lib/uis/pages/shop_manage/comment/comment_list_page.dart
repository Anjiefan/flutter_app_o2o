
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shop_comment_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/skeleton_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/sliver_header_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/time_filter_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/comment/shop_comment_model.dart';

class CommentListPage extends StatefulWidget {
  final isGood;
  CommentListPage(this.isGood);
  @override
  State<StatefulWidget> createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage>
    with AutomaticKeepAliveClientMixin
{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var primaryColor = Theme.of(context).primaryColor;
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return  ProviderWidget<ShopCommentListModel>(
      builder: (context, model, child) {
        if (model.busy) {
          return ViewStateBusyWidget();
        } else if (model.error) {
          return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
        } else if (model.empty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        if (model.empty){
          return Container();
        }
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropMaterialHeader(),
              onRefresh: model.refresh,
              enablePullUp: true,
              onLoading: model.loadMore,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return ShopCommentCard(shopCommentItem: model.list[index],);
                      },
                      childCount: model.list.length,
                    ),
                  )
                ],
              )
          );
      },
      model: ShopCommentListModel(isGood: widget.isGood),
      onModelReady: (model)=>model.initData(),


    );
  }


}





