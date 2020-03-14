import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

class HomeShopDetailInfoPage extends StatefulWidget {
  final int shopId;
  const HomeShopDetailInfoPage({Key key, this.shopId}) : super(key: key);

  @override
  _HomeShopDetailInfoPageState createState() => _HomeShopDetailInfoPageState();
}

class _HomeShopDetailInfoPageState extends State<HomeShopDetailInfoPage>
    with AutomaticKeepAliveClientMixin
{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return
      Consumer<ShopDetailModel>(
//        model: ShopDetailModel(widget.shopId),
//        onModelReady: (model){
//          model.refresh();
//        },
  builder: (BuildContext context, ShopDetailModel model, Widget child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width:width ,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "商家信息",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: WrapperImage(
                            url:
                            model.shop.logo,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${model.shop.desc}",
                              style: TextStyle(color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("商家名称"),
                        Text(
                          "${model.shop.name}",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("商家品类"),
                        Text(
                          model.shop.type == null?"":"${model.shop.type.name}",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("商家地址"),
                        Text(
                          model.shop.address,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("商家电话"),
                        GestureDetector(
                          onTap: () async {
                            var url = "tel:${model.shop.phoneNum}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              showToast("拨号失败");
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).primaryColor,
                                    size: 12,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "联系商家",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("营业时间"),
                        Text(
                          "${model.shop.startTime}:${model.shop.startTimeMinute >= 0 &&
                              model.shop.startTimeMinute < 10
                              ? "0${model.shop.startTimeMinute}"
                              : model.shop.startTimeMinute}-${model.shop.endTime}:${model.shop.endTimeMinute >= 0 &&
                              model.shop.endTimeMinute < 10
                              ? "0${model.shop.endTimeMinute}"
                              : model.shop.endTimeMinute}",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          );
      },
      );
  }
}
