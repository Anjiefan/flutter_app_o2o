import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class CategoryPage extends StatefulWidget {
  final CommodityTypeModel model;

  CategoryPage({Key key, this.model}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool sort = false;
  List displayItemList;

  @override
  void initState() {
    super.initState();
    setState(() {
      resetLists();
    });
  }

  void resetLists() {
    displayItemList =[];
    for (int i = 0; i < widget.model.list.length; i++) {
      displayItemList.add(widget.model.list[i]);
    }
  }

  void resetListsAfterRefreshModel() {
    widget.model.refresh().then((value) {
      displayItemList = [];
      for (int i = 0; i < widget.model.list.length; i++) {
        displayItemList.add(widget.model.list[i]);
      }
      setState(() {});
    });
  }

//  Widget _buildItem(item) {
//    return Column(
//      key: Key(item.id.toString()),
//      children: <Widget>[
//        Container(
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: ListTile(
//              dense: true,
//              title: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Container(
//                      child: Text(
//                        item.name,
//                        style: Theme.of(context).textTheme.subhead,
//                      ),
//                    ),
//                    sort
//                        ? GestureDetector(
//                            child: Text(
//                              '置顶',
//                              style: TextStyle(
//                                  fontSize: 14,
//                                  color: Theme.of(context).primaryColor),
//                            ),
//                            onTap: () {},
//                          )
//                        : Container(),
//                  ]),
////                          trailing: sort ? Icon(Icons.list) : null,
//            ),
//          ),
//          color: Colors.white,
//        ),
//        Divider(
//          height: 1,
//        )
//      ],
//    );
//  }

  @override
  void dispose() {
    resetLists();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('管理分类'),
        actions: <Widget>[
          sort == false
              ? InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, right: 20, left: 20),
                    child: Container(
                      child: Text(
                        '排序',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (mounted)
                      setState(() {
                        sort = !sort;
                      });
                  },
                )
              : InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, right: 20, left: 20),
                    child: Container(
                      child: Text(
                        '完成',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  onTap: () {
                    String ids = "";
                    for (int i = 0; i < displayItemList.length; i++) {
                      ids += displayItemList[i].id.toString();
                      if (i != displayItemList.length - 1) {
                        ids += ",";
                      }
                    }
                    CommodityRepository.updateCommodityTypeOrdering(ids)
                        .then((value) {
                      resetListsAfterRefreshModel();
                      if (mounted)
                        setState(() {
                          sort = !sort;
                        });
                    });
                  },
                )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ReorderableListView(
              header: sort
                  ? Container(
                      child: Text(
                        "长按拖拽以排序",
                        style: TextStyle(color: Colors.grey[400]),
                        textAlign: TextAlign.center,
                      ),
                      color: Colors.grey[200],
                      width: MediaQuery.of(context).size.width,
                    )
                  : null,
              children: displayItemList
                  .map((item) => ListTile(
                        title: Text(item.name),
                        key: ValueKey(item),
                        trailing: sort
                            ? Icon(
                                Icons.list,
                                color: Theme.of(context).primaryColor,
                              )
                            : ButtonTheme(
                                minWidth: 32,
                                child: FlatButton(
                                  child: Text(
                                    "编辑",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, RouteName.shopCategoryEditPage, arguments: item.id).then((result){
                                        if (result != null && result == true) {
                                          resetListsAfterRefreshModel();
                                        }
                                    });
                                  },
                                ),
                              ),
                      ))
                  .toList(),
              onReorder: sort
                  ? (int start, int current) {
                      setState(() {
                        var tmp = displayItemList[start];
                        displayItemList.remove(tmp);


                        displayItemList.insert(current, tmp);

//                        displayItemList[start] = displayItemList[current];
//                        displayItemList[current] = tmp;
                      });
                    }
                  : (int start, int current) {}),
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
                          .pushNamed(RouteName.shopAddCategoryPage)
                          .then((result) {
                        resetListsAfterRefreshModel();
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: theme.primaryColor,
                    ),
                    label: Text(
                      '添加分类',
                      style: theme.textTheme.subtitle,
                    ))
              ],
            )),
          ),
        ],
      ),
    );
  }
}
