import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/search_bar_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class OrderProcessSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderProcessSearchPageState();
  }
}

class OrderProcessSearchPageState extends State<OrderProcessSearchPage> {
  List<String> selectedChoices = List();

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  var model2;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ProviderWidget<OrderListModel>(
        model: OrderListModel(status: 1
            ,commodity_status: '-1,0,1,2,3'),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SmartRefresher(
                controller: model.refreshController,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: model.loadMore,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: new Container(
                        color: theme.primaryColor,
                        padding: EdgeInsets.only(
                          left: 12,
                          bottom: 12,
                          right: 12,
                          top: MediaQueryData.fromWindow(window).padding.top + 12,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: 40,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                                child: SearchBar(
                                  searchBarWidth:
                                  MediaQuery.of(context).size.width * 0.85,
                                  controller: _controller,
                                  onTextChange: (result) {
                                    if (result.trim() == "") {
//                                      model.isSearch = false;
//                                      model.search = null;
//                                      model.notifyListeners();
//                                      model.searchOrderByServiceNum(_controller.text);
                                    }
                                  },
                                  cancelCallBack: () {
//                                    model.isSearch = false;
//                                    model.search = null;
//                                    model.notifyListeners();
//                                    model.searchOrderByServiceNum(_controller.text);
                                  },
                                )),
                            GestureDetector(
                              child: new Container(
                                alignment: Alignment(0, 0),
                                margin: EdgeInsets.only(left: 12),
                                height: 32,
                                child: Text("餐号搜索",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                              onTap: () {
                                model.isSearch = true;
                                model.searchOrderByServiceNum(_controller.text);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {


                          return OrderCard(
                            order: model.list[index],
                          );
                        },
                        childCount: model.list.length,
                      ),
                    )
                  ],
                )
            ),
          );
        });
  }
}
