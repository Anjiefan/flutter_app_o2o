import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/comment/comment_list_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/comment/shop_comment_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class CommentHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommentHomePageState();
}

class CommentHomePageState extends State<CommentHomePage> {
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  List<String> tabs = ['好评', '差评'];

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("顾客评价"),
        ),
        body: ValueListenableProvider<int>.value(
                value: valueNotifier,
                child: DefaultTabController(
                  length: tabs.length,
                  initialIndex: valueNotifier.value,
                  child: Builder(
                    builder: (context) {
                      if (tabController == null) {
                        tabController = DefaultTabController.of(context);
                        tabController.addListener(() {
                          valueNotifier.value = tabController.index;
                        });
                      }
                      var model = Provider.of<UserModel>(context);
                      return Column(
                        children: <Widget>[
                          MyCard(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        RatingBarIndicator(
                                          rating: 4.3,
                                          itemBuilder: (context, index) =>
                                              Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 30.0,
                                          direction: Axis.horizontal,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0),
                                          child: Text(
                                            "${model.user.shop.level}",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 24),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 2.0, left: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width/2-16,
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "好评率：",
                                                style:
                                                TextStyle(color: Colors.grey),
                                              ),
                                              Text(
                                                "${(model.user.shop.likeCommentNum / model.user.shop.commentNumSum) * 100}%",
                                                style:
                                                TextStyle(color: Colors.lightGreen),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "好评数：${model.user.shop.likeCommentNum}",
                                                style:
                                                TextStyle(color: Colors.grey),
                                              ),
                                              Text(
                                                "${model.user.shop.dislikeCommentNum}",
                                                style:
                                                TextStyle(color: Colors.lightGreen),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 2.0, left: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width/2-16,
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "差评率：",
                                                style:
                                                TextStyle(color: Colors.grey),
                                              ),
                                              Text(
                                                "${(model.user.shop.dislikeCommentNum / model.user.shop.commentNumSum) * 100}%",
                                                style:
                                                TextStyle(color: Colors.redAccent),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "差评数：",
                                                style:
                                                TextStyle(color: Colors.grey),
                                              ),
                                              Text(
                                                "${model.user.shop.dislikeCommentNum}",
                                                style:
                                                TextStyle(color: Colors.redAccent),
                                              )
                                            ],
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TabBar(
                                  labelColor: Theme.of(context).primaryColor,
                                  indicatorColor: Theme.of(context).primaryColor,
                                  isScrollable: true,
                                  indicatorPadding:
                                  EdgeInsets.only(bottom: 5),
                                  tabs: tabs.map((choice) {
                                    return new Tab(
                                      text: choice,
                                    );
                                  }).toList(),
                                ),
                              ],
                            )
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                CommentListPage(1),
                                CommentListPage(0)
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
    );
  }
}
