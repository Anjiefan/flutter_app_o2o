import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/shop_type.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/commodity_sort_manage_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/left_category_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/right_good_data_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/shop_settings/shop_type_model.dart';

class ShopTypeChoosePage extends StatefulWidget {
  final List shopType2List;

  const ShopTypeChoosePage({Key key, this.shopType2List}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopTypeChoosePageState();
}

class _ShopTypeChoosePageState extends State<ShopTypeChoosePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isFirstTime = true;
  int selectedRank2Id = 0;
  int selectedRank3Id = 0;
  int selectedRank2Index = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (isFirstTime) {
      setState(() {
        selectedRank2Id = widget.shopType2List[0]["id"];
        selectedRank3Id =
            widget.shopType2List[0]["shoptype_self_relate"][0]["id"];
        isFirstTime = false;
      });
    }
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      child: Row(
        children: <Widget>[
          Container(
              width: width / 4,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1, color: Colors.black12))),
              child: ListView.builder(
                itemCount: widget.shopType2List.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          selectedRank2Id = widget.shopType2List[index]["id"];
                          selectedRank2Index = index;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: selectedRank2Id ==
                                    widget.shopType2List[index]["id"]
                                ? BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        left: BorderSide(
                                            color: theme.primaryColor,
                                            width: 5)))
                                : BoxDecoration(),
                            alignment: Alignment.centerLeft,
                            height: 50,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Text(
                              widget.shopType2List[index]["name"],
                              style: theme.textTheme.subtitle,
                            ),
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      ));
                },
              )),
          Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                width: width / 4 * 3,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1, color: Colors.black12))),
                child: Container(
                  width: (width) / 4 * 3,
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    itemCount: widget
                        .shopType2List[selectedRank2Index]
                            ["shoptype_self_relate"]
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedRank3Id = widget
                                .shopType2List[selectedRank2Index]
                            ["shoptype_self_relate"][index]["id"];
                          });
                          NavigatorHelper.goBackWithParams(
                              context, [widget
                              .shopType2List[selectedRank2Index]
                          ["shoptype_self_relate"][index]["id"], widget
                              .shopType2List[selectedRank2Index]
                          ["shoptype_self_relate"][index]["name"]]);
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(

                              title: Text(
                                  widget.shopType2List[selectedRank2Index]
                                      ["shoptype_self_relate"][index]["name"],
                              ),
                              dense: true,
                              trailing:
//                              selectedRank3Id == widget
//                                  .shopType2List[selectedRank2Index]
//                              ["shoptype_self_relate"][index]["id"]?Icon(
//                                Icons.done,
//                                color: index == 0 ? theme.primaryColor : null,
//                              ):
                              Container(width: 24,),
                            ),
                            Divider(
                              height: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
