import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/constants/gaps.dart';
import 'package:yunzhixiao_business_client/commons/constants/style.dart';
import 'package:yunzhixiao_business_client/commons/managers/resource_mananger.dart';
import 'package:yunzhixiao_business_client/commons/utils/status_bar_utils.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/app_bar_widget.dart';
import 'package:yunzhixiao_business_client/view_model/user/login_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  static final String title='商铺管理';
  List childStrs=[
    {'name':'用户评价','icon':Icons.textsms}
    ,{'name':'营业分析','icon':Icons.important_devices}
    ,{'name':'菜品管理','icon':Icons.fastfood}
    ,{'name':'餐厅信息','icon':Icons.perm_contact_calendar}
    ,{'name':'账单查询','icon':Icons.library_books}
    ,{'name':'促销活动','icon':Icons.local_activity}
  ];
  var data = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {

            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[



                SizedBox(height: 5,child: Container(
                  color: Colors.black12,
                ),),
                Container(
                  padding: EdgeInsets.only(left: 10,top: 10),
                  child: Row(
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text('一周营业统计'),

                      ),

                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Text('查看',style: TextStyle(color: Theme.of(context).accentColor),),
                            Icon(Icons.keyboard_arrow_right,color: Theme.of(context).accentColor,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment : MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(right: 0,left: 0,top: 30,bottom: 30),
                      child: Sparkline(
                        fallbackWidth: 200,
//                        lineWidth: 0,
                        data: data,
                        lineColor: Theme.of(context).accentColor,
                        pointsMode: PointsMode.all,
                        pointSize: 8.0,
                        pointColor: Theme.of(context).accentColor,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text('今日营业额'),
                        ),
                        Text('¥0.00',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    )
//                    Expanded(
//                        child:
//                    )
                  ],
                ),
                SizedBox(height: 5,child: Container(
                  color: Colors.black12,
                ),),

              ],
            ),
          ),

          SliverGrid.count(

              crossAxisCount: 3,
              childAspectRatio: 2,
              children: childStrs.map((item){
                return Container(
                  decoration: BoxDecoration(

                      border: Border(
                        left: Divider.createBorderSide(context, width: 0.5),
                        top: Divider.createBorderSide(context, width:   0.5),
                        bottom: Divider.createBorderSide(context, width: 0.5),
                        right: Divider.createBorderSide(context, width: 0.5),
                      )),
                  child: FlatButton.icon(
                    onPressed: (){},
                    icon: Icon(item['icon'],color: Theme.of(context).accentColor,),
                    label: Text(item['name']),),);
              }).toList()
          ),
        ],
      ),
    );

  }

}


class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

LineChartData sampleData2() {
  return LineChartData(
    lineTouchData: const LineTouchData(enabled: false,),
    gridData: const FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: TextStyle(
          color: const Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        margin: 10,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'SEPT';
            case 7:
              return 'OCT';
            case 12:
              return 'DEC';
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1m';
            case 2:
              return '2m';
            case 3:
              return '3m';
            case 4:
              return '5m';
            case 5:
              return '6m';
          }
          return '';
        },
        margin: 8,
        reservedSize: 30,
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        )),
    minX: 0,
    maxX: 14,
    maxY: 6,
    minY: 0,
    lineBarsData: linesBarData2(),
  );
}

List<LineChartBarData> linesBarData2() {
  return [
    const LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 4),
        FlSpot(5, 1.8),
        FlSpot(7, 5),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      curveSmoothness: 0,
      colors: [
        Color(0x444af699),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    ),
    const LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        Color(0x99aa4cfc),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        Color(0x33aa4cfc),
      ]),
    ),
    const LineChartBarData(
      spots: [
        FlSpot(1, 3.8),
        FlSpot(3, 1.9),
        FlSpot(6, 5),
        FlSpot(10, 3.3),
        FlSpot(13, 4.5),
      ],
      isCurved: true,
      curveSmoothness: 0,
      colors: [
        Color(0x4427b6fc),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    ),
  ];
}



