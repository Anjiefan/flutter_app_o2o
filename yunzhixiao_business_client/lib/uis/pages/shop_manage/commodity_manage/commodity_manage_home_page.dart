import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/commodity_sort_manage_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/left_category_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/right_good_data_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class CommodityManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommodityManagePageState();
}

class _CommodityManagePageState extends State<CommodityManagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String selectedMenuName = "全部商品";
  CommodityTypeModel globalModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _buildMenu(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    selectedMenuName,
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                  )
                ],
              ),
            ),
          )
        ],
        centerTitle: false,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteName.shopManageDataHome);
              },
            ),
//            IconButton(
//              icon: Icon(Icons.list),
//              onPressed: () {
//                Navigator.of(context)
//                    .pushNamed(RouteName.shopManageCommodityMultiManagePage);
//              },
//            ),
          ],
        ),
      ),
      body: ProviderWidget<CommodityTypeModel>(
          model: CommodityTypeModel(),
          onModelReady: (model) {
            model.initData();
            globalModel = model;
          },
          builder: (context, model, child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(
                  error: model.viewStateError, onPressed: model.initData);
            }
            return Stack(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      LeftCategoryNav(model: model, sort:false),
                      Column(
                        children: <Widget>[
//                          Container(
//                            child: Text(
//                              '热销（100）',
//                              style: TextStyle(
//                                  fontSize: 14, color: Colors.black54),
//                            ),
//                            padding: EdgeInsets.all(8),
//                            height: 40,
//                            width: width / 4 * 3,
//                            alignment: Alignment.centerLeft,
//                          ),
                          Expanded(
                              child: Container(
                            width: width / 4 * 3,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1, color: Colors.black12))),
                            child: RightGoodPage(
                              commodityTypeModel: model,
                              sort: false,
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                new Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: CommonShadowContainer(
                      child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteName.shopCategoryPage, arguments: model);
                          },
                          icon: Icon(
                            Icons.apps,
                            color: theme.primaryColor,
                          ),
                          label: Text('管理分类', style: theme.textTheme.subtitle)),
//                          Container(height: 40, child: VerticalDivider(color: Colors.black12,width: 0.2,)),
                      FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                RouteName.shopManageSortCommodityPage).then((result){
                                  model.refresh();
                                  model.commodityModel.refresh();
                            });
                          },
                          icon: Icon(
                            Icons.list,
                            color: theme.primaryColor,
                          ),
                          label: Text('商品排序', style: theme.textTheme.subtitle)),
//                          Container(height: 40, child: VerticalDivider(color: Colors.black12,width: 0.2,)),

                      FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteName.shopAddCommodityPage).then((result){
                                  model.refresh();
                                  model.commodityModel.refresh();
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            color: theme.primaryColor,
                          ),
                          label: Text(
                            '新建商品',
                            style: theme.textTheme.subtitle,
                          ))
                    ],
                  )),
                ),
              ],
            );
          }),
    );
  }

  _buildMenu(BuildContext context) {
    showMenu(
      context: context,
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: null,
          child: Text("全部商品"),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text("上架"),
        ),
        const PopupMenuItem(
          value: 0,
          child: Text("已下架"),
        ),
        // 分割线
      ],
      position: RelativeRect.fromLTRB(1, 100, 0, 0),
    ).then((value) {
      print(value);
      setState(() {
        if (value == null) {
          selectedMenuName = "全部商品";
        } else if (value == 1) {
          selectedMenuName = "上架商品";
        } else {
          selectedMenuName = "已下架商品";
        }
      });
      globalModel.onSelectedCommodityStatus(value);
    });
  }
}
