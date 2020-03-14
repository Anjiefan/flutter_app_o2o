import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/models/shop_comment.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_controller.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/controllers/shop_scroll_coordinator.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/comment_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

class HomeShopDetailCommentPage extends StatefulWidget {
  final ShopScrollCoordinator shopCoordinator;
  final int shopId;

  const HomeShopDetailCommentPage(
      {@required this.shopCoordinator, Key key, this.shopId})
      : super(key: key);

  @override
  _HomeShopDetailCommentPageState createState() =>
      _HomeShopDetailCommentPageState();
}

class _HomeShopDetailCommentPageState extends State<HomeShopDetailCommentPage>
    with  AutomaticKeepAliveClientMixin
{
  ShopScrollCoordinator _shopCoordinator;
  ShopScrollController _listScrollController;

  @override
  void initState() {
    _shopCoordinator = widget.shopCoordinator;
    _listScrollController = _shopCoordinator.newChildScrollController();
    super.initState();
  }
  ShopDetailModel model2;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget2<ShopCommentListModel, ShopDetailModel>(
      model1: ShopCommentListModel(widget.shopId),
      model2: ShopDetailModel(widget.shopId),
      onModelReady: (model1, model2) {model1.initData(); model2.refresh();},
      builder:
          (BuildContext context, ShopCommentListModel model1, ShopDetailModel model2, Widget child) {
        this.model2=model2;

        if (model1.busy || model2.busy) {
          return ViewStateBusyWidget();
        } else if (model1.error) {
          return ViewStateErrorWidget(
              error: model1.viewStateError, onPressed: model1.initData);
        } else if (model1.empty) {
          return ViewStateEmptyWidget(onPressed: model1.initData);
        }
        if (model1.empty) {
          return Container();
        }
        return SmartRefresher(
            controller: model1.refreshController,
            enablePullUp: true,
            enablePullDown: false,
            onLoading: model1.loadMore,
            child: CustomScrollView(

                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(Container(
                    color: Colors.white,
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            model2.shop.level.toString(),
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 48),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "商家评分",
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 17),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RatingBarIndicator(
                                rating: model2.shop.level,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 12.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          )
                        ],
                      ),
                    ),
                  ),
                        90),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(Container(
                      color: Colors.white,
                      child: Container(
                        height: 50,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: _buildChoiceList(model1
                            ),
                          ),
                        ),
                      ),
                    ),
                        50),

                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            ShopCommentItem item=model1.list[index];
                        return CommentCard(username: item.userInfo.username
                          ,img: item.userInfo.headImg,good: item.isGood,date: item.date,content: item.content,);
                      },
                      childCount:  model1.list.length,
                    ),
                  )
                ],
            ));
      },
    );
  }

  @override
  void dispose() {
    _listScrollController?.dispose();
    _listScrollController = null;
    super.dispose();
  }

  List selectedChoices = [0];

  _buildChoiceList(model) {
    List<Widget> choices = List();

    [['全部 ${model2.shop.commentNumSum}',0]
      , ['好评 ${model2.shop.likeCommentNum}',1]
      , ['差评 ${model2.shop.dislikeCommentNum}',2]].forEach((item) {

      choices.add(Container(
        child: ChoiceChip(
          label: Text(
          item[0],
            style: TextStyle(
                color: Colors.white,
                fontWeight: selectedChoices.contains(item[1])
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          backgroundColor: item[1] == 2 ? Colors.grey[400] : Colors.blue[200],
          selectedColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          selected: selectedChoices.contains(item[1]),
          onSelected: (selected) {
            setState(() {
              if (selectedChoices.contains(item[1])) {
              } else {
                selectedChoices.clear();
                selectedChoices.add(item[1]);
                switch (item[1]){
                  case 0:
                    model.onRefreshIsGood(null);
                    break;
                  case 1:
                    model.onRefreshIsGood(1);
                    break;
                  case 2:
                    model.onRefreshIsGood(0);
                    break;
                }
              }
            });
          },
        ),
      ));
      choices.add(SizedBox(
        width: 10,
      ));
    });

    return choices;
  }

  @override
  bool get wantKeepAlive => true;
}
