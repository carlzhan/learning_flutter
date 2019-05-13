import 'package:flutter/material.dart';
class RouterDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
//      home: HomePage(), // 使用routes则改为initialRoute: '/',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new Home(),
        '/second': (BuildContext context) =>
        new SecondPage(Params('router (2)', 'subTitle (2)'))
      },
    );
  }
}

class Params {
  final title;
  final subTitle;

  Params(this.title, this.subTitle);
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Params params = new Params('value from home page', 'subTitle');
  String defaultValue = '第一种路由跳转方式';
  final List<Widget> _children = [HomeNavigator(), PlaceholderWidget('Tab2')];
  int _curChildren = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      // 该段body为HomePage的tab页面
      body: _children[_curChildren],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabSwitch,
          currentIndex: _curChildren,
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('My'),
              icon: Icon(Icons.person),
            )
          ]),
//      放开此段为路由跳转
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            RaisedButton(
//                child: Text(defaultValue),
//                onPressed: () async {
//                  String result = await Navigator.push(context,
//                      new MaterialPageRoute(
//                          builder: (context) => SecondPage(params)));
//                  if (result != null) {
//                    debugPrint(result + '_____');
//                    setState(() {
//                      defaultValue = result;
//                    });
//                  }
//                }),
//            RaisedButton(
//                child: Text('第二种路由跳转方式'),
//                onPressed: ()async {
//                  String result = await Navigator.of(context).pushNamed('/second');
//                })
//          ],
//        ),
//      ),
    );
  }

  void _onTabSwitch(int index) {
    debugPrint('$index+_________');
    setState(() {
      _curChildren = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final title;

  PlaceholderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}

class SecondPage extends StatelessWidget {
  final Params params;

  SecondPage(this.params);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
            child: Text(params.title),
            onPressed: () {
              Navigator.pop(context, 'value from second page');
            }),
      ),
    );
  }
}

/**
 * HomeNavigator 由Navigator组成
 */
class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Navigator(
      initialRoute: 'home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => new HomePage();
            break;
          case 'demo1':
            builder =
                (BuildContext context) => new SecondPage(Params('11', '22'));
            break;
          default:
            throw new Exception('Invalid route: ${settings.name}');
        }
        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tab1 home'),
      ),
      body: new Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Text('点我'),
                onTap: () => debugPrint('我被点了'),),
              new RaisedButton(
                child: new Text('Tab1 中的Home'),
                onPressed: () {
                  Navigator.of(context).pushNamed('demo1');
                },
              ),
            ],
          )
      ),
    );
  }
}
