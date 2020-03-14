import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/models/campus_code_info.dart';
import 'package:yunzhixiao_customer_client/models/time_code_info.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/flutter_datetime_picker/src/i18n_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/distribution/campus_code_info_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/distribution/time_code_info_model.dart';

class UserWalletTimeCodeDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserWalletTimeCodeDetailPageState();
}

class UserWalletTimeCodeDetailPageState extends State<UserWalletTimeCodeDetailPage> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  double income = 0.0;
  double outcome = 0.0;
  TimeCodeInfoListModel globalModel;

  void _handleDatePicker() {
    DatePicker.showDatePicker(
      context,
      isShowRightList: false,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime.now(),
      onChanged: (date) {},
      onConfirm: (date) {
        if (!this.mounted) {
          return;
        }
        setState(() {
          year = date.year;
          month = date.month;
          refreshIncomeOutcome();
          globalModel.refresh(year: date.year, month: date.month);
        });

      },
      currentTime: DateTime.now(),
      locale: LocaleType.zh,
    );
  }

  @override
  void initState() {
    refreshIncomeOutcome();
    super.initState();
  }

  void refreshIncomeOutcome() {
    WalletRepository.fetchTimeCodeInfo(year: year, month: month).then((value){
      var item = value as TimeCodeInfo;
      setState(() {
        income = item.income;
        outcome = item.outcome;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("收支明细"),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              height: 80,
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 40,
                    child: FlatButton(
                      onPressed: _handleDatePicker,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "$year年$month月",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "支出 \$$outcome ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "收入 \$$income",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ProviderWidget<TimeCodeInfoListModel>(
                builder: (context, model, child) {
                  if (model.busy) {
                    return ViewStateBusyWidget();
                  } else if (model.error) {
                    return ViewStateErrorWidget(
                        error: model.viewStateError,
                        onPressed: model.initData);
                  } else if (model.empty) {
                    return ViewStateEmptyWidget(onPressed: model.initData);
                  }
                  if (model.empty) {
                    globalModel = model;
                    return Container();
                  } else {
                    globalModel = model;
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
                                  var item = model.list[index] as TimeCodeInfoDetail;
                                  return Column(
                                    children: <Widget>[
                                      new FlatButton(
                                          onPressed: () {},
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      item.incident,
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(top: 8),
                                                        child: Text(
                                                          item.date,
                                                          style: TextStyle(color: Colors.grey, fontSize: 10),
                                                        ))
                                                  ],
                                                ),
                                                alignment: FractionalOffset.centerLeft,
                                              ),
                                              Align(
                                                alignment: FractionalOffset.centerRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    "${item.operate} ${item.timeCode}",
                                                    style: TextStyle(
                                                        color:
                                                        item.operate == "+" ? Colors.green : Colors.black),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  );
                                },
                                childCount: model.list.length,
                              ),
                            )
                          ],
                        ));
                  }
                },
                model: TimeCodeInfoListModel(),
                onModelReady: (model) => model.initData(),
              ),
            )
          ],
        ));
  }
}
