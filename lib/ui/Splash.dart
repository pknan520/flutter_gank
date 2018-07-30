import 'package:flutter/material.dart';

class Slpash extends StatefulWidget {
  @override
  _SlpashState createState() => _SlpashState();
}

class _SlpashState extends State<Slpash> with TickerProviderStateMixin {
  final TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.white);

  AnimationController _controllerLogo;
  CurvedAnimation _curvedLogoMove;
  CurvedAnimation _curvedLogoOpacity;

  AnimationController _controllerText0;
  CurvedAnimation _curvedText0Move;
  CurvedAnimation _curvedText0Opacity;

  AnimationController _controllerText1;
  CurvedAnimation _curvedText1Move;
  CurvedAnimation _curvedText1Opacity;

  @override
  void initState() {
    super.initState();
    initAnim();
  }

  void initAnim() {
    //    LOGO的动画
    _controllerLogo =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _controllerText0.forward();
            }
          });
    Tween(begin: -40.0, end: 0.0).animate(_controllerLogo)
      ..addListener(() {
        setState(() {});
      });
    _curvedLogoMove =
        CurvedAnimation(parent: _controllerLogo, curve: Curves.easeIn);
    _curvedLogoOpacity =
        CurvedAnimation(parent: _controllerLogo, curve: Curves.easeIn);

    _controllerLogo.forward();

    //    字符串1的动画
    _controllerText0 =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _controllerText1.forward();
            }
          });
    Tween(begin: 10.0, end: 50.0).animate(_controllerText0)
      ..addListener(() {
        setState(() {});
      });
    _curvedText0Move =
        CurvedAnimation(parent: _controllerText0, curve: Curves.easeIn);
    _curvedText0Opacity =
        CurvedAnimation(parent: _controllerText0, curve: Curves.easeIn);

    //    字符串2的动画
    _controllerText1 =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          });

    Tween(begin: 10.0, end: 50.0).animate(_controllerText1)
      ..addListener(() {
        setState(() {});
      });
    _curvedText1Move =
        CurvedAnimation(parent: _controllerText1, curve: Curves.easeIn);
    _curvedText1Opacity =
        CurvedAnimation(parent: _controllerText1, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    _controllerText0.dispose();
    _controllerText1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: -40 + _curvedLogoMove.value * 40.0,
            top: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: FadeTransition(
              opacity: _curvedLogoOpacity,
              child: Container(
                alignment: Alignment.center,
                child: FlutterLogo(size: 100.0),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 10.0 + _curvedText0Move.value * 40.0,
            child: FadeTransition(
              opacity: _curvedText0Opacity,
              child: Text('Supported by: Gank.io', style: textStyle),
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: 10.0 + _curvedText1Move.value * 40.0,
            child: FadeTransition(
              opacity: _curvedText1Opacity,
              child: Text('Powered by: PK', style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
