import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final buildings = [
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),


  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
          body: Column(
            children: <Widget>[
              TopBanner(),
              _TitleSection('title', 'subtitle', '3'),
              _ButtonSection(),
              Expanded(
                child: BuildListView(),
              )
            ],
          )),
    );
  }
}

class _ButtonSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(context, Icons.call, 'CALL'),
          _buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Widget _buildButtonColumn(BuildContext context, IconData icon, String label) {
    final color = Colors.red;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color,),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color
            ),
          ),
        )
      ],
    );
  }

}

class _TitleSection extends StatelessWidget {
  final title;
  final subTitle;
  final startCount;

  _TitleSection(this.title, this.subTitle, this.startCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text(
              startCount.toString()
          )
        ],
      ),

    );
  }
}

class TopBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TopBannerState();
  }
}

class TopBannerState extends State<TopBanner> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/lake.jpg',
      height: 240.0,
      // cover 类似于 Android 开发中的 centerCrop，其他一些类型，读者可以查看 
      // https://docs.flutter.io/flutter/painting/BoxFit-class.html
      fit: BoxFit.cover,
    );
  }
}

enum BuildingType { theater, restaurant }

class Building {
  final BuildingType type;
  final String title;
  final String address;

  Building(this.type, this.title, this.address);
}

typedef OnItemClickListener = void Function(int position);

class ItemView extends StatelessWidget {
  final int position;
  final String title;
  final OnItemClickListener listener;

  ItemView(this.position, this.title, this.listener);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    );

    final widget = Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16.0),
          child: icon,
        ),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                title
            )
          ],
        ))
      ],
    );


    return InkWell(
      onTap: () => listener(position),
      child: widget,
    );
  }

}

class BuildListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
//    TODO
    return BuildListViewState((index) =>
        debugPrint('item $index clicked'));
  }

}


class BuildListViewState extends State<BuildListView> {
  List<int> items = List.generate(10, (i) => i);
  final OnItemClickListener listener;

  ScrollController _scrollController = new ScrollController();

// 产生数据
  bool isPerformingRequest = false; // 是否有请求正在进行

  BuildListViewState(this.listener);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _buildProgressIndicator();
        } else {
          return ItemView(index, "Title $index", listener);
        }
      },
      controller: _scrollController,

    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }


  /// 通过这个模拟http请求
  Future<List<int>> fakeRequest(int from, int to) async {
// 如果对Future不熟悉，可以参考 https://juejin.im/post/5b2c67a351882574a756f2eb
    return Future.delayed(Duration(seconds: 2), () {
      return List.generate(to - from, (i) => i + from);
    });
  }

  _getMoreData() async {
    if (!isPerformingRequest) { // 判断是否有请求正在执行
      setState(() => isPerformingRequest = true);
      List<int> newEntries = await fakeRequest(items.length, items.length);

      if (newEntries.isEmpty) {
        double edge = 50;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        items.addAll(newEntries);
        isPerformingRequest = false; // 下一个请求可以开始了
      });
    }
  }

}

