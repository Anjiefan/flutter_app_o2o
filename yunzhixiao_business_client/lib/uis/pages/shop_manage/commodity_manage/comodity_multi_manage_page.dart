
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/left_category_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/right_good_data_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class CommodityMultiManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommodityMultiManagePageState();
}

class _CommodityMultiManagePageState extends State<CommodityMultiManagePage>
{


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Scaffold(
      appBar:   AppBar(
        actions: <Widget>[
          InkWell(child:  Padding(
            padding: const EdgeInsets.only(top: 15,right: 20,left: 20),
            child: Container(
              child: Text('保存',style: TextStyle(fontSize: 22),),
            ),
          ),onTap: (){
          },)
        ],

        centerTitle: false,
        title:  Text('批量管理'),
      ),
      body: ProviderWidget<OrderListModel>(
          model: OrderListModel(),
          onModelReady: (model) => model.initData(),
          builder: (context, model, child) {

            if (model.busy) {
              return ViewStateBusyWidget();
            } else
              if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
            }
            return Stack(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      LeftCategoryNav(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(

                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(false?Icons.radio_button_unchecked:Icons.radio_button_checked,color: theme.primaryColor,),
                                ),
                                Text('多选')
                              ],
                            ),
                            padding: EdgeInsets.only(top:8,bottom: 8),
                            height: 70,
                            width: width/4*3,
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                          ),
                          Expanded(child: Container(
                            width: width/4*3,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1, color: Colors.black12))),
                            child: RightGoodPage(sort: false,multiManage: true,),
                          ))
                        ],
                      ),

                    ],
                  ),
                ),
                new Positioned(
                  bottom: 0,
                  left:0,
                  width: MediaQuery.of(context).size.width,
                  child: CommonShadowContainer(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton.icon(onPressed: (){
                            Navigator.of(context).pushNamed(RouteName.shopCategoryPage);
                          }, icon: Icon(Icons.arrow_drop_up,color: theme.primaryColor,)
                              , label: Text('上架',style: theme.textTheme.subtitle)),
                          Container(height: 40, child: VerticalDivider(color: Colors.black12,width: 0.2,)),
                          FlatButton.icon(onPressed: (){

                            Navigator.of(context).pushNamed(RouteName.shopManageSortCommodityPage);
                          }, icon: Icon(Icons.arrow_drop_down,color: theme.primaryColor,)
                              , label: Text('下架',style: theme.textTheme.subtitle)),
                          Container(height: 40, child: VerticalDivider(color: Colors.black12,width: 0.2,)),

                          FlatButton.icon(onPressed: (){
                            Navigator.of(context).pushNamed(RouteName.shopAddCommodityPage);
                          }, icon: Icon(Icons.delete_forever,color: theme.primaryColor,)
                              , label: Text('删除',style: theme.textTheme.subtitle,))

                        ],
                      )
                  ),
                ),
              ],
            );
          }),
    );
  }

}

