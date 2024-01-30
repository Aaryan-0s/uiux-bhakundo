import 'package:flutter/material.dart';
import 'dart:convert';





class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future<List<NewsItem>> _newsItems;

  @override
  void initState() {
    super.initState();
    _newsItems = fetchNewsData();
  }

  Future<List<NewsItem>> fetchNewsData() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/news_data.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> articles = jsonData['articles'];
    return articles.map((item) => NewsItem.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: _newsItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available.'));
          } else {
            return NewsList(newsList: snapshot.data!);
          }
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String author;

  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.author,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      author: json['author'] ?? '',
    );
  }
}

class NewsList extends StatelessWidget {
  final List<NewsItem> newsList;
  final int maxTitleWords = 10;

  const NewsList({Key? key, required this.newsList}) : super(key: key);

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= maxTitleWords) {
      return title;
    } else {
      return words.take(maxTitleWords).join(' ') + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (BuildContext context, int index) {
        String truncatedTitle = truncateTitle(newsList[index].title);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailsPage(newsItem: newsList[index]),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: HoverContainer(
              height: 100,
              color: Colors.grey[200]!,
              hoverColor: Colors.grey[300]!,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: newsList[index].imageUrl.isNotEmpty
                        ? Image.network(
                      newsList[index].imageUrl,
                      fit: BoxFit.cover,
                    )
                        : Icon(Icons.image, size: 50),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          truncatedTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Author: ${newsList[index].author}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewsDetailsPage extends StatelessWidget {
  final NewsItem newsItem;

  const NewsDetailsPage({Key? key, required this.newsItem}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              newsItem.imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 340.0, 0.0, 0.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 3,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Text(
                         newsItem.title,
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: const Color.fromARGB(255, 42, 33, 33).withOpacity(0.1),
                        label: Text(
                          "Not available",
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          newsItem.description,
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          newsItem.description,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Chip(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          label: Text(
                            "Author : ${newsItem.author}",
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(16),
                        elevation: 20,
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            InkWell(
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.black12.withOpacity(0.3),
                                    BlendMode.srcOver),
                                child: Image.network(
                                  newsItem.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              
                            ),
                            const Text(
                              "News Source",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverContainer extends StatefulWidget {
  final Widget child;
  final double height;
  final Color color;
  final Color hoverColor;

  const HoverContainer({
    Key? key,
    required this.child,
    required this.height,
    required this.color,
    required this.hoverColor,
  }) : super(key: key);

  @override
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hovered(true),
      onExit: (_) => _hovered(false),
      child: Container(
        height: widget.height,
        color: _isHovered ? widget.hoverColor : widget.color,
        child: widget.child,
      ),
    );
  }

  void _hovered(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}


