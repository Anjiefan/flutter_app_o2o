import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/shop_invite_data.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/service/shop_locked_repository.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/userful_code_snippets.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/user_home_page.dart';
import 'package:yunzhixiao_business_client/uis/widgets/banner_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/system_static_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/banner_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/banner_model1.dart';

class ShopManageHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopManageHomePageState();
}

class _ShopManageHomePageState extends State<ShopManageHomePage> {

  String _yesterdayNum = "0";
  String _todayNum = "0";
  String _monthNum = "0";
  String _totalBusiness='0.0';
  String _validOrdersNum='0';
  @override
  void initState() {
    super.initState();
    ShopLockedRepository.fetchShopInviteData().then((value){
      setState(() {
        var item = value as ShopInviteData;
        _yesterdayNum = item.yesterdayNum.toString();
        _todayNum = item.todayNum.toString();
        _monthNum = item.mounthNum.toString();
        _totalBusiness = item.totalBusiness.toString();
        _validOrdersNum = item.validOrdersNum.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: const Key("shop_manage_home_page"),
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  _sliverBuilder() {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return <Widget>[
      SliverAppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
//        leading: Gaps.empty,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        centerTitle: true,
        expandedHeight: 20.0,
        pinned: true,
        title: Text("店铺管理", style: TextStyle(fontSize: 18),),
      ),
      SliverPersistentHeader(

        pinned: true,
        delegate: SliverAppBarDelegate(
            Column(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, image: null,
                  ),
                  child: Container(
//                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    height: 80.0,
                    child: MyCard(
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(_totalBusiness, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                              Text("今日流水", style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          Container(color: Colors.white,width: 1,height:35,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(_validOrdersNum, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                              Text("有效订单", style: TextStyle(color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, image: null,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context).scaffoldBackgroundColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    height: 100.0,
                    child: Container(
                      decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Color(0x80DCE7FA), offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
                      ],
                    ),
                      child: PhysicalModel(
//                      elevation: 2.0,
//                      shadowColor: Color(0x80DCE7FA),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.antiAlias,
                        child: MyCard(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                          child: Row(
                            children: <Widget>[
                              const _ShopManageTab('商品', 0),
                              const _ShopManageTab('钱包', 1),
                              const _ShopManageTab('评价', 2),
                              const _ShopManageTab('数据', 3),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            180.0),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap16,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color(0x80DCE7FA),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 8.0,
                        spreadRadius: 0.0),
                  ]),
                  child: PhysicalModel(
                    color: Colors.transparent, //设置背景底色透明
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias, //注意这个属性
                    child: BannerWidget(
                      height: 100,
                      list: staticModel.systemStaticInfo.earnMoneyPageData.swiperPage,
                    ),
                  ),
                ),
              ),
              Gaps.vGap16,
              AspectRatio(
                aspectRatio: 2.8,
                child: MyCard(
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("锁客数据",
                                        style:
                                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).pushNamed(RouteName.shopManageLockCustomerDetail);
                                      },
                                      child: Text("锁客详情",
                                          style:
                                          TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(_yesterdayNum, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                    Text("昨日锁客", style: TextStyle(color: Colors.black87),),
                                  ],
                                ),
                                Container(width: 0.8,height: 35,color: Colors.grey.withOpacity(0.2)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(_todayNum, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                    Text("今日锁客", style: TextStyle(color: Colors.black87),),
                                  ],
                                ),
                                Container(width: 0.8,height: 35,color: Colors.grey.withOpacity(0.2)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(_monthNum, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                    Text("本月锁客", style: TextStyle(color: Colors.black87),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Gaps.vGap16,
              _ShopManageEarnSkillItem(),
            ],
          ),
        ),
      )
    ];
  }
}

class _ShopManageTab extends StatelessWidget {
  const _ShopManageTab(this.title, this.index);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    IconData _iconData = null;
    switch (index) {
      //商品
      case 0:
        _iconData = Icons.card_giftcard;
        break;
      //钱包
      case 1:
        _iconData = Icons.account_balance_wallet;
        break;
      //评价
      case 2:
        _iconData = Icons.comment;
        break;
      //数据
      case 3:
        _iconData = Icons.assessment;
        break;
    }
    return Expanded(
      child: MergeSemantics(
        child: InkWell(
          onTap: () {
            switch (index) {
              //商品
              case 0:
                Navigator.of(context).pushNamed(RouteName.shopManageCommodityManagePage);
                break;
              //钱包
              case 1:
                Navigator.of(context).pushNamed(RouteName.shopManageWallet);
                break;
              //评价
              case 2:
                Navigator.of(context).pushNamed(RouteName.shopManageComment);
                break;
              //数据
              case 3:
                Navigator.of(context).pushNamed(RouteName.shopManageDataHome);
                break;
            }
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconData,
                  color: Theme.of(context).primaryColor,
                  size: 36,
                ),
                Gaps.vGap4,
                Text(title, style: Theme.of(context).textTheme.subtitle),
              ],
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ShopManageEarnSkillItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.05,
      child: MyCard(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
              children: <Widget>[
                 Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("赚钱技巧",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(RouteName.shopManageMarketData);
                        },
                        child: Text("成效分析",
                            style:
                            TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                      ),
                    ],
                  ),
                  Divider()
                ],
              )
            ),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                   child: Column(
                     children: <Widget>[
                       //智能满减、锁客红包
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           GestureDetector(
                             onTap: () {
                               Navigator.pushNamed(
                                   context, RouteName.shopManageActivityMoneyOff);
                             },
                             child: Row(
                               children: <Widget>[
                                 Icon(
                                   Icons.shopping_cart,
                                   color: Theme.of(context).primaryColor,
                                   size: 36,
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text(
                                       "智能满减",
                                       style: TextStyle(
                                           fontSize: 12, color: Colors.black),
                                     ),
                                     Text(
                                       "促销引流，薄利多销",
                                       style: TextStyle(
                                           fontSize: 12, color: Colors.grey),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                           ),

                           //Container(color:Colors.grey.withOpacity(0.3),width: 0.8,height: 35,),

                           //锁客红包
                           GestureDetector(
                             onTap: (){
                               Navigator.pushNamed(
                                   context, RouteName.shopManageActivityLockCustomerRedPacket);
                             },
                             child: Row(
                               children: <Widget>[
                                 Icon(
                                   Icons.redeem,
                                   color: Theme.of(context).primaryColor,
                                   size: 36,
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text(
                                       "锁客红包",
                                       style: TextStyle(
                                           fontSize: 12, color: Colors.black),
                                     ),
                                     Text(
                                       "快速拉新，锁客分成",
                                       style:
                                       TextStyle(fontSize: 12, color: Colors.grey),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),

                       Divider(color: Colors.white,),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           //分享优惠券、锁客折扣
                           GestureDetector(
                             onTap: () {
                               Navigator.pushNamed(
                                   context, RouteName.shopManageActivityInviteRedPacket);
                             },
                             child: Row(
                               children: <Widget>[
                                 Icon(
                                   Icons.confirmation_number,
                                   color: Theme.of(context).primaryColor,
                                   size: 36,
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text(
                                       "分享优惠券",
                                       style: TextStyle(fontSize: 12, color: Colors.black),
                                     ),
                                     Text(
                                       "促进客户，自发推广",
                                       style: TextStyle(fontSize: 12, color: Colors.grey),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                           ),

                           //Container(color:Colors.grey.withOpacity(0.3),width: 0.8,height: 35,),


                           //锁客折扣
                           GestureDetector(
                             onTap: (){
                               Navigator.pushNamed(
                                   context, RouteName.shopManageActivityLockCustomerDiscount);
                             },
                             child: Row(
                               children: <Widget>[
                                 Icon(
                                   Icons.store,
                                   color: Theme.of(context).primaryColor,
                                   size: 36,
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Text(
                                       "锁客折扣",
                                       style: TextStyle(fontSize: 12, color: Colors.black),
                                     ),
                                     Text(
                                       "帮助用户，关注本店",
                                       style: TextStyle(fontSize: 12, color: Colors.grey),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
          ],
        ),
      )),
    );
  }
}
