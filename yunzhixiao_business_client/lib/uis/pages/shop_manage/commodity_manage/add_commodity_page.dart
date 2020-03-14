import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/commons/utils/image_utils.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_create_model.dart';

import 'choose_category_page.dart';

class AddCommodityPage extends StatefulWidget {
  AddCommodityPage({Key key}) : super(key: key);

  _AddCommodityState createState() => _AddCommodityState();
}

class _AddCommodityState extends State<AddCommodityPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController typeTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();

  var _imageFile;
  CommodityCreateModel globalModel;

  @override
  void dispose() {
    if (priceTextEditingController == null) {
      priceTextEditingController.dispose();
    }
    if (nameTextEditingController == null) {
      nameTextEditingController.dispose();
    }
    if (typeTextEditingController == null) {
      typeTextEditingController.dispose();
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
          title: Text('添加商品'),
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
                if (_imageFile != null) {
                  ImageUtils.putFile(_imageFile, (value) async {
                    Map uploadInfo = json.decode(value);
                    String realUrl = uploadInfo["url"];
                    globalModel.commodity.img = realUrl;
                    if (globalModel.commodity.name.trim() == "" ||
                        globalModel.commodity.price == null ||
                        globalModel.commodityType == null) {
                      showToast("名称不能为空或价格输入格式不合法");
                      return;
                    }
                    globalModel.createCommodity(context).then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
                  });
                } else{
                  showToast("请选择商品图片");
                }

              },
            )
          ],
        ),
        body: ProviderWidget<CommodityCreateModel>(
            model: CommodityCreateModel(),
            onModelReady: (model) {},
            builder:
                (BuildContext context, CommodityCreateModel model, Widget child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }
              if (!model.busy) {
                nameTextEditingController.text = model.commodity.name;
//                typeTextEditingController.text = model.commodityType.name;
                priceTextEditingController.text =
                    model.commodity.price.toString();
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
                    GestureDetector(
                      onTap: () {
                        try {
                          ImagePicker.pickImage(
                                  source: ImageSource.gallery, maxWidth: 800)
                              .then((value) {
                            setState(() {
                              _imageFile = value;
                            });
                          });
                        } catch (e) {
                          print(e);
                          showToast('请先授权相册权限。');
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text('商品图片:', style: TextStyle(color: Colors.black54,fontSize: 16)),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    child: _imageFile == null
                                        ? WrapperImage(
                                      url: model.commodity.img,
                                      height: 40,
                                      width: 40,
                                    )
                                        : Image.file(
                                      _imageFile,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ))
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              child: Text('商品名称:', style: TextStyle(color: Colors.black54,fontSize: 16)),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  readOnly: false,
                                  style: TextStyle(color: Colors.black87,fontSize: 15),
                                  controller: nameTextEditingController,
                                  onChanged: (result) {
                                    model.commodity.name =
                                        nameTextEditingController.text;
                                  },
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
                    GestureDetector(
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Container(
                                child: Text('店内分类:', style: TextStyle(color: Colors.black54,fontSize: 16)),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: TextField(
                                    readOnly: true,
                                    style: TextStyle(color: Colors.black87,fontSize: 15),
                                    controller: typeTextEditingController,
                                    decoration: InputDecoration(
                                      hintText: '请选择店内分类',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            NavigatorHelper.pushResult(
                                context, ChooseCategoryPage(), (result) {
                              var item = result as CommodityType;
                              typeTextEditingController.text = item.name;
                              model.onSelectedCommodityType(item);
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              child: Text('商品价格:',style: TextStyle(color: Colors.black54,fontSize: 16)),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  readOnly: false,
                                  onChanged: (result) {
                                    model.commodity.price = double.tryParse(
                                        priceTextEditingController.text);
                                  },
                                  style: TextStyle(color: Colors.black87,fontSize: 15),
                                  controller: priceTextEditingController,
                                  decoration: InputDecoration(
                                    hintText: '请输入商品的价格',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
