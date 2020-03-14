import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/uis/widgets/skeleton_widget.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/refresh_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/.trash/activity_list_item.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/activity/activity_skeleton.dart';
import 'package:yunzhixiao_business_client/view_model/activity_model.dart';

class ActivityListPage extends StatefulWidget {
  final int type;
  ActivityListPage({this.type});
  @override
  State<StatefulWidget> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<ActivityListModel>(model: ActivityListModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child){
        if (model.busy) {
          return SkeletonList(
            builder: (context, index) => ActivitySkeletonItem(),
          );
        } else if (model.error && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (model.empty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropHeader(),
          footer: RefresherFooter(),
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          enablePullUp: true,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                RewardList item = model.list[index];
                return ActivityItemWidget(item);
              }),

        );
      }
      
    );
  }
}
