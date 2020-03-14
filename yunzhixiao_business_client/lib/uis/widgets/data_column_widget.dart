import 'package:flutter/material.dart';

class DataColumnCard extends StatelessWidget{
  Color color;
  String title;
  String value;
  DataColumnCard({this.title,this.value,this.color});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('$title'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 8),
            child: Text('$value',style: TextStyle(color: color,fontSize: 16),),
          ),
        ],
      ),
    );
  }
}
