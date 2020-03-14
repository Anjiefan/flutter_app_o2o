import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/comment/comment_card_tag.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class ShopCommentCard extends StatelessWidget {
  final ShopCommentItem shopCommentItem;

  ShopCommentCard({this.shopCommentItem});

  buildCommodityChips(){
    var widgetList = <Widget>[];
    if (this.shopCommentItem.commodity == null || this.shopCommentItem.commodity.length == 0){
      return <Widget>[];
    }
    if (this.shopCommentItem.commodity.length < 2){
      widgetList.add(Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: CardTag(
              commodity: this.shopCommentItem.commodity[0].name,
            ),
          ),
        ],
      ));
    } else if (this.shopCommentItem.commodity.length % 2 == 0){
      for (int i = 0; i < this.shopCommentItem.commodity.length / 2; i+=2) {
        widgetList.add(Row(
          children: <Widget>[
            CardTag(
                commodity: this.shopCommentItem.commodity[i].name,
            ),
            CardTag(
              commodity: this.shopCommentItem.commodity[i+1].name,
            )
          ],
        ));
      }
    } else {
      for (int i = 0; i < this.shopCommentItem.commodity.length / 2; i+=2) {
        widgetList.add(Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CardTag(
                commodity: this.shopCommentItem.commodity[i].name,
              ),
            ),
            CardTag(
              commodity: this.shopCommentItem.commodity[i + 1].name,
            ),
          ],
        ));
      }
      widgetList.add(Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CardTag(
              commodity: this.shopCommentItem.commodity[this.shopCommentItem.commodity.length - 1].name,
            ),
          ),
        ],
      ));
    }
    return widgetList;
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
      child: MyCard(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      WrapperImage(
                        url: shopCommentItem.userInfo.headImg
                        ,width: 40,height: 40,),
//                      Image.network(
//                        shopCommentItem.userInfo.headImg,
//                        width: 40,
//                        height: 40,
//                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(shopCommentItem.userInfo.username),
                            shopCommentItem.isGood == 1 ?
                            Icon(
                              Icons.thumb_up,
                              color: Colors.amber,
                            ) : Icon(
                              Icons.thumb_down,
                              color: Colors.grey,
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    shopCommentItem.date.substring(0, 10),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text(
                      shopCommentItem.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style: TextStyle(fontSize: 14,color: Colors.black54),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: buildCommodityChips()
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
