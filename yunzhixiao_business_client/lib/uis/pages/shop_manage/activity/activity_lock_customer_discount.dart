import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_business_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/custom_stepper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/activity/discount_model.dart';

import 'activity_input_page.dart';

class ActivityLockCustomerDiscountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      ActivityLockCustomerDiscountPageState();
}

class ActivityLockCustomerDiscountPageState
    extends State<ActivityLockCustomerDiscountPage> {
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
        title: Text("锁客折扣"),
      ),
      body: ProviderWidget<DiscountModel>(
        builder: (BuildContext context, DiscountModel model, Widget child) {
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
                            ImageHelper.wrapAssets('discount.png'),
                            fit: BoxFit.fill,
                            width: 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "针对锁客",
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
                                        "锁客折扣",
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
                                        "促进消费",
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
                                title: '锁客折扣',
                                hintText: '请填写锁客折扣（0-1之间）',
                                textMaxLength: 30,
                                content: "",
                                model: model,
                              ), (result) {
                                model.createDiscountPromotion(context);
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
                                  title: '锁客折扣',
                                  hintText: '请填写锁客折扣（0-1之间）',
                                  textMaxLength: 30,
                                  content: "${model.promotion.discountPrice}",
                                  model: model,
                                ), (result) {
                                  model.updateDiscountPromotion(context);
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
                                  '锁客折扣',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Divider(
                                height: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "只有被商家锁客的用户有权限享有的折扣，提升锁客用户忠实度",
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
                          currentStep: 2,
                          type: CustomStepperType.vertical,
                          steps: [
                            CustomStep(
                                title: Text(
                                  "用户在商家下单",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("自动检测该用户是否为本商家的锁客\n"
                                    "用户"),
                                content: Container(),
                                isActive: true),
                            CustomStep(
                                title: Text("锁客用户在仅本店持续享受优惠，更\n"
                                    "愿意在本店消费"),
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
        model: DiscountModel(),
      ),
    );
  }
}
