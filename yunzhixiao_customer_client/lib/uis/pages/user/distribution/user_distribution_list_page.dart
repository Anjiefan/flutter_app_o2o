
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_invite_model.dart';

class UserDistributionListPage extends StatefulWidget {
  String type;
  UserDistributionListPage({this.type});
  @override
  State<StatefulWidget> createState() => _UserDistributionListPageState();
}

class _UserDistributionListPageState extends State<UserDistributionListPage>
{

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInviteModel>(
      builder: (context,model,child){
        if (model.busy){
          return ViewStateBusyWidget();
        }
        if (model.empty){
          return ViewStateEmptyWidget(onPressed: () {model.initData();},);
        }
        if (model.error){
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
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
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 30),
                          dense: true,
                          title: Row(
                            children: <Widget>[
                              Container(
                                child: ClipOval(
                                    child: WrapperImage(
                                      url:
                                      '${model.list[index].invite.userinfo.headImg}',
                                      width: 40,
                                      height: 40,
                                    )),
                              ),
                              SizedBox(width: 10,),
                              Text('${model.list[index].invite.userinfo.phoneNum}', style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: model.list.length,
                  ),
                )
              ],
            )
        );
      },
    );

  }


}





