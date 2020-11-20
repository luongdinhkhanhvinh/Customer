import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/promotion.dart';
import 'package:fooddelivery/widget/buttonBorder.dart';
import 'package:fooddelivery/widget/ibox.dart';

class IPromotion extends StatefulWidget {
  final List<Promotion> dataPromotion;
  final double width;
  final double height;
  final Color colorGrey;
  final Color colorActivy;
  final TextStyle style;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final Function(int) pressButton;
  final int seconds;
  IPromotion(this.dataPromotion, {this.width, this.height, this.colorGrey, this.colorActivy, this.style,
    this.buttonText, this.buttonTextStyle, this.pressButton, this.seconds});

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<IPromotion> {

  int realCountPaget = 0;
  var t = 0;
  var _currentPage = 1000;
  var _width = 100.0;
  var _height = 100.0;
  Color _colorActivy = Colors.black;
  Color _colorGrey = Color.fromARGB(255, 180, 180, 180);
  var _seconds = 3;

  Timer _timer;
  void startTimer() {
    _timer = new Timer.periodic(Duration(seconds: _seconds),
          (Timer timer) {
              int _page = _currentPage+1;
              _controller.animateToPage(_page, duration: Duration(seconds: 1), curve: Curves.ease);
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.seconds != null)
      _seconds = widget.seconds;
    realCountPaget = widget.dataPromotion.length;
    if (widget.width != null)
      _width = widget.width;
    if (widget.height != null)
      _height = widget.height;
    startTimer();
    super.initState();
  }

  _getT(int itemIndex){
    if (itemIndex > 1000){
      t = itemIndex-1000;
      while(t >= realCountPaget){
        t -= realCountPaget;
      }
    }
    if (itemIndex < 1000){
      t = 1000-itemIndex;
      var r = realCountPaget;
      do{
        if (r == 0)
          r = realCountPaget;
        r--;
        t--;
      }while(t > 0);
      t = r;
    }
  }

  var _controller = PageController(initialPage: 1000, keepPage: false, viewportFraction: 1);

  _promotion(){
    return Stack(
      children: <Widget>[
        Container(height: _height,
          child: PageView.builder(
            itemCount: 10000,
            onPageChanged: (int page){
              _getT(page);
              setState(() {
              });
              _currentPage = page;
            },
            controller: _controller,
            itemBuilder: (BuildContext context, int itemIndex) {
              _getT(itemIndex);
              if (t < 0 || t > realCountPaget)
                return Container();
              var item = dataPromotion[t];
              return Container(
                padding: EdgeInsets.all(10),
                width: _width, height: _height,
                child: IBox(child: _sale2(item, t)),
              );
            },
          ),
        ),

        Container(
            height: _height,
            child:Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    margin: EdgeInsets.only(bottom: 25, right: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _lines(),

                    )
                )
            )),
      ],
    );
  }

  _sale2(Promotion item, int index){
    Widget _text = Container();
    var _style = TextStyle(fontSize: 20);
    if (widget.style != null)
      _style = widget.style;
    if (widget.dataPromotion[index].text != null)
      _text = Text(widget.dataPromotion[index].text,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.right,
          style: _style);

    Widget _button = Container();
    var _styleButton = TextStyle(fontSize: 20);
    if (widget.buttonTextStyle != null)
      _styleButton = widget.buttonTextStyle;
    if (widget.buttonText != null)
      _button = IButtonBorder(text: widget.buttonText, color: Colors.white, colorBackgroud: _colorActivy,
          border: false, textStyle: _styleButton, pressButtonWithId: widget.pressButton, id: item.id);

    return Stack(
      children: <Widget>[
        Container(
          width: _width+15,
          height: _height,
          child: Image.asset(item.image, fit: BoxFit.cover),
        ),

        Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.only(left: _width*0.4, top: 20, right: 20, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _text,
                    Container(
                      width: _width*0.45,
                      child: _button,
                    )

                  ],
                )
            )
        ),

    ],
    );
  }

  _lines(){
    List<Widget> lines = List<Widget>();
    for (int i = 0; i < realCountPaget; i++){
      if (i == t)
        lines.add(Container(width: 15, height: 3,
          decoration: BoxDecoration(
            color: _colorActivy,
            border: Border.all(color: _colorActivy),
            borderRadius: new BorderRadius.circular(10),
          ),
        ));
      else
        lines.add(Container(width: 15, height: 3,
          decoration: BoxDecoration(
            color: _colorGrey,
            border: Border.all(color: _colorGrey),
            borderRadius: new BorderRadius.circular(10),
          ),
        ));
      lines.add(SizedBox(width: 5,),);
    }

    return lines;
  }

  @override
  Widget build(BuildContext context) {


    if (widget.colorActivy != null)
      _colorActivy = widget.colorActivy;

    if (widget.colorGrey != null)
      _colorGrey = widget.colorGrey;

    return _promotion();
  }
}