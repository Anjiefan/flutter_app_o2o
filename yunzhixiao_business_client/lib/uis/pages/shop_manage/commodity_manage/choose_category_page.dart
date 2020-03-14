import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class ChooseCategoryPage extends StatefulWidget {
  ChooseCategoryPage({Key key}) : super(key: key);

  _ChooseCategoryPageState createState() => _ChooseCategoryPageState();
}

class _ChooseCategoryPageState extends State<ChooseCategoryPage> {
  int chooseIndex = -1;
  CommodityType selectedCommodityType;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('管理分类'),
        actions: <Widget>[
//          InkWell(
//            child: Padding(
//              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
//              child: Container(
//                child: Text(
//                  '完成',
//                  style: TextStyle(fontSize:18),
//                ),
//              ),
//            ),
//            onTap: () {
//              if (selectedCommodityType == null) {
//                showToast("请先选择一个分类");
//                return;
//              }
//              NavigatorHelper.goBackWithParams(context, selectedCommodityType);
//            },
//          )
        ],
      ),
      body: ProviderWidget<CommodityTypeModel>(
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
            // TODO 需要一个空页面
            return Container();
          }
          return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            onRefresh: model.refresh,
            enablePullUp: true,
            onLoading: model.loadMore,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              dense: true,
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        model.list[index].name,
                                        style: theme.textTheme.subhead,
                                      ),
                                    ),
                                  ]),
                              trailing:
//                              chooseIndex == index
//                                  ? Icon(
//                                      Icons.album,
//                                      color: theme.primaryColor,
//                                    )
//                                  :
                              null,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        onTap: () {
                          chooseIndex = index;
                          selectedCommodityType = model.list[index];
                          NavigatorHelper.goBackWithParams(context, selectedCommodityType);
                        },
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  );
                }),
          );
        },
        model: CommodityTypeModel(),
        onModelReady: (model) {
          model.initData();
        },
      ),
    );
  }
}
