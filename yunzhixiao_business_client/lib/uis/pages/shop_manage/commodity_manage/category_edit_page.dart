import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/category_edit_model.dart';

class CategoryEditPage extends StatefulWidget {
  final int commodityTypeId;

  CategoryEditPage({Key key, this.commodityTypeId}) : super(key: key);

  _ChangeCommodityState createState() => _ChangeCommodityState();
}

class _ChangeCommodityState extends State<CategoryEditPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  CategoryEditModel globalModel;

  @override
  void dispose() {
    if (nameTextEditingController == null) {
      nameTextEditingController.dispose();
    }
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
          title: Text('编辑分类'),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 20, left: 0),
                child: Container(
                  child: Text(
                    '删除',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ),
              onTap: () {
                globalModel.deleteCommodityType(context).then((value) {
                  if (value) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 20, left: 0),
                child: Container(
                  child: Text(
                    '保存',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              onTap: () {
                if (globalModel.commodityType.name.trim() == "") {
                  showToast("名称不能为空");
                  return;
                }
                globalModel.updateCommodityType(context).then((value) {
                  if (value) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),

          ],
        ),
        body: ProviderWidget<CategoryEditModel>(
            model: CategoryEditModel(widget.commodityTypeId),
            onModelReady: (model) {},
            builder:
                (BuildContext context, CategoryEditModel model, Widget child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }
              if (!model.busy) {
                nameTextEditingController.text = model.commodityType.name;
                globalModel = model;
              }
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                      child: Text('基本信息', style: theme.textTheme.caption),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              child: Text('商品名称:',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16)),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  readOnly: false,
                                  controller: nameTextEditingController,
                                  onChanged: (result) {
                                    model.commodityType.name =
                                        nameTextEditingController.text;
                                  },
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black87),
                                  decoration: InputDecoration(
                                    hintText: '请输入商品的名字（20字以内）',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Container(
//                      child: CommonShadowContainer(
//                        child: Padding(
//                          padding: const EdgeInsets.all(10.0),
//                          child: Container(
//                            width: width,
//                            alignment: Alignment.center,
//                            child: Text(
//                              '删除商品',
//                              style: TextStyle(color: Colors.red, fontSize: 18),
//                            ),
//                          ),
//                        ),
//                      ),
//                    )
                  ],
                ),
              );
            }));
  }
}
