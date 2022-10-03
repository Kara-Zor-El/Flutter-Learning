import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final Uri _url = Uri.parse('https://exchangily.com/');

void main() {
  runApp(const eXchangilyAnouncements());
}

class eXchangilyAnouncements extends StatelessWidget {
  const eXchangilyAnouncements({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eXchangily Anouncements',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'eXchangily Anouncements'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ShortAnouncement> announcements = [];
  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  String bodyFixer(String body) {
    // regex to replace &amp; with &
    RegExp exp = RegExp(r"&amp;");
    body = body.replaceAll(exp, "&");
    // regex to replace &nbsp; with space
    exp = RegExp(r"&nbsp;");
    body = body.replaceAll(exp, " ");
    // regex to replace &quot; with "
    exp = RegExp(r"&quot;");
    body = body.replaceAll(exp, "\"");
    // regex to replace &lt; with <
    exp = RegExp(r"&lt;");
    body = body.replaceAll(exp, "<");
    // regex to replace &gt; with >
    exp = RegExp(r"&gt;");
    body = body.replaceAll(exp, ">");
    // regex to replace &apos; with '
    exp = RegExp(r"&apos;");
    body = body.replaceAll(exp, "'");
    // regex to replace &ndash; with -
    exp = RegExp(r"&ndash;");
    body = body.replaceAll(exp, "-");
    // regex to replace &mdash; with -
    exp = RegExp(r"&mdash;");
    body = body.replaceAll(exp, "-");
    // regex to replace &ge; with >=
    exp = RegExp(r"&ge;");
    body = body.replaceAll(exp, ">=");
    // regex to replace &le; with <=
    exp = RegExp(r"&le;");
    body = body.replaceAll(exp, "<=");
    // regex to replace &ldquo; with "
    exp = RegExp(r"&ldquo;");
    body = body.replaceAll(exp, "\"");
    // regex to replace &rdquo; with "
    exp = RegExp(r"&rdquo;");
    body = body.replaceAll(exp, "\"");
    // regex to replace &lsquo; with '
    exp = RegExp(r"&lsquo;");
    body = body.replaceAll(exp, "'");
    // regex to replace &rsquo; with '
    exp = RegExp(r"&rsquo;");
    body = body.replaceAll(exp, "'");
    // regex to replace &#39; with '
    exp = RegExp(r"&#39;");
    body = body.replaceAll(exp, "'");

    return body;
  }

  Future<void> _pullRefresh() async {
    announcements.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(),
      ),
    );
    getWebsiteData();
  }

  Future<void> _launchURL() async {
    if (canLaunchUrl(_url) == true) {
      await launchUrl(_url);
    } else {
      snackBar("Could not open website");
      throw 'Could not launch $_url';
    }
  }

  void snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future getWebsiteData() async {
    final url = Uri.parse(
        'https://api.blockchaingate.com/v2/announcements/language/en');
    final response = await http.get(url);

    var data = json.decode(response.body);
    var parsedJson = Announcements.fromJson(data);
    var body = parsedJson.body;

    announcements = List.generate(body!.length, (index) {
      return ShortAnouncement(
        title: body[index].title,
        subtitle: body[index].subtitle,
        dateCreated: body[index].dateCreated,
        content: removeHtmlTags(bodyFixer(body[index].content.toString())),
      );
    });
    announcements.removeAt(0);

    setState(() {});
    print(announcements.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _launchURL();
              },
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ),
            Text(widget.title),
            Container(
              padding: EdgeInsets.all(0),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  splashRadius: 2,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.refresh),
                  iconSize: 18,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      announcements.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(),
                        ),
                      );
                      getWebsiteData();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // for the listview, have a scrollbar at the side
      body: RawScrollbar(
        thumbVisibility: true,
        thumbColor: Colors.pink,
        radius: Radius.circular(8),
        thickness: 5,
        trackColor: Colors.grey[900],
        trackVisibility: true,
        trackRadius: Radius.circular(8),
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: _pullRefresh,
            color: Colors.pink,
            backgroundColor: Colors.grey[800],
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(8, 12, 12, 0),
              physics: BouncingScrollPhysics(),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final item = announcements[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: Colors.grey[800],
                      title: item.title != null
                          ? Text(
                              item.title.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(""),
                      subtitle: item.subtitle != null
                          ? Text(item.subtitle.toString())
                          : null,
                      trailing: Text(item.dateCreated.toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AnnouncementPage(
                              title: item.title.toString(),
                              subtitle: item.subtitle.toString(),
                              dateCreated: item.dateCreated.toString(),
                              content: item.content.toString(),
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
                // decorations
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: Colors.pink,
                size: 75.0,
              ),
              SizedBox(height: 20),
              Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.dateCreated,
      required this.content});

  final String title;
  final String subtitle;
  final String dateCreated;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RawScrollbar(
        thumbVisibility: true,
        thumbColor: Colors.pink,
        radius: Radius.circular(8),
        thickness: 5,
        trackColor: Colors.grey[900],
        trackVisibility: true,
        trackRadius: Radius.circular(8),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                subtitle != "null"
                    ? AutoSizeText(
                        subtitle,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  dateCreated,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    text: content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                    children: <TextSpan>[],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Announcements {
  bool? success;
  List<Body>? body;

  Announcements({this.success, this.body});

  Announcements.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Body {
  String? lanCode;
  bool? headline;
  String? sId;
  bool? urgent;
  bool? active;
  String? content;
  String? category;
  String? title;
  String? createdBy;
  String? appId;
  String? dateCreated;
  int? iV;
  String? subtitle;

  Body(
      {this.lanCode,
      this.headline,
      this.sId,
      this.urgent,
      this.active,
      this.content,
      this.category,
      this.title,
      this.createdBy,
      this.appId,
      this.dateCreated,
      this.iV,
      this.subtitle});

  Body.fromJson(Map<String, dynamic> json) {
    lanCode = json['lanCode'];
    headline = json['headline'];
    sId = json['_id'];
    urgent = json['urgent'];
    active = json['active'];
    content = json['content'];
    category = json['category'];
    title = json['title'];
    createdBy = json['createdBy'];
    appId = json['appId'];
    dateCreated = json['dateCreated'].toString().substring(0, 10);
    iV = json['__v'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lanCode'] = this.lanCode;
    data['headline'] = this.headline;
    data['_id'] = this.sId;
    data['urgent'] = this.urgent;
    data['active'] = this.active;
    data['content'] = this.content;
    data['category'] = this.category;
    data['title'] = this.title;
    data['createdBy'] = this.createdBy;
    data['appId'] = this.appId;
    data['dateCreated'] = this.dateCreated;
    data['__v'] = this.iV;
    data['subtitle'] = this.subtitle;
    return data;
  }
}

class ShortAnouncement {
  final String? title;
  final String? subtitle;
  final String? dateCreated;
  final String? content;

  const ShortAnouncement(
      {required this.title,
      this.subtitle,
      required this.dateCreated,
      required this.content});
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
