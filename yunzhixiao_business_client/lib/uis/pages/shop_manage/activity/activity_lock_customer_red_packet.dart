import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_business_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/custom_stepper.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/activity/lock_customer_red_packet_model.dart';

import 'activity_input_page.dart';

class ActivityLockCustomerRedPacketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      ActivityLockCustomerRedPacketPageState();
}

class ActivityLockCustomerRedPacketPageState
    extends State<ActivityLockCustomerRedPacketPage> {
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
        title: Text("锁客红包"),
      ),
      body: ProviderWidget<LockCustomerRedPacketModel>(
        builder: (BuildContext context, LockCustomerRedPacketModel model,
            Widget child) {
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
                                "锁客红包",
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
                      trailing: model.promotion?.id == null
                          ? RaisedButton(
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
                                      model.createLockCustomerFirstPayPromotion(context);
                                    });
                              },
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "开通",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(
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
                                        model.updateLockCustomerFirstPayPromotion(context);
                                      });
                                },
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  "修改规则",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
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
                                  '锁客红包',
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
                                  "增大对首次消费的用户的吸引力，用户首次消费被对应商家锁客，快速提升锁客率",
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
                          currentStep: 3,
                          type: CustomStepperType.vertical,
                          steps: [
                            CustomStep(
                                title: Text(
                                  "用户第一次使用平台消费",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("用户选择锁客优惠最大的商家进行下单"),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("用户创建订单后，获得锁客红包，完成\n"
                                    "付款（订单原价-锁客红包）"),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("该用户成功被该商家锁客，此后该用户\n"
                                    "于平台中任意商家消费，将有0.2%的消\n"
                                    "费额归锁客商家所有"),
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
        model: LockCustomerRedPacketModel(),
      ),
    );
  }
}
