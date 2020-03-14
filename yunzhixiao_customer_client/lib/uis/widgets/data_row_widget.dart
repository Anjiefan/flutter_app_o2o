import 'package:flutter/material.dart';

class DataRowCard extends StatelessWidget{
  List<Widget> columns=[];
  DataRowCard({this.columns});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    var width =size.width;
    var one_width=(width-columns.length+1)/columns.length;
    List<Widget> widgets=[];
    for(var widget in columns){
      widgets.add(Container(
        alignment: Alignment.topLeft,
        width: one_width,
        child: widget,
      ));
      widgets.add(Container(height: 40, child: VerticalDivider(color: Colors.grey,width: 1,)));
    }
    widgets[widgets.length-1]=Container();
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widgets,
    );

  }
}
