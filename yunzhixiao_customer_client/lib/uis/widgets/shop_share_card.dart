import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yunzhixiao_customer_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/home_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/utils/chat_utils.dart';

class ShopShareCard extends StatelessWidget {
  ShopShareCard(
      {this.shop, this.devide = true, this.blurRadius = 0, this.circular = 0});

  Shop shop;
  bool devide;
  double blurRadius;
  double circular;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(this.circular),
          boxShadow: [
            BoxShadow(
              color: Color(0x80DCE7FA),
              offset: Offset(0, 0),
              blurRadius: blurRadius,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    PhysicalModel(
                      color: Colors.green,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(8),
                      child: WrapperImage(
                        url: shop?.logo ??
                            'http://lc-aveFaAUx.cn-n1.lcfile.com/048122f3082a11ba907b/098a49ca-1580-4b68-a102-93e897c8e706.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: width - 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      shop?.name ?? '首次消费后绑定锁客商家',
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.grade,
                                        size: 12,
                                        color: Colors.orange,
                                      ),
                                      Text(
                                        '${shop?.level ?? '0.0'}',
                                        style: TextStyle(
                                            color: Colors.orange, fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 1.5,
                                      ),
                                      Text(
                                        '月售${shop?.sellNumMounth ?? 0}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: theme.primaryColor, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2),
                                    child: Text(
                                      "去分享",

                                      style: TextStyle(
                                          fontSize: 12,
                                          color: theme.primaryColor),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  ChatUtils.shareGrid(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.5,
                        ),
                        Container(
                          width: width * 0.6,
                          child: Opacity(
                              opacity: 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "${shop.inviteCustomerPromotionHint}",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(
              height: 15,
            ),
            devide
                ? Divider(
                    height: 1,
                    indent: 80,
                  )
                : Container()
          ],
        ),
      ),
      onTap: () {
        if (shop != null) {
          Navigator.pushNamed(context, RouteName.homeShopDetail,
              arguments: shop.id);
        }
      },
    );
  }
}
