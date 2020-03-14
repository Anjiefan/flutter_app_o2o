import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_create_model.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({Key key}) : super(key: key);

  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategoryPage> {
  TextEditingController nameTextEditingController = TextEditingController();

  CommodityTypeCreateModel globalModel;
  String _name;

  @override
  void dispose() {
    if (nameTextEditingController == null) {
      nameTextEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('添加分类'),
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
                child: Container(
                  child: Text(
                    '保存',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              onTap: () {
                if (globalModel.name.trim() == "") {
                  showToast("名称不能为空");
                  return;
                }
                globalModel.createCommodityType(context).then((value) {
                  if (value) {
                    Navigator.pop(context);
                  }
                });
              },
            )
          ],
        ),
        body: ProviderWidget<CommodityTypeCreateModel>(
            model: CommodityTypeCreateModel(),
            onModelReady: (model) {},
            builder: (BuildContext context, CommodityTypeCreateModel model,
                Widget child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }
              if (!model.busy) {
                globalModel = model;
              }
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                      child: Text('分类名', style: theme.textTheme.caption),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      color: Colors.white,
                      child: TextField(
                        controller: nameTextEditingController,
                        onChanged: (result) {
                          model.name =
                              nameTextEditingController.text;
                        },
                        decoration: InputDecoration(
                          hintText: '请输入分类的名字（20字以内）',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
