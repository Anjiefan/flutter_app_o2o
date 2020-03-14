import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';

class WalletQAPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WalletQAPageState();
}

class WalletQAPageState extends State<WalletQAPage> {
  var voiceIndex = 0;
  var freqIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("常见问题"),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: MyCard(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      subtitle: Text(
                        "提现是否有限制？",
                        style: TextStyle(color: Colors.grey),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("提现限制"),
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
                                "答：余额大于5元即可提现，一天提现次数无限制，无手续费。",
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
                        "食堂类商户如何赚取余额？",
                        style: TextStyle(color: Colors.grey),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("余额主要来源"),
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
                                "答：未来2.0版本后，普通用户在平台的"
                                    "第一笔消费，与对应商家进行锁客"
                                    "，此后普通用户在平台任意消费将扣除"
                                    "商品价格的1%作为平台手续费，1%"
                                    "的手续费中有20%将打入锁客商家"
                                    "账户中。",
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
                        "食堂类商户售后补偿",
                        style: TextStyle(color: Colors.grey),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("余额其他来源"),
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
                                "答：用户不前往取餐导致商家利益受损进行售后，"
                                    "扣除用户保证金打入商家账户",
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
      ),
    );
  }
}
