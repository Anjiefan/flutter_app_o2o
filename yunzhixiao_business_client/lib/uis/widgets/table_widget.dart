

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/sliver_header_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/data_center/daily_commodity_model.dart';


class ShopTable<T extends ViewStateRefreshListModel> extends StatelessWidget{
  ShopTable({this.header,this.widths,this.data,this.ordering});
  List header;
  List widths;
  List data;
  String ordering;
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    List<Widget> headerWidgets=[];
    for(int i=0;i<header.length;i++){
      headerWidgets.add(Container(
        alignment: Alignment.topLeft,
        width: width*widths[i],
        child: Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 8,left: 16),
          child: Text(header[i]),
        ),
      ));
    }
    List<Widget> listWidgets=[ Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: headerWidgets,
    )];

    return Consumer<T>(builder: (_, model, __) {
      if (model.busy) {
        return ViewStateBusyWidget();
      }  else if (model.error || model.empty){
        return Opacity(
          opacity: 0.7,
          child: Image.asset(ImageHelper.wrapAssets('nomessage2.png')),
        );
      }

      return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropMaterialHeader(),

          onRefresh: model.refresh,
          enablePullUp: true,
          onLoading: model.loadMore,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 30.0,
                  maxHeight: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: headerWidgets,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var modelList=model.orderingData(ordering: ordering);
                    var item=model.list[index];
                    var itemJson=item.toJson();
                    List<Widget> listWidget=[];
                    for(int i=0;i<data.length+1;i++) {
                      if(i==0){
                        listWidget.add(
                            Container(
                              alignment: Alignment.topLeft,
                              width: width * widths[0],
                              child: Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Text("${index+1}"),
                              ),
                            )
                        );
                      }
                      else{
                        var key_list=data[i-1].split('__');
                        var _data=itemJson;
                        var value='';
                        for(var _i=0;_i<key_list.length;_i++){
                          if(_i!=key_list.length-1){
                            _data=_data[key_list[_i]];
                          }
                          else{
                            value='${_data[key_list[_i]]}';
                          }
                        }
                        listWidget.add(
                            Container(
                              alignment: Alignment.topLeft,
                              width: width * widths[i],
                              child: Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Text("${value}"),
                              ),
                            )
                        );
                      }

                    }
                    return  Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: listWidget,
                        ),
                        Divider()
                      ],
                    );
                  },
                  childCount: model.list.length,
                ),
              )
            ],
          )
      );
    });


  }

}