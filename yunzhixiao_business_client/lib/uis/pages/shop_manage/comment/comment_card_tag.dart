import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTag extends StatelessWidget{
  final String commodity;

  const CardTag({Key key, @required this.commodity}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(200),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
        child: Text(this.commodity, style: TextStyle(fontSize: 12,color: Colors.grey)),
      ),
    );
  }
}