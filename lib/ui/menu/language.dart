import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/ui/main/header.dart';

class LanguageScreen extends StatefulWidget {
  final Function callback;
  LanguageScreen({Key key, this.callback}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> with SingleTickerProviderStateMixin{

  ///////////////////////////////////////////////////////////////////////////////
  //

  //
  ///////////////////////////////////////////////////////////////////////////////
  double windowWidth = 0.0;
  double windowHeight = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    route.disposeLast();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorBackground,
        body: Stack(
          children: <Widget>[

            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Header(title: strings.get(62), nomenu: true,) // "Language",
            ),

            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+30),
              child: _body(),
            )

          ],
        )
    );
  }

  _body(){
    return ListView(
      children: _body2(),
    );
  }


  _body2(){
    var list = List<Widget>();
    list.add(Container(
      color: theme.colorBackgroundDialog,
      child: ListTile(
        leading: UnconstrainedBox(
      child: Container(
      height: 35,
          width: 35,
          child: Image.asset("assets/lang.png",
              fit: BoxFit.contain,
          ))),
        title: Text(strings.get(63), style: theme.text20bold,),  // "App Language",
      ),
    ));

    list.add(SizedBox(height: 15,));

    for (var _data in strings.langData) {
      var _width = 0.0;
      var _height = 0.0;
      if (_data.current) {
        _width = 30;
        _height = 30;
      }
      list.add(
          Container(
            margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: theme.colorBackgroundDialog,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),

              child: InkWell(
              onTap: () {
                setState(() {
                  strings.setLang(_data.id);
                  widget.callback("redraw");
                });
              },
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage(_data.image), radius: 20,),
                  title: Text(_data.name, style: theme.text16bold,),
                  subtitle: Text(_data.engName, style: theme.text14,),
                  trailing: AnimatedContainer(
                    width: _width,
                    height: _height,
                    duration: Duration(milliseconds: 400),
                    child:
                    CircleAvatar(backgroundImage: AssetImage("assets/iconok.png"), radius: 15),
                  ),

                )
          ))
      );
    }
    return list;
  }

}

