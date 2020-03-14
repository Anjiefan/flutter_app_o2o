import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/models/campus_code_info.dart';
import 'package:yunzhixiao_customer_client/models/earn_data.dart';
import 'package:yunzhixiao_customer_client/models/earn_data_list.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/flutter_datetime_picker/src/i18n_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/distribution/campus_code_info_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/distribution/earn_code_info_model.dart';

class UserDistributionDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserDistributionDetailPageState();
}

class UserDistributionDetailPageState
    extends State<UserDistributionDetailPage> {
  int year = DateTime
      .now()
      .year;
  int month = DateTime
      .now()
      .month;
  int day = DateTime
      .now()
      .day;
  double income = 0.0;
  double outcome = 0.0;
  EarnCodeInfoListModel globalModel;

  void _handleDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      maxYear: DateTime
          .now()
          .year,
      onConfirm: (y, m, d) {
        setState(() {
          year = y;
          month = m;
          day = d;
          refreshIncomeOutcome();
        });
        globalModel.onRefreshEarnCodeInfo(year, month, day);
      },
    );
  }

  @override
  void initState() {
    refreshIncomeOutcome();
    super.initState();
  }

  void refreshIncomeOutcome() {
    WalletRepository.fetchEarnCodeInfo(year: year, month: month, day: day)
        .then((value) {
      var item = value as EarnDataInfo;
      setState(() {
        income = item.income;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的收入"),

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
                            "$year年$month月$day日",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "总收入 \$$income",
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
              child: ProviderWidget<EarnCodeInfoListModel>(
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
                    return Container();
                  } else {
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
                                  var item = model
                                      .list[index] as EarnDataInfoDetail;
                                  return Column(
                                    children: <Widget>[

                                      Container(
                                          color: Colors.white,
                                          child: new FlatButton(
                                              padding: EdgeInsets.all(10),
                                              onPressed: () {},
                                              child: Row(
                                                children: <Widget>[
                                                  Align(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[

                                                        Container(
                                                          margin: EdgeInsets.only(top: 3),
                                                          child: Text(
                                                            item.spendUser,
                                                            style: TextStyle(color: Colors.black),
                                                          ),),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 3),
                                                          child: Text(
                                                            item.incident,
                                                            style: TextStyle(color: Colors.grey, fontSize: 13),
                                                          ),),
                                                        Container(
                                                            margin: EdgeInsets.only(top: 3),
                                                            child: Text(
                                                              item.date,
                                                              style: TextStyle(color: Colors.grey, fontSize: 10),
                                                            ))
                                                      ],
                                                    ),
                                                    alignment: FractionalOffset.centerLeft,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment: Alignment.centerRight,
                                                      margin: EdgeInsets.only(top: 8),
                                                      child: Text(
                                                        "+ ${item.campusCode}",
                                                        style: TextStyle(
                                                            color:Colors.green,fontSize: 18
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))),
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
                model: EarnCodeInfoListModel(),
                onModelReady: (model) {
                model.initData();
                globalModel = model;
              }
              ),
            )
          ],
        ));
  }
}
