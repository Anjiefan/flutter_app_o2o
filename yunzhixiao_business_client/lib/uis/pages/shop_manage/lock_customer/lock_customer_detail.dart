import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/models/shop_invite_data.dart';
import 'package:yunzhixiao_business_client/models/shop_locked_list.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/service/shop_locked_repository.dart';
import 'package:yunzhixiao_business_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/shop_locked/shop_locked_model.dart';

class LockCustomerDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LockCustomerDetailPageState();
}

class LockCustomerDetailPageState extends State<LockCustomerDetailPage> {

  int shopLockedNum = 0;
  String monthBenefit = "0.00";
  String allBenefit = "0.00";

  @override
  void initState() {
    super.initState();
    ShopLockedRepository.fetchShopLocked().then((value){
      setState(() {
        shopLockedNum = value.num;
      });
    });
    ShopLockedRepository.fetchShopInviteData().then((value){
      setState(() {
        var item = value as ShopInviteData;
        monthBenefit = item.mounthInvitesDivideThis.toString();
        allBenefit = item.invitesDivideThisSum.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("锁客详情"),
      ),
      body: Scaffold(
        body: ListTileTheme(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            '规则提醒',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Divider(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "1.用户在平台的第一笔消费结束后，自动绑定对应的商家，被该商家锁客。\n"
                            "2.升级至2.0版本后，锁客用户于平台任意消费额的0.2%归属商家",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("锁客收益",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Divider(
                          height: 0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "本月锁客收益",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    monthBenefit,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Container(
                                  width: 0.8,
                                  height: 35,
                                  color: Colors.grey.withOpacity(0.2)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "锁客总收益",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    allBenefit,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("锁客用户",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("用户总数：$shopLockedNum",
                                  style:
                                  TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                            ],
                          ),
                        ),
                        Divider(
                          height: 0,
                        ),
                        Expanded(
                          child: ProviderWidget<ShopLockedModel>(
                            builder: (context, model, child) {
                              if (model.busy) {
                                return ViewStateBusyWidget();
                              } else if (model.error) {
                                return ViewStateErrorWidget(
                                    error: model.viewStateError,
                                    onPressed: model.initData);
                              }
                              if (model.empty) {
                                return Container();
                              }
                              return SmartRefresher(
                                  controller: model.refreshController,
                                  header: WaterDropMaterialHeader(),
                                  onRefresh: model.refresh,
                                  enablePullUp: true,
                                  onLoading: model.loadMore,
                                  child: CustomScrollView(
                                    slivers: <Widget>[
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            var item = model.list[index] as ShopLocked;
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(

                                                    children: <Widget>[
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50),
                                                        child: WrapperImage(
                                                          url: item.invite.userinfo.headImg,
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(item.invite.userinfo.username),
                                                    ],
                                                  ),
                                                  Text(item.invite.userinfo.updateTime.substring(0, 10))
                                                ],
                                              ),
                                            );
                                          },
                                          childCount: model.list.length,
                                        ),
                                      )
                                    ],
                                  ));
                            },
                            model: ShopLockedModel(),
                            onModelReady: (model) => model.initData(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
