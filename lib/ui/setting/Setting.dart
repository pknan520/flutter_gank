import 'package:flutter/material.dart';
import 'package:flutter_gank/config/AppOptions.dart';

class Setting extends StatelessWidget {
  const Setting({Key key, this.appOpt, this.onOptionsChanged})
      : super(key: key);
  final AppOptions appOpt;
  final ValueChanged<AppOptions> onOptionsChanged;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text('主题设置',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 6,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                children: colorList.map((item) {
                  return GestureDetector(
                    child: Container(
                      color: item,
                    ),
                    onTap: () {
                      onOptionsChanged(appOpt.copyWith(
                          appTheme: AppTheme(
                              ThemeData().copyWith(primaryColor: item))));
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        // child: GridView.count(
        //   physics: new NeverScrollableScrollPhysics(),
        //   crossAxisCount: 6,
        //   crossAxisSpacing: 4.0,
        //   mainAxisSpacing: 4.0,
        //   children: colorList.map((item) {
        //     return GestureDetector(
        //       child: Container(
        //         color: item,
        //       ),
        //       onTap: () {
        //         onOptionsChanged(appOpt.copyWith(
        //             appTheme:
        //                 AppTheme(ThemeData().copyWith(primaryColor: item))));
        //       },
        //     );
        //   }).toList(),
        // ),
      ),
    );
  }
}

const List<Color> colorList = <Color>[
  Colors.red,
  Colors.pink,
  Colors.green,
  Colors.teal,
  Colors.blue,
  Colors.cyan,
  Colors.purple,
  Colors.yellow,
  Colors.lime,
  Colors.orange,
  Colors.white,
  Colors.black,
];
