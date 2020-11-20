import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/ui/main/header.dart';
import 'package:fooddelivery/widget/ibackground3.dart';

class TermOfServiceScreen extends StatefulWidget {
  final Function(int) openCategory;
  TermOfServiceScreen({Key key, this.openCategory}) : super(key: key);
  TermOfServiceScreenState createState() => TermOfServiceScreenState();
}

class TermOfServiceScreenState extends State<TermOfServiceScreen>  {
  double windowWidth = 0.0;
  double windowHeight = 0.0;
  String _textData =
  """
        <div>
          <h1>TERMS OF SERVICE - IN HTML FORMAT</h1>
          <p>We know it’s tempting to skip these Terms of Service, but it’s important to establish what you can expect from us as you use Google services, and what we expect from you.</p>
        </div>
      """;

  @override
  void dispose() {
    route.disposeLast();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: theme.colorBackground,
        body: Stack(
            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(top: topPadding),
                  width: windowWidth,
                  height: windowHeight*0.3,
                  child: IBackground4(width: windowWidth, colorsGradient: theme.colorsGradient)
              ),

              Container(
                margin: EdgeInsets.only(top: windowHeight*0.3+40+topPadding, left: 20, right: 20),
                  width: windowWidth,
                  height: windowHeight*0.7,
                  child: Html(
                    data: _textData,
                  ),
              ),

              Container(
                  margin: EdgeInsets.only(top: topPadding),
                  height: 40,
                  child: Header(nomenu: true, transparent: true, white: true,)),

                ]

            ));
  }
}