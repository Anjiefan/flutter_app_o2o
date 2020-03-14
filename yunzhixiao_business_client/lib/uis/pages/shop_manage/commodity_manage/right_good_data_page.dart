import 'package:flutter/material.dart' hide ReorderableListView;
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_reorderable_list.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_model.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class RightGoodPage extends StatefulWidget {
  bool sort = false;
  bool multiManage = false;
  final CommodityTypeModel commodityTypeModel;

  RightGoodPage(
      {Key key,
      this.sort = false,
      this.multiManage = false,
      this.commodityTypeModel})
      : super(key: key);

  _RightGoodPageState createState() =>
      _RightGoodPageState(sort: sort, multiManage: multiManage);
}

class _RightGoodPageState extends State<RightGoodPage> {
  var listIndex = 0; //索引
  bool loading = false;
  bool sort = false;
  bool multiManage = false;


  _RightGoodPageState({Key key, this.sort = false, this.multiManage = false})
      : super();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return ProviderWidget<CommodityModel>(
        model: CommodityModel(widget.commodityTypeModel),
        onModelReady: (model) {
          model.initData();
          widget.commodityTypeModel.onInitializeCommodityModel(model);
        },
        builder: (context, model, child) {
            if (model.error && model.list.isEmpty) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
          return Container(
            width: (width) / 4 * 3,
            decoration: BoxDecoration(color: Colors.white),
            child: !sort?ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          multiManage
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    false
                                        ? Icons.radio_button_unchecked
                                        : Icons.radio_button_checked,
                                    color: theme.primaryColor,
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: Container(
                              decoration: index == 0
                                  ? BoxDecoration(
                                      color: Colors.white,
                                    )
                                  : BoxDecoration(),
                              alignment: Alignment.centerLeft,
//                    height: 150,
                              padding: EdgeInsets.only(
                                  right: 10, left: 10, top: 10, bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: PhysicalModel(
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green,
                                        child: WrapperImage(
                                          url: model.list[index].img,
                                          height: 90,
                                          width: 90,
                                        )),
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            model.list[index].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4,),
                                          Container(
                                            child: Text(
                                              '¥${model.list[index].price}',
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(height: 4,),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(right: 4),
                                                child: Text(
                                                    '月售${model.list[index].sellNumMonth}',
                                                    style: theme.textTheme.caption),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(right: 4),
                                                child: Text(
                                                    '总销量${model.list[index].sellNum}',
                                                    style: theme.textTheme.caption),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2,),
                                          sort || multiManage
                                              ? Container()
                                              : Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              InkWell(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text('编辑', style: TextStyle(color: Theme.of(context).primaryColor),),
                                                    SizedBox(width: 3,),
                                                    CircleAvatar(
                                                      backgroundColor: Theme.of(context).primaryColor,
                                                      radius: 11,
                                                      child: Icon(Icons.edit,size: 13, color: Colors.white,),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                      RouteName
                                                          .shopchangeCommodityPage,
                                                      arguments: model
                                                          .list[index].id)
                                                      .then((result) {
                                                    model.refresh();
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: (){
                                                    model.list[index]
                                                        .status ==
                                                        0 ? model.updateStatus(model.list[index].id, 1):
                                                    model.updateStatus(model.list[index].id, 0);
                                                  },
                                                  child:
                                                  model.list[index].status == 0
                                                      ? Row(
                                                    children: <Widget>[
                                                      Text('上架',
                                                          style: TextStyle(
                                                              color: theme.primaryColor)),
                                                      SizedBox(width: 3,),
                                                      CircleAvatar(
                                                        backgroundColor: Theme.of(context).primaryColor,
                                                        radius: 11,
                                                        child: Icon(Icons.add,size: 18, color: Colors.white,),
                                                      ),
                                                    ],
                                                  ):Row(
                                                    children: <Widget>[
                                                      Text('下架',
                                                          style: TextStyle(
                                                              color: theme.primaryColor)),
                                                      SizedBox(width: 3,),
                                                      CircleAvatar(
                                                        backgroundColor: Theme.of(context).primaryColor,
                                                        radius: 11,
                                                        child: Icon(Icons.remove,size: 18, color: Colors.white,),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  sort
                                      ? Text(
                                          '置顶',
                                          style: TextStyle(color: theme.primaryColor),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
//                  Divider(height: 1,),
                    ],
                  ),
                );
              },
            ):ReorderableListView(
                header:
                Container(
                  child: Text(
                    "长按拖拽以排序",style: TextStyle(color: Colors.grey[400]),
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.grey[200],
                  width: MediaQuery.of(context).size.width,
                ),
                children: model.displayItemList
                    .map((item) => ListTile(
                  title: Text(item.name),
                  key: ValueKey(item),
                  trailing: sort
                      ? Icon(
                    Icons.list,
                    color: Theme.of(context).primaryColor,
                  )
                      : null,
                ),)
                    .toList(),
                onReorder: sort
                    ? (int start, int current) {
                    model.swapIndexes(start, current);
                }
                    : (int start, int current) {}),
          );
        });
  }
}
