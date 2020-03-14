import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_with_date_filter.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
class TimeFilterWidget<T extends ViewStateRefreshListDateFilterModel> extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (_, model, __) {
      if (model.busy) {
        return ViewStateBusyWidget();
      } else if (model.error && model.list.isEmpty) {
        return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 20,
            child: FlatButton(
              onPressed: (){
                _handleDatePicker(context,model);
              },
              child: Row(
                children: <Widget>[
                  Text(
                    "${model.year}年${model.month}月${model.day}日",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
        ],
      );
    });

  }
  void _handleDatePicker(BuildContext context,T model) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      locale: 'zh',
      minYear: 1970,
      maxYear: 2999,
      initialYear: model.year,
      initialMonth: model.month,
      initialDate: model.day,
      cancel: Text('取消'),
      confirm: Text('确定'),
      dateFormat: 'yyyy-mm-dd',
      onChanged: (year, month, date) { },
      onConfirm: (year, month, date) {
        model.year=year;
        model.month=month;
        model.day=date;
        model.refresh();
      },
      onCancel: () { },
    );
  }

}

