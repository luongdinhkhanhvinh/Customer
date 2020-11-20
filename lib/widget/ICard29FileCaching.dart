import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ICard29FileCaching extends StatelessWidget {
  final String id;
  final Color color;
  final String title;
  final Color colorProgressBar;
  final TextStyle titleStyle;
  final String text;
  final TextStyle textStyle;
  final String userAvatar;
  final String date;
  final TextStyle dateStyle;

  final Color balloonColor;
  final Function(String) callback;

  ICard29FileCaching({this.id, this.color = Colors.grey, this.text = "", this.textStyle, this.title = "", this.titleStyle,  this.colorProgressBar = Colors.black,
    this.userAvatar, this.balloonColor = Colors.black,
    this.callback, this.date, this.dateStyle
  });

  @override
  Widget build(BuildContext context) {
    var _titleStyle = TextStyle(fontSize: 16);
    if (titleStyle != null)
      _titleStyle = titleStyle;
    var _textStyle = TextStyle(fontSize: 16);
    if (textStyle != null)
      _textStyle = textStyle;
    var _dateStyle = TextStyle(fontSize: 16);
    if (dateStyle != null)
      _dateStyle = dateStyle;

    var _avatar = Container();
    try {
      _avatar = Container(
        width: 40,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  CircularProgressIndicator(backgroundColor: colorProgressBar,),
              imageUrl: userAvatar,
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
      );
    } catch(_){

    }

    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10),
            color: color,
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _avatar,
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 60),
                              child: Row (
                                children: [
                                  Expanded(child: Text(title, style: _titleStyle, overflow: TextOverflow.ellipsis,)),
                                  Text(date, style: _dateStyle,),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(text, style: _textStyle, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,),
                          ]
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            )),


        Positioned.fill(
            child: Container(
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: balloonColor.withOpacity(0.2),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(right: 10, top: 10),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                    child: Icon(Icons.delete, size: 25, color: balloonColor.withOpacity(0.8)), //Text(balloonText, style: _balloonStyle,),
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      child: Container(
                      child: Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.grey[400],
                          onTap: (){
                            if (callback != null)
                              callback(id);
                          }, // needed
                        )),)
                  )
                ],
              )
            )),

      ],
    );
  }
}