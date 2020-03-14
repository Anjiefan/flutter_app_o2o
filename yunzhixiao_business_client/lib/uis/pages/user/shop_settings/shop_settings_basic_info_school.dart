import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/search_bar_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/shop_settings/school_model.dart';

class ShopSettingsBasicInfoSchoolPage extends StatefulWidget {
  ShopSettingsBasicInfoSchoolPage(
      {Key key,
      @required this.title,
      this.content,
      this.hintText,
      this.keyboardType: TextInputType.text,
      @required this.textMaxLength})
      : super(key: key);

  final String title;
  final String content;
  final String hintText;
  final TextInputType keyboardType;
  final textMaxLength;

  @override
  _ShopSettingsBasicInfoSchoolPageState createState() =>
      _ShopSettingsBasicInfoSchoolPageState();
}

class _ShopSettingsBasicInfoSchoolPageState
    extends State<ShopSettingsBasicInfoSchoolPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(_controller!=null){
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Scaffold(
      body: ProviderWidget<SchoolListModel>(
        builder: (context, model, child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          } else if (model.error) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          } else if (model.empty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          }
          if (model.empty) {
            return Container();
          } else {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: new Container(
                      color: theme.primaryColor,
                      padding: EdgeInsets.only(left: 12, bottom: 12, right: 12, top: MediaQueryData.fromWindow(window).padding.top+12,),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 40,
                              child:  Icon(Icons.arrow_back_ios,color: Colors.white,size: 22,),
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(child: SearchBar(searchBarWidth: MediaQuery.of(context).size.width*0.85,controller: _controller,)),
                          GestureDetector(
                            child: new Container(
                              alignment: Alignment(0, 0),
                              margin: EdgeInsets.only(left: 12),
                              height: 32,
                              child: Text("搜索",style:TextStyle(color:Colors.white,fontSize: 18)),
                            ),
                            onTap: (){
                              model.refresh(search: _controller.text);
                            },
                          )
                        ],
                      ),
                    ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          NavigatorHelper.goBackWithParams(
                              context, model.list[index]);
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(model.list[index].name),
                          ),
                        ),
                      );
                    },
                    childCount: model.list.length,
                  ),
                )
              ],
            );
          }
        },
        model: SchoolListModel(),
        onModelReady: (model) => model.initData(),
      ),
    );
  }
}
