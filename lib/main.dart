import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      //主题
      theme: new ThemeData(primaryColor: Colors.white),
      home: new RandomWords(),
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

//可变的状态，重写build方法返回一个widget
class RandomWordsState extends State<RandomWords> {
  //单词对数组
  final _suggestions = <WordPair>[];
  final TextStyle _biggerFont = new TextStyle(fontSize: 18);

  //一个保存收藏单词的set集合
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    //返回一个text
    //    final wordPair = WordPair.random();
    //    return new Text(wordPair.asPascalCase);

    //Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Startup Name Generator"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //将收藏单词界面添加到导航管理器中
  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(
        //参数是一个匿名函数，返回一个widget组件
        builder: (context) {
      //返回一个迭代器Iterable
      final titles = _saved.map(
          //又是一个匿名函数，处理每个迭代元素的函数
          (pair) {
        return ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      //包含分割线的list元素集合
      final divideds =
          ListTile.divideTiles(tiles: titles, context: context).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("收藏夹"),
        ),
        body: new ListView(
          children: divideds,
        ),
      );
    }));
  }

  //返回一个listview
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        //如果是i是奇数，就添加一个分割线
        if (i.isOdd) return new Divider();
        //i除以2然后向下取整
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
    //是否已经保存
    final _alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      //添加心形
      trailing: new Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      //onTap是一个回调方法，在这里自己定义,()是一个匿名函数，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
      onTap: () {
        setState(() {
          if (_alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);
        });
      },
    );
  }
}
