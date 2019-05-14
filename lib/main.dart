import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          //child: new Text('Hello World'),
          //child: new Text(wordPair.asPascalCase),
          child: new RandomWords(),
        ),
      ),
    );
  }
}

//创建一个statefulwidget类，这个类至少需要一个可变的state类
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

//可变的状态
class RandomWordsState extends State<RandomWords> {
  //单词对数组
  final _suggestions = <WordPair>[];
  final TextStyle _biggerFont = new TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    //返回一个text
//    final wordPair = WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Startup Name Generator"),
      ),
      body: _buildSuggestions(),
    );
  }

  //返回一个listview
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        //如果是i是奇数，就添加一个分割线
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        //如果是列表中的最后一个单词对
        if (index >= _suggestions.length) {
          //再生10个单词对
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  //生成row
  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
