import 'package:flutter/material.dart';
import 'package:fooddelivery/widget/ilabelWithIcon.dart';
import 'package:fooddelivery/widget/iline.dart';

class ICard1 extends StatelessWidget {
  final Color color;
  final String title;
  final TextStyle titleStyle;
  final String date;
  final TextStyle dateStyle;
  final String text;
  final TextStyle textStyle;
  final String userAvatar;
  final double rating;
  ICard1({this.color, this.text, this.textStyle, this.title, this.titleStyle,
    this.date, this.dateStyle, this.userAvatar, this.rating});

  @override
  Widget build(BuildContext context) {
    double _rating = 5.0;
    if (rating != null)
      _rating = rating;
    Color _color = Colors.grey;
    if (color != null)
      _color = color;
    var _text = "";
    if (text != null)
      _text = text;
    var _title = "";
    if (title != null)
      _title = title;
    var _date = "";
    if (date != null)
      _date = date;
    var _titleStyle = TextStyle(fontSize: 16);
    if (titleStyle != null)
      _titleStyle = titleStyle;
    var _textStyle = TextStyle(fontSize: 16);
    if (textStyle != null)
      _textStyle = textStyle;
    var _dateStyle = TextStyle(fontSize: 16);
    if (dateStyle != null)
      _dateStyle = dateStyle;

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
              child: CircleAvatar(backgroundImage: AssetImage(userAvatar), radius: 35),
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_title, style: _titleStyle,),
                  Row(
                    children: <Widget>[
                      UnconstrainedBox(
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/date.png",
                                  fit: BoxFit.contain
                              )
                          )),
                      SizedBox(width: 10,),
                      Text(_date, style: _dateStyle,),
                    ],
                  )
                ],
              ),
            ),

              ILabelIcon(text: _rating.toStringAsFixed(1), color: Colors.white, colorBackgroud: _color,
                icon: Icon(Icons.star_border, color: Colors.white,),),

            ],
          ),
          Text(_text, style: _textStyle,),
          ILine(),
        ],
      ),
    );
  }
}