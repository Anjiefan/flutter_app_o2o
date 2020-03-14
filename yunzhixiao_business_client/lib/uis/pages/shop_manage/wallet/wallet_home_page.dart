import 'package:fake_alipay/fake_alipay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/service/order_repository.dart';
import 'package:yunzhixiao_business_client/service/wallet_repository.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/pages/commons/input_text_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/userful_code_snippets.dart';
import 'package:yunzhixiao_business_client/uis/widgets/shadow_container_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class WalletHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  Alipay _alipay = Alipay();
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserModel>(context);
    return Scaffold(
      body: CustomScrollView(
        key: const Key("shop_manage_home_page"),
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
          "商家钱包",
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          RaisedButton(
            elevation: 0,
            focusElevation: 0,
            child: Text(
              "常见问题",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            color: primaryColor,
            disabledColor: primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, RouteName.shopManageWalletQA);
            },
          )
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
                              "可提现余额（元）",
                              style:
                              TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          RouteName.shopManageWalletDetail);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          model.user.campusCode.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.35,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Stack(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(14.0),
                                                            child: Align(
                                                              alignment:
                                                              FractionalOffset
                                                                  .center,
                                                              child: Text("提现"),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                            child: Align(
                                                              alignment:
                                                              FractionalOffset
                                                                  .centerRight,
                                                              child: FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "取消")),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      new Container(
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: <Widget>[
                                                            WithdrawNumWidget(
                                                              money: 5,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: 10,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: 20,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      new Container(
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: <Widget>[
                                                            WithdrawNumWidget(
                                                              money: 40,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: 100,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: 200,
                                                            ),
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 60,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(500),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text("提现",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)),
                                              ],
                                            )),
                                      ),
                                    ],
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
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      image: null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                  Icon(Icons.person, color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "提取账户",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("支付宝",
                                    style: TextStyle(color: Colors.white)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child:Container(),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            150.0),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//              Gaps.vGap16,
              _WalletHomeBindAccountTab(model),
            ],
          ),
        ),
      )
    ];
  }
}
class WithdrawNumWidget extends StatelessWidget {
  final double money;

  WithdrawNumWidget({Key key, this.money}) : super();

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        WalletRepository.withdraw(money).then((value) {
          showToast("提现成功，预计24小时内到账。");
        }, onError: (e) {
          showToast(e.message);
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.amber,
                ),
                Text(
                  "${money}元",
                  style: TextStyle(fontSize: 16),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.25,
      ),
    );
  }
}

class _WalletHomeBindAccountTab extends StatelessWidget {
  final UserModel model;
  _WalletHomeBindAccountTab(this.model);

  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 0,right: 0,top: 8,bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("绑定支付账户",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 4,),
                    Divider(height: 0,),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "支付宝账户",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          model.user.withdrawaccount.alyPayAccount,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      NavigatorHelper.pushResult(context,
                          InputTextPage(
                            title: '绑定支付宝账号',
                            hintText: '请填写支付宝账号',
                            textMaxLength: 30,
                            content: model.user.withdrawaccount.alyPayAccount == "未设置" ? "" : model.user.withdrawaccount.alyPayAccount,
                          ), (result) {
                              model.updateUserWithdrawAccount(context, alipayAccount: result);
                            });
                    },
                    trailing: Icon(Icons.chevron_right),
                  ),

                ],
              ),
            ],
          ),
        ));
  }
}
