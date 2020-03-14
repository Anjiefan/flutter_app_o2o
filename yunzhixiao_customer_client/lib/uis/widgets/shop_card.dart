import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/home_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class ShopCard extends StatefulWidget {
  ShopCard(
      {key,
      this.shop,
      this.devide = true,
      this.blurRadius = 0,
      this.circular = 0})
      : super(key: key);
  Shop shop;
  bool devide;
  double blurRadius;
  double circular;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShopCard(
        shop: shop, devide: devide, blurRadius: blurRadius, circular: circular);
  }
}

class _ShopCard extends State<ShopCard> {
  _ShopCard(
      {this.shop, this.devide = true, this.blurRadius = 0, this.circular = 0});

  Shop shop;
  bool devide;
  double blurRadius;
  double circular;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PhysicalModel(
                  color: Colors.green,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(8),
                  child: WrapperImage(
                    url: shop?.logo ??
                        'http://lc-aveFaAUx.cn-n1.lcfile.com/048122f3082a11ba907b/098a49ca-1580-4b68-a102-93e897c8e706.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(
                        shop?.name ?? '首次消费后绑定锁客商家',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                      ),

                      !shop.isOpen
                          ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: PromotionLable(
                                text: "本店已休息",
                                isGrey: true,
                              ),
                          )
                          : Container(),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.grade,
                            size: 15,
                            color: Colors.orange,
                          ),
                          Text(
                            '${shop?.level ?? '0.0'}',
                            style: TextStyle(color: Colors.orange),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '月售${shop?.sellNumMounth ?? 0}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[]..addAll(show == false
                                  ? buildPromotionWidgets()
                                  : buildPromotionWidgets2()),
                            ),
                            Expanded(child: Container()),
                            shop.promotionList.length > 3
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                    child: Icon(
                                      show == true
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                  )
                                : Container()
                          ])
                    ])),
              ],
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
                  arguments: shop.id)
              .then((result) {});
        }
      },
    );
  }

  bool show = false;

  buildPromotionWidgets() {
    var promotions = shop?.promotionList ?? [];
    List<Widget> returnList = [];
    int i = 0;
    promotions.forEach((value) {
      if (i == 3) {
        return;
      }
      returnList.add(PromotionLable(
        text: value,
      ));
      i++;
    });
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: returnList,
      )
    ];
  }

  buildPromotionWidgets2() {
    var promotions = shop?.promotionList ?? [];
    List<Widget> returnList = [];
    promotions.forEach((value) {
      returnList.add(PromotionLable(
        text: value,
      ));
    });

    List<Widget> returnRowList = [];
    List<Widget> rowList = [];
    for (int i = 0; i < returnList.length; i++) {
      rowList.add(returnList[i]);
      if ((i + 1) % 3 == 0) {
        returnRowList.add(Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowList,
          ),
        ));
        rowList = [];
      }
    }
    returnRowList.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowList,
    ));
    return returnRowList;
  }
}
