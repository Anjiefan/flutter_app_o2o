import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/user/red_packet_model.dart';

class UserRedPacketPage extends StatefulWidget {
  final int shopId;

  const UserRedPacketPage({Key key, this.shopId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => UserRedPacketPageState();
}

class UserRedPacketPageState extends State<UserRedPacketPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("红包"),
      ),
      body: ProviderWidget<RedPacketModel>(
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
          var theme = Theme.of(context);
          final size =MediaQuery.of(context).size;
          final width =size.width;
          final height =size.height;
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropMaterialHeader(),
              onRefresh: model.refresh,
              enablePullUp: true,
              onLoading: model.loadMore,
              child: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 90,
                                child: MyCard(
                                  color: Colors.white,
//                                  shadowColor: Colors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text("¥",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                                                Text("${model.list[index].promotionDiscountPrice}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(children: <Widget>[
                                              Text("${model.list[index].shop.name}", style: TextStyle(fontWeight: FontWeight.bold),),
                                              Text("获取日期: ${model.list[index].date}", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                              Text("截止日期: ${model.list[index].dueDate}", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                            ], crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,)
                                          ],
                                        ),
                                        CupertinoButton(
                                          onPressed: (){
                                            if (widget.shopId == null){
                                              Navigator.pushNamed(
                                                  context, RouteName.homeShopDetail, arguments:model.list[index].shop.id);
                                            } else {
                                              NavigatorHelper.goBackWithParams(context, model.list[index]);
                                            }

                                          },
                                          child: Text("立即使用", style: TextStyle(fontSize: 14),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: model.list.length,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    width:width ,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: Theme.of(context).accentColor,
                        child: Text('分享赚券',style: TextStyle(color: Colors.white)),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, RouteName.tab, arguments: 1);
                        },

                      ),
                    )
                  )
                ],
              )
          );
        },
        model: RedPacketModel(widget.shopId),
        onModelReady: (model)=>model.initData(),
      ),
    );
  }
}
