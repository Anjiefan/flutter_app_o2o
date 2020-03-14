
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/message/system_message_model.dart';

class UserMessageHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserMessageHomePageState();
}

class _UserMessageHomePageState extends State<UserMessageHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  _sliverBuilder() {
    return <Widget>[
      SliverAppBar(
        leading: BackButton(),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        expandedHeight: 20.0,
        pinned: true,
        title: Text(
          "消息",
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[],
      ),
      SliverFillRemaining(
        child: ProviderWidget<SystemMessageListModel>(
          onModelReady: (model) => model.initData(),
          builder: (BuildContext context, SystemMessageListModel model,
              Widget child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error) {
              return ViewStateErrorWidget(
                  error: model.viewStateError, onPressed: model.initData);
            } else if (model.empty) {
              return Column(
                children: <Widget>[
                  Expanded(
                      child: ViewStateEmptyWidget(onPressed: model.initData))
                ],
              );
            } else if (model.unAuthorized) {
              return ViewStateUnAuthWidget(onPressed: () {
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmartRefresher(
                  controller: model.refreshController,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                  onRefresh: model.refresh,
                  enablePullUp: true,
                  onLoading: model.loadMore,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: MyCard(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 12.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  child: WrapperImage(
                                                      url: model
                                                                  .list[index]
                                                                  .systemMessage
                                                                  .img ==
                                                              null
                                                          ? ""
                                                          : model.list[index]
                                                              .systemMessage.img,
                                                      width: 40,
                                                      height: 40)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                '${model.list[index].systemMessage.title}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 14),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: model.list[index].status ==
                                                                              1
                                                                          ? Colors
                                                                              .grey
                                                                          : Theme.of(context)
                                                                              .primaryColor,
                                                                      width: 0.5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2),
                                                                ),
                                                                child: Text(
                                                                  model.list[index]
                                                                              .status ==
                                                                          1
                                                                      ? '已读'
                                                                      : '未读',
                                                                  style: TextStyle(
                                                                      color: model.list[index].status ==
                                                                              1
                                                                          ? Colors
                                                                              .grey
                                                                          : Theme.of(context)
                                                                              .primaryColor,
                                                                      fontSize:
                                                                          9),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 0,
                                                          ),
                                                          Text(
                                                            '${model.list[index].systemMessage.type}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '${model.list[index].date.toString().substring(0, 10)}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black45),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                          ],
                                        ),
                                        Divider(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                  "${model.list[index].systemMessage.value}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                          childCount: model.list.length,
                        ),
                      )
                    ],
                  )),
            );
          },
          model: SystemMessageListModel(),
        ),
      ),
    ];
  }
}
