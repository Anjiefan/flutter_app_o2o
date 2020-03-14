import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_customer_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_sliver_appbar_delegate.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';

class UserWalletCampusCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserWalletCampusCodePageState();
}

class _UserWalletCampusCodePageState extends State<UserWalletCampusCodePage> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserModel>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(model),
      ),
    );
  }

  _sliverBuilder(UserModel model) {
    var primaryColor = Theme.of(context).primaryColor;
    return <Widget>[
      SliverAppBar(
        leading: BackButton(),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
//        leading: Gaps.empty,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        expandedHeight: 20.0,
        pinned: true,
        title: Text(
          "我的校园币",
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
//          RaisedButton(
//            elevation: 0,
//            focusElevation: 0,
//            child: Text(
//              "常见问题",
//              style: TextStyle(
//                fontSize: 14,
//                color: Colors.white,
//              ),
//            ),
//            color: primaryColor,
//            disabledColor: primaryColor,
//            onPressed: () {
//            },
//          )
        ],
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            Column(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: null,
                  ),
                  child: Container(
//                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    height: 100.0,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "校园币余额",
                              style:
                              TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, RouteName.userWalletCampusCodeDetail);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          model.user.timeCode.toString(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 32),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            100.0),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("规则介绍",  style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      subtitle: Text(
                        "校园币可以在平台购买哪些产品？",
                        style: TextStyle(color: Colors.grey),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("校园币作用"),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[

                              Text(
                                "答：校园币和余额一样均可充当保证金、且未来能购买平台中包括优惠卷、促销产品在内的任何产品。",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      subtitle: Text(
                        "如何获取到校园币？",
                        style: TextStyle(color: Colors.grey),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("校园币获取途径"),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "答：用户每一次使用余额充当保证金完成支付并成功交易后"
                                    "，将会获得等值于保证金1%的校园币奖励。",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      subtitle: Text(
                        "1 校园币等于多少人民币呢？",
                        style: TextStyle(color: Colors.grey),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("校园币汇率"),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "答：校园币和人民币一比一兑换，校园币可用于平台内的任意消费，但不可提现。",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }
}

