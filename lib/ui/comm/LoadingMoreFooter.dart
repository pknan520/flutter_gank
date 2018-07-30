import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingMoreFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: SpinKitThreeBounce(
          color: Colors.grey,
          size: 25.0,
        ),
      ),
    );
  }
}
