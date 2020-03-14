import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/search_bar_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shop_card.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/system/search_model.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  List<String> selectedChoices = List();

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }
  SearchModel model1;
  var model2;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    model1 = Provider.of<SearchModel>(context);
    if(loading==false){
      model1.refresh();
      loading=true;
    }

    return ProviderWidget<ShopListModel>(
        model: ShopListModel(loading: false),
        onModelReady: (model2) {
        },
        builder: (context, model2, child) {
          if (model2.busy) {
            return ViewStateBusyWidget();
          }
          if (model2.error) {
            return ViewStateErrorWidget(
                error: model2.viewStateError, onPressed: model2.initData);
          }
          this.model2=model2;
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: new Container(
                    color: Colors.white,
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
                              color: Colors.black,
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
                              model1.refresh();
                              model2.isSearch = false;
                              model2.clear();
                              model2.notifyListeners();
                            }
                          },
                              cancelCallBack: (){
                                model1.refresh();
                                model2.isSearch = false;
                                model2.clear();
                                model2.notifyListeners();
                              },
                        )),
                        GestureDetector(
                          child: new Container(
                            alignment: Alignment(0, 0),
                            margin: EdgeInsets.only(left: 12),
                            height: 32,
                            child: Text("搜索",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          ),
                          onTap: () {
                            model1.search(_controller.text);
                            model2.isSearch = true;
                            model2.search = _controller.text;
                            model2.notifyListeners();
                            model2.refresh();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                !model2.isSearch
                    ? SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.only(left: 10, top: 5, bottom: 10),
                              child: Text(
                                '历史搜索',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Wrap(
                                children: _buildChoiceList(model1.list ?? []),
                                spacing: 10,
                              ),
                            )
                          ],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ShopCard(shop: model2.list[index]);
                          },
                          childCount: model2.list.length,
                        ),
                      )
              ],
            ),
          );
        });
  }

  _buildChoiceList(reportList) {
    List<Widget> choices = List();

    reportList.forEach((item) {
      choices.add(Container(
        child: ActionChip(
          label: Text(item.key),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          onPressed: () {
            _controller.text=item.key;
            model1.search(_controller.text);
            model2.isSearch = true;
            model2.search = _controller.text;
            model2.notifyListeners();
            model2.refresh();
          },
        ),
      ));
    });

    return choices;
  }
}
