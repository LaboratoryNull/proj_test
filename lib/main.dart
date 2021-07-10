import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
 // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(AppMainClass());
}

//Base class
class AppMainClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TestProj",
        theme: ThemeData(
          primarySwatch: Colors.deepOrange
        ),
        home: AppMainPage()
      );
  }
}

class AppMainPage extends StatefulWidget{
  AppMainPage({Key? key}) : super(key: key);
  @override
  _AppMainPage createState() => _AppMainPage();
}

class _AppMainPage extends State<AppMainPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text("Text")
        ),
        body: ListView(children: _getListData()),
     );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];

    for (int i = 0; i < 10; i++) {
      widgets.add(
        Card_create("title", "subtitle", i)
      );
    }

    return widgets;
  }

  Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    final url = 'https://sun9-78.userapi.com/impf/c840726/v840726292/4ef35/1CG1yazYMAA.jpg?size=2560x1707&quality=96&sign=9956622bad99091b3db20d684107090a&type=album';
    final image = NetworkImage(url);
    //
    final load = image.resolve(const ImageConfiguration());

    // Delay 1 second.
    await Future.delayed(Duration(seconds: 1));

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
      print(info.image.width);
      print(info.image.height);
      completer.complete(Container(child: Image(image: image)));
    });

    load.addListener(listener);
    return completer.future;
  }

  Widget Card_create(String title, String subtitle, int count){
    return  Container(
            margin: EdgeInsets.all(10) ,
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.place),
                        title: Text('Ha Long Bay'),
                        subtitle: Text('Halong Bay is a UNESCO World Heritage Site and a popular tourist destination'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: FutureBuilder<Widget>(
                          future: getImage(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.requireData;
                            } else {
                              return Text('LOADING...');
                            }
                          },
                        ),
                      ) ,
                      ButtonBarTheme ( // make buttons use the appropriate styles for cards
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: const Text('Add to Bookmark'),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: const Text('Show More'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  elevation: 10,
                ),
              ],
        )
    );
  }


}