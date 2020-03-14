import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:yunzhixiao_customer_client/models/distribution.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/data_repository.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/distribution/user_distribution_list_page.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/utils/chat_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_invite_model.dart';

class UserDistributionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserDistributionPageState();
}

class UserDistributionPageState extends State<UserDistributionPage> {

  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;
  List<String> tabs = ['直接邀请', '间接邀请'];
  Distribution _distribution = Distribution(
      todayDistributionNum: 0,
      yesterdayDistributionNum: 0,
      monthDistributionNum: 0,
      todayEarnNum: 0.0,
      yesterdayEarnNum: 0.0,
      monthEarnNum: 0.0,
      yesterdayIndirectDistributionNum: 0,
      todayIndirectDistributionNum: 0,
      monthIndirectDistributionNum: 0,
      promotionNum: 0,
      promotionSum: 0.0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataRepository.fetchDistributionData().then((value) {
      setState(() {
        var item = value as Distribution;
        _distribution = item;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分销"),
        actions: <Widget>[
          InkWell(child:  Padding(
            padding: const EdgeInsets.only(top: 15,right: 20,left: 20),
            child: Container(
              child: Text('分享',style: TextStyle(fontSize: 18),),
            ),
          ),onTap: () async {
            ChatUtils.shareGrid(context);
          },)
        ],
      ),
      body:ProviderWidget<UserInviteModel>(
          model: UserInviteModel(),
          onModelReady: (model){model.initData();},
          builder: (context, model, child) {
            if (model.busy) {
              return ViewStateBusyWidget();
            } else if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(
                  error: model.viewStateError, onPressed: model.initData);
            }
            var theme = Theme.of(context);
            final size =MediaQuery.of(context).size;
            final width =size.width;
            final height =size.height;
            return Stack(
              children: <Widget>[

                SingleChildScrollView(
                  child: ListTileTheme(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("规则提醒",  style: TextStyle(color: Colors.grey),),
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
                                    "如果绑定直接邀请人获取收益？",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("直接邀请人"),
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
                                            "答：点击右上角分享至朋友圈，用户点击链接完成注册将会绑定为直接邀请人"
                                                "，此后该用户在平台中每笔账户余额保证金支付，您将会获得20%的校园币分成。",
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
                                    "如何绑定间接邀请人获取收益？",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("间接邀请人"),
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
                                            "答：由您的直接邀请人通过app邀请到的用户将会绑定为间接邀请人"
                                                "，此后该用户在平台中每笔账户余额保证金支付，您将会获得10%的校园币分成，教会您的直接邀请人如果使用app将会有很大的助力哦！",
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: MyCard(
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
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
                                                Text("${_distribution.todayDistributionNum}", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                                Text("今日直接邀请", style: TextStyle(color: Colors.black87),),
                                              ],
                                            ),
                                            Container(width: 0.8,height: 35,color: Colors.grey.withOpacity(0.2)),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text("${_distribution.todayIndirectDistributionNum}", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                                Text("今日间接邀请", style: TextStyle(color: Colors.black87),),
                                              ],
                                            ),
                                            Container(width: 0.8,height: 35,color: Colors.grey.withOpacity(0.2)),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text("${_distribution.todayEarnNum}", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                                Text("今日收益", style: TextStyle(color: Colors.black87),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("我的邀请人",  style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: AspectRatio(
                              aspectRatio: 4.5,
                              child: MyCard(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: ClipOval(
                                                  child: WrapperImage(
                                                    url:
                                                    model.fatherData.userData.length !=0?'${model.fatherData.userData[0].user.userinfo.headImg}':'',
                                                    width: 50,
                                                    height: 50,
                                                  )),
                                            ),
                                            SizedBox(width: 10,),
                                            Text(model.fatherData.userData.length !=0?"${model.fatherData.userData[0].user.userinfo.phoneNum}":"暂无邀请人", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          ValueListenableProvider<int>.value(
                            value: valueNotifier,
                            child: DefaultTabController(
                              length: tabs.length,
                              initialIndex: valueNotifier.value,
                              child: Builder(
                                builder: (context) {
                                  if (tabController == null) {
                                    tabController = DefaultTabController.of(context);
                                    tabController.addListener(() {
                                      valueNotifier.value = tabController.index;
                                    });
                                  }
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              TabBar(
                                                labelColor: Theme.of(context).primaryColor,
                                                indicatorColor: Theme.of(context).primaryColor,
                                                isScrollable: true,
                                                indicatorPadding:
                                                EdgeInsets.only(bottom: 5),
                                                tabs: tabs.map((choice) {
                                                  if(choice=='直接邀请'){
                                                    return new Tab(
                                                      text: "${choice}(${model.fatherData.firstNum})人",
                                                    );
                                                  }
                                                  else{
                                                    return new Tab(
                                                      text: "${choice}(${model.fatherData.secondNum})人",
                                                    );
                                                  }

                                                }).toList(),
                                              ),
                                            ],
                                          )
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height / 2.5,
                                        child: TabBarView(
                                          children: [
                                            UserDistributionListPage(type: '1',),
                                            UserDistributionListPage(type: '2',)                              ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      )

                  ),
                ),
              ],
            );



          })

    );

  }
}
