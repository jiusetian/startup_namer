import 'package:flutter/material.dart';

/**
 * widget相关测试
 */
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

//创建一个状态可变的widget
class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}

//自定义可变的状态state
class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text
  String textToShow = "I Like Flutter";

  //点击执行
  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }

  bool toggle = true;

  void _toggle() {
    //当调用setState函数的时候，就会刷新widget
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle)
      return new Text("第一个");
    else
      return new MaterialButton(
        onPressed: () {},
        child: new Text("第二个"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(child:_getToggleChild()),
      //悬浮按钮
      floatingActionButton: new FloatingActionButton(
        //被点击后调用方法
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: new Icon(Icons.update),
      ),
    );
  }
}
