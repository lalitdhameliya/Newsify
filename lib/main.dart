import 'package:flutter/material.dart';
import 'package:newsify/ApiServices.dart';
import 'package:newsify/NewsDetailScreen.dart';
import 'package:newsify/models/ArticleResponse.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newsify',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Newsify'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<ArticleResponse> articleResponse;

  @override
  void initState() {
    super.initState();
    articleResponse = ApiServices().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<ArticleResponse>(
            future: articleResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.status == "ok") {
                  return _buildNewsFeed(snapshot.data.articles);
                }
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Widget _buildNewsFeed(List<Articles> articles) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, position) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                        article: articles[position],
                      ),
                ),
              );
            },
            child: Container(
              height: 100,
              child: Card(
                margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: articles[position].urlToImage,
                      child: Image.network(
                        articles[position].urlToImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 2),
                      width: MediaQuery.of(context).size.width * 0.67,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            articles[position].title,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
//                        Text(articles[position].content),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
//          ListTile(
//            title: Text(articles[position].title),
//          );
        });
  }
}
