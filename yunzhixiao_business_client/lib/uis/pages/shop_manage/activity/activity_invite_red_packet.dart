import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_business_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/custom_stepper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/activity/invite_red_packet_model.dart';

import 'activity_input_page.dart';

class ActivityInviteRedPacketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivityInviteRedPacketPageState();
}

class ActivityInviteRedPacketPageState
    extends State<ActivityInviteRedPacketPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("邀请红包"),
      ),
      body: ProviderWidget<InviteRedPacketModel>(
        builder:
            (BuildContext context, InviteRedPacketModel model, Widget child) {
//          if (model.busy) {
//            return ViewStateBusyWidget();
//          }
          return SingleChildScrollView(
            child: ListTileTheme(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Row(
                        children: <Widget>[
                          Image.asset(
                            ImageHelper.wrapAssets('red_packet.png'),
                            fit: BoxFit.fill,
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "邀请红包",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.redAccent, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "精准投放",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.redAccent, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "快速锁客",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      trailing: model.promotion?.id == null?RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200)),
                        onPressed: () {
                          NavigatorHelper.pushResult(context,
                              ActivityInputTextPage(
                                title: '锁客金额',
                                hintText: '请填写锁客金额',
                                textMaxLength: 30,
                                content: "",
                                model: model,
                              ), (result) {
                                model.createInviteCustomerPromotion(context);
                              });
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "开通",
                          style: TextStyle(color: Colors.white),
                        ),
                      ):Container(
                        width: 100,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200)),
                          onPressed: () {
                            NavigatorHelper.pushResult(context,
                                ActivityInputTextPage(
                                  title: '锁客金额',
                                  hintText: '请填写锁客金额',
                                  textMaxLength: 30,
                                  content: model.promotion.discountPrice.toString(),
                                  model: model,
                                ), (result) {
                                  model.updateInviteCustomerPromotion(context);
                                });
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "修改规则",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  Divider(
                    height: 0,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  '邀请红包',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Divider(
                                height: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "引导用户自发宣传商家，带来更多锁客用户。",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: CustomStepper(
                          currentStep: 4,
                          type: CustomStepperType.vertical,
                          steps: [
                            CustomStep(
                                title: Text(
                                  "用户将商家邀请链接发至朋友圈",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("有新的用户点击链接进入平台，注册\n"
                                    "并在本商铺完成消费"),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("发布邀请链接的用户获取到邀请红包"),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("发布链接的用户可以使用该红包优惠\n"
                                    "券购买本商铺的餐饮，商家收获锁客\n"
                                    "并提升了销量"),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("此后锁客用户于平台中任意商家消费，\n"
                                    "将有0.2%的消费额归锁客商家所有"),
                                content: Container(),
                                isActive: true),
                          ],
                          controlsBuilder: (BuildContext context,
                              {VoidCallback onStepContinue,
                              VoidCallback onStepCancel}) {
                            return Container();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        model: InviteRedPacketModel(),
      ),
    );
  }
}
