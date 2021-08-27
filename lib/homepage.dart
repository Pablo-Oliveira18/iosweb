import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'check_internet.dart';
import 'webview/example2.dart';
import 'webview/example3.dart';
import 'webview/example4.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final WebExampleThree inAppBrowser = WebExampleThree();
  final WebExampleFour inAppChrome = WebExampleFour();
  String _url = "https://www.avanteweb.com.br/sistema/";
  int checkInt = 0;

  var options = InAppBrowserClassOptions(
      crossPlatform:
          InAppBrowserOptions(toolbarTopBackgroundColor: Color(0xff2c6eff)),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          cacheEnabled: true,
          transparentBackground: true,
        ),
      ));

  @override
  void initState() {
    super.initState();
    Future<int> a = CheckInternet().checkInternetConnection();
    a.then((value) {
      if (value == 0) {
        setState(() {
          checkInt = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sem conexão com a internet!'),
        ));
      } else {
        setState(() {
          checkInt = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Internet conectada'),
        ));
      }
    });
    inAppChrome.addMenuItem(ChromeSafariBrowserMenuItem(
      id: 1,
      label: 'Example 1',
      action: (title, url) {
        print(title);
        print(url);
      },
    ));
    inAppChrome.addMenuItem(ChromeSafariBrowserMenuItem(
      id: 2,
      label: 'Example 2',
      action: (title, url) {
        print(title);
        print(url);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WebExampleTwo(url: _url);
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
