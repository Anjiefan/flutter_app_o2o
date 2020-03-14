import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:quiver/strings.dart';



class ActivityItemWidget extends StatelessWidget {
  final RewardList activityItem;
  final int index;
  final GestureTapCallback onTap;

  /// 首页置顶
  final bool top;

  /// 隐藏收藏按钮
  final bool hideFavourite;

  ActivityItemWidget(this.activityItem,
      {this.index, this.onTap, this.top: false, this.hideFavourite: false})
      : super(key: ValueKey(activityItem.rewardId));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RouteName.shopManageActivityDetail, arguments: activityItem);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, width: 0.7),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.card_giftcard, size: 40, color: Theme.of(context).primaryColor,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${activityItem.rewardTitle}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${activityItem.catName}", style: TextStyle(color: Theme.of(context).primaryColor),),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("${activityItem.tagsName}", style: TextStyle(color: Colors.black, fontSize: 16),)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("${activityItem.rewardId} 至 ${activityItem.catId}", style: TextStyle(color: Colors.grey),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}