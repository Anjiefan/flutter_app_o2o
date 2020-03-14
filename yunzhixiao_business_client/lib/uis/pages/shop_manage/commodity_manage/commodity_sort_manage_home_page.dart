
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
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class CommoditySortManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommoditySortManagePageState();
}

class _CommoditySortManagePageState extends State<CommoditySortManagePage>
{
  CommodityTypeModel globalModel;

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
              child: Text('保存',style: TextStyle(fontSize: 18),),
            ),
          ),onTap: (){
            if (globalModel.commodityModel != null && globalModel.commodityModel.displayItemList != null){
              globalModel.updateCommodityOrdering();
              Navigator.pop(context);
            }

          },)
        ],

        centerTitle: false,
        title:  Text('商品排序'),
      ),
        body: ProviderWidget<CommodityTypeModel>(
            model: CommodityTypeModel(),
            onModelReady: (model) {model.initData(); globalModel = model;},
          builder: (context, model, child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
            }
            return Container(
              child: Row(
                children: <Widget>[
                  LeftCategoryNav(model: model, sort: true,),
                  Column(
                    children: <Widget>[
//                      Container(
//                        child: Text('热销（100）',style: TextStyle(fontSize: 14,color: Colors.black54),),
//                        padding: EdgeInsets.all(8),
//                        height: 40,
//                        width: width/4*3,
//                        alignment: Alignment.centerLeft,
//                      ),
                      Expanded(child: Container(
                        width: width/4*3,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
                        child: RightGoodPage(sort: true, commodityTypeModel: model),
                      ))
                    ],
                  ),

                ],
              ),
            );
          }),
    );
  }

}

