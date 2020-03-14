import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uuid/uuid.dart';
import 'package:yunzhixiao_business_client/models/money_off_promotion_list.dart';
import 'package:yunzhixiao_business_client/service/activity_repository.dart';
import 'package:yunzhixiao_business_client/service/wallet_repository.dart';
import 'package:yunzhixiao_business_client/uis/helpers/theme_helper.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';

class ActivityMoneyOffPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivityMoneyOffPageState();
}

class ListItemBean {
  var uuid;
  int moneyA;
  int moneyB;

  ListItemBean(this.uuid, this.moneyA, this.moneyB);
}

class ActivityMoneyOffPageState extends State<ActivityMoneyOffPage> {
  List<ListItemBean> listItems = List<ListItemBean>();
  var uuid = Uuid();
  List<TextEditingController> limitMoneyTextControllers =
      List<TextEditingController>();
  List<TextEditingController> offMoneyTextControllers =
      List<TextEditingController>();
  bool _showCreateButton = true;
  bool _isSwitchOn = false;
  int _promotionId = -1;

  @override
  void initState() {
    super.initState();
    ActivityRepository.fetchMoneyOffPromotions().then((value) {
      var item = value as List<MoneyOffPromotion>;
      if (item.length == 0) {
        // not created
        setState(() {
          listItems.clear();
          listItems.add(ListItemBean(uuid.v1(), 0, 040));
          limitMoneyTextControllers.clear();
          limitMoneyTextControllers.add(TextEditingController());
          offMoneyTextControllers.clear();
          offMoneyTextControllers.add(TextEditingController());
        });
      } else {
        //has created
        var promotion = item[0];
        setState(() {
          listItems.clear();
          limitMoneyTextControllers.clear();
          offMoneyTextControllers.clear();
          promotion.priceBetween.forEach((value) {
            listItems
                .add(ListItemBean(uuid.v1(), value.condition, value.discount));
            limitMoneyTextControllers
                .add(TextEditingController(text: value.condition.toString()));
            offMoneyTextControllers
                .add(TextEditingController(text: value.discount.toString()));
          });
          _showCreateButton = false;
          _promotionId = promotion.id;
          if (promotion.status == "启动") {
            _isSwitchOn = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    limitMoneyTextControllers.forEach((controller) {
      controller.dispose();
    });
    offMoneyTextControllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("智能满减"),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "优惠",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                return Dismissible(
                                    key: Key(listItems[index].uuid),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      setState(() {
                                        listItems.removeAt(index);
                                        limitMoneyTextControllers
                                            .removeAt(index);
                                        offMoneyTextControllers.removeAt(index);
                                        listItems.forEach((bean) {
                                          print("moneyA=${bean.moneyA}");
                                          print("moneyB=${bean.moneyB}");
                                        });
                                      });
                                    },
                                    confirmDismiss: (direction) async {
                                      if (listItems.length < 2) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      // 这里使用 ListTile 因为可以快速设置左右两端的Icon
                                      child: ListTile(
                                        trailing: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                        title: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "满 ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Container(
                                            width: 50,
                                            child: Theme(
                                              data: ThemeData(
                                                  primaryColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  hintColor: Colors.blue,
                                                  scaffoldBackgroundColor:
                                                      Colors.blue),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    fillColor: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 2.0),
                                                    border:
                                                        OutlineInputBorder()),
                                                key: Key(listItems[index].uuid),
                                                controller:
                                                    limitMoneyTextControllers[
                                                        index],
                                                onChanged: (result) {
                                                  listItems[index].moneyA =
                                                      int.parse(
                                                          limitMoneyTextControllers[
                                                                  index]
                                                              .text);
                                                },
                                              ),
                                            ),
                                          ),
                                          Text(" 元 "),
                                          Text("减 "),
                                          Container(
                                            width: 50,
                                            child: Theme(
                                              data: ThemeData(
                                                  primaryColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  hintColor: Colors.blue,
                                                  scaffoldBackgroundColor:
                                                      Colors.blue),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    fillColor: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 2.0),
                                                    border:
                                                        OutlineInputBorder()),
                                                key: Key(listItems[index].uuid),
                                                controller:
                                                    offMoneyTextControllers[
                                                        index],
                                                onChanged: (result) {
                                                  listItems[index].moneyB =
                                                      int.parse(
                                                          offMoneyTextControllers[
                                                                  index]
                                                              .text);
                                                },
                                              ),
                                            ),
                                          ),
                                          Text(" 元"),
                                          listItems.length > 1
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      listItems.removeAt(index);
                                                      limitMoneyTextControllers
                                                          .removeAt(index);
                                                      offMoneyTextControllers
                                                          .removeAt(index);
                                                      listItems.forEach((bean) {
                                                        print(
                                                            "moneyA=${bean.moneyA}");
                                                        print(
                                                            "moneyB=${bean.moneyB}");
                                                      });
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.red),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    )));
                              },
                              itemCount: listItems.length,
                            ),
                            Divider(
                              height: 0,
                            ),
                            GestureDetector(
                              onTap: listItems.length < 5
                                  ? () {
                                      setState(() {
                                        listItems
                                            .add(ListItemBean(uuid.v1(), 0, 0));
                                        limitMoneyTextControllers
                                            .add(TextEditingController());
                                        offMoneyTextControllers
                                            .add(TextEditingController());
                                        listItems.forEach((bean) {
                                          print("moneyA=${bean.moneyA}");
                                          print("moneyB=${bean.moneyB}");
                                        });
                                      });
                                    }
                                  : null,
                              child: Material(
                                color: Colors.white,
                                textStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text("添加满减(${listItems.length}/5)")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: _showCreateButton
                                    ? CupertinoButton(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        onPressed: () {
                                          String resultStr = "[";
                                          listItems.forEach((value) {
                                            if (value.moneyA == 0 ||
                                                value.moneyB == 0) {
                                            } else {
                                              resultStr +=
                                                  "{\"discount\":${value.moneyB},\"condition\":${value.moneyA}},";
                                            }
                                          });
                                          resultStr = resultStr.substring(
                                                  0, resultStr.length - 1) +
                                              "]";
                                          ActivityRepository
                                                  .createMoneyOffPromotions(
                                                      status: 1,
                                                      resultStr: resultStr)
                                              .then((value) {
                                            showToast("创建成功");
                                            setState(() {});
                                          }, onError: (e) {
                                            showToast("创建失败");
                                            setState(() {});
                                          });
                                        },
                                        color: Theme.of(context).primaryColor,
                                        child: Text("立即创建"),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 200,
                                            child: CupertinoButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              onPressed: () {
                                                int status =
                                                    _isSwitchOn ? 1 : 0;
                                                String resultStr = "[";
                                                listItems.forEach((value) {
                                                  if (value.moneyA == 0 ||
                                                      value.moneyB == 0) {
                                                  } else {
                                                    resultStr +=
                                                        "{\"discount\":${value.moneyB},\"condition\":${value.moneyA}},";
                                                  }
                                                });
                                                resultStr = resultStr.substring(
                                                        0,
                                                        resultStr.length - 1) +
                                                    "]";
                                                ActivityRepository
                                                        .updateMoneyOffPromotions(
                                                            resultStr:
                                                                resultStr,
                                                            status: status,
                                                            id: _promotionId)
                                                    .then((value) {
                                                  showToast("修改成功");
                                                  setState(() {});
                                                }, onError: (e) {
                                                  showToast("修改失败");
                                                  setState(() {});
                                                });
                                              },
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Text("修改规则"),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                '规则状态',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              CupertinoSwitch(
                                                  value: _isSwitchOn,
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _isSwitchOn =
                                                          !_isSwitchOn;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
              SizedBox(
                height: 10,
              ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '什么是店铺满减？',
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
                          "店铺满减是作用于店铺订单的一种优惠形式，可以根据客单价设置优惠门槛及力度。",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Divider(
                        height: 0,
                      ),
                    ],
                  ),
                ),
              ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '为什么要设置店铺满减？',
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
                          "合理的店铺满减可以引导更多校园用户结伴订餐，增强店铺吸引力，增加销量。",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
