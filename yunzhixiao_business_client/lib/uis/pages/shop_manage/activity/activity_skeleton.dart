import 'package:flutter/material.dart';

import 'package:yunzhixiao_business_client/uis/widgets/skeleton_widget.dart';

//TODO 需要根据活动Item布局修改
class ActivitySkeletonItem extends StatelessWidget {
  final int index;

  ActivitySkeletonItem({this.index: 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,
                  width: 0.7, color: Colors.redAccent))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        width: 40,
                        height: 40,
                        decoration: SkeletonDecoration(isDark: isDark)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 20,
                          decoration: SkeletonDecoration(isDark: isDark)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width / 10,
                      height: 16,
                      decoration: SkeletonDecoration(isDark: isDark)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width / 10,
                    height: 16,
                    decoration: SkeletonDecoration(isDark: isDark))
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width / 6,
                    height: 14,
                    decoration: SkeletonDecoration(isDark: isDark))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
