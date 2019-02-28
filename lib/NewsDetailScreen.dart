import 'package:flutter/material.dart';
import 'package:newsify/models/ArticleResponse.dart';

class NewsDetailScreen extends StatefulWidget {
  Articles article;

  NewsDetailScreen({Key key, @required this.article}) : super(key: key);

  @override
  NewsDetailScreenState createState() => NewsDetailScreenState(article);
}

class NewsDetailScreenState extends State<NewsDetailScreen> {
  Articles article;
  Animation animation;
  AnimationController animationController;

  NewsDetailScreenState(Articles article) {
    this.article = article;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: article.urlToImage,
                  child: Image.network(
                    article.urlToImage,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        article.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${article.publishedAt} by ",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              article.author,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          article.content,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 8, top: 36),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.keyboard_backspace,
                    size: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
