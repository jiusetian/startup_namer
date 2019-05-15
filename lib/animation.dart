import 'package:flutter/material.dart';

class FadeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new FadeWidget(
        title: "淡入淡出",
      ),
    );
  }
}

class FadeWidget extends StatefulWidget {
  final String title;

  FadeWidget({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _FadeState();
  }
}

class _FadeState extends State<FadeWidget> with TickerProviderStateMixin {
  //动画相关
  AnimationController controller;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curvedAnimation =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Container(
          child: new FadeTransition(
            opacity: curvedAnimation,
            child: new FlutterLogo(
              size: 100,
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          tooltip: "Fade",
          child: new Icon(Icons.brush),
          onPressed: () {
            controller.forward();
          }),
    );
  }
}
