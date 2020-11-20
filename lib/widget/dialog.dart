import 'package:flutter/material.dart';

class DialogScreen extends StatefulWidget {
  final double width; // dialog width in percent of Window width (default 80%)
  final Widget body;
  final Widget title;
  final bool stars;
  final Function(int) starsCallback;
  final Function tapBackground;
  final AlignmentGeometry align;
  final Color backgroundColor;
  DialogScreen({this.body, this.title, this.backgroundColor, this.width, this.align, this.tapBackground, this.stars, this.starsCallback});

  @override
  _DialogScreenState createState() {
    return _DialogScreenState();
  }
}

class _DialogScreenState extends State<DialogScreen> {

  double windowWidth = 0.0;
  double windowHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    double dd = 80;

    if (widget.width != null)
      dd = widget.width;
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    var _radiusBorder = BorderRadius.circular(10);
    if (widget.align == Alignment.bottomCenter)
      _radiusBorder = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
              GestureDetector(
              behavior: HitTestBehavior.translucent,
                onTap: () {
                  widget.tapBackground();
                },
                child: Container(
                    color: Color.fromARGB(200, 0, 0, 0),
                  )),
            Align(
                alignment: widget.align,
                child: Material(
                    color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                      width: windowWidth*dd/100,
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius: _radiusBorder,
                      ),
                      child: Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                        widget.title,
                          _starsBuild(),
                        widget.body,

                        ],

                      ),
                    ))

            )),
          ],
        )

    );
  }

  _starsBuild(){
    if (widget.stars){
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _stars(),
        ),
      );
    }else
      return Container();
  }

  int stars = 5;

  List<Widget> _stars(){
    var list = List<Widget>();

    if (stars >= 1) list.add(_good(1)); else list.add(_bad(1));
    if (stars >= 2) list.add(_good(2)); else list.add(_bad(2));
    if (stars >= 3) list.add(_good(3)); else list.add(_bad(3));
    if (stars >= 4) list.add(_good(4)); else list.add(_bad(4));
    if (stars >= 5) list.add(_good(5)); else list.add(_bad(5));

    return list;
  }


  _good(int pos){
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            stars = pos;
          });
          if (widget.starsCallback != null)
            widget.starsCallback(stars);
        },
        child: Icon(Icons.star, color: Colors.orangeAccent, size: 40));
  }

  _bad(int pos){
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            stars = pos;
          });
          if (widget.starsCallback != null)
            widget.starsCallback(stars);
        },
        child: Icon(Icons.star_border, color: Colors.orangeAccent, size: 40)
    );
  }
}

class EasyDialog{
  String title;
  String title2;
  bool titleLine;
  Icon titleIcon;
  Widget titleWidget;
  Color colorTitle;
  bool bodyLine;
  Color colorBackground;
  Color colorTitleText;
  String text;
  Widget body;
  String okText;
  TextStyle okTextStyle;
  Color okColor;
  double indent;
  Function callbackPressOk;
  bool okButtonText;
  String cancelText;
  Color cancelColor;
  TextStyle cancelTextStyle;
  Function callbackPressCancel;
  bool cancelButtonText;
  bool alignBottom;
  bool closeOnBackgroundTap;
  bool stars;
  Function(int) starsCallback;

  EasyDialog({this.title, this.title2, this.colorBackground, this.text, this.okText, this.okColor, this.callbackPressOk, this.indent,
  this.body, this.titleLine, this.bodyLine, this.titleWidget, this.colorTitle, this.okButtonText, this.cancelText, this.cancelColor,
  this.callbackPressCancel, this.cancelButtonText, this.alignBottom, this.colorTitleText, this.titleIcon, this.okTextStyle,
    this.cancelTextStyle, this.closeOnBackgroundTap, this.stars, this.starsCallback});

  /////////////////////////////////////////
  double _indent = 20;
  Color _backgroundColor = Colors.white;
  Widget _title = Container();
  Widget _body = Container();
  bool _line1 = true;
  bool _line2 = false;
  DialogScreen _dialog;
  bool _stars = false;

  withTitle(String title){
    var _color = _backgroundColor;
    if (colorTitle != null)
      _color = colorTitle;
    _color = getTextColor(_color);
    if (colorTitleText != null)
      _color = colorTitleText;
    _title = Text(title,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: _color,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
  }

  withTitle2(String title, String title2){
    var _color = _backgroundColor;
    if (colorTitle != null)
      _color = colorTitle;
    _color = getTextColor(_color);
    if (colorTitleText != null)
      _color = colorTitleText;
    _title = Column(
      children: <Widget>[
          Text(title,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _color,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w800,
            fontSize: 18,
            )
          ),
          SizedBox(height: 10,),
          Text(title2,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _color,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),

      ],
    );
  }

  _withTextBody(String text){
    _body = Text(text,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: getTextColor(_backgroundColor),
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
  }

  show(BuildContext context){
    //
    //
    //
    if (indent != null)
      _indent = indent;
    if (stars != null)
      _stars = stars;
    if (colorBackground != null)
      _backgroundColor = colorBackground;

    //
    // title
    //
    var _noTitle = false;
    if (titleWidget != null){
      _title = titleWidget;
    }else {
      if (title != null && title2 != null && title.isNotEmpty &&
          title2.isNotEmpty)
        withTitle2(title, title2);
      else {
        if (title != null && title.isNotEmpty)
          withTitle(title);
        else
          _noTitle = true;
      }
    }
    var _titleColor = _backgroundColor;
    if (titleLine != null)
      _line1 = titleLine;
    if (colorTitle != null)
      _titleColor = colorTitle;

    if (titleIcon != null){
      _title = Column(
        children: <Widget>[
          titleIcon,
          SizedBox(height: 10,),
          _title,
        ],
      );
    }

    //
    // body
    //
    if (body != null)
      _body = body;
    else {
      if (text != null && text.isNotEmpty)
        _withTextBody(text);
    }
    if (bodyLine != null)
      _line2 = bodyLine;

    //
    // button ok
    //
    var _textstyle = TextStyle(
      color: getTextColor(_backgroundColor),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    if (okTextStyle != null)
      _textstyle = okTextStyle;

    Widget _buttonOK = Container();
    bool _buttonOKPresent = false;
    if (okText != null && okText.isNotEmpty) {
      _buttonOKPresent = true;
      _buttonOK = RaisedButton(
        color: okColor,
        onPressed: () {
          Navigator.pop(context);
          if (callbackPressOk != null)
            callbackPressOk();
        },
        child: Text(okText,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          style: _textstyle,
        ),
      );
    }
    if (okButtonText != null) {
      _buttonOKPresent = true;
      _buttonOK = InkWell(
          onTap: () {
            Navigator.pop(context);
            if (callbackPressOk != null)
              callbackPressOk();
          }, // needed
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(okText,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: okColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          )
      );
    }

    //
    // button cancel
    //
    var _textstyle2 = TextStyle(
      color: getTextColor(_backgroundColor),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    if (cancelTextStyle != null)
      _textstyle = cancelTextStyle;
    bool _buttonCancelPresent = false;
    Widget _buttonCancel = Container(width: 1,);
    if (cancelText != null && cancelText.isNotEmpty) {
      _buttonCancelPresent = true;
      _buttonCancel = RaisedButton(
        color: cancelColor,
        onPressed: () {
          Navigator.pop(context);
          if (callbackPressCancel != null)
            callbackPressCancel();
        },
        child: Text(cancelText,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          style: _textstyle2,
        ),
      );
    }
    if (cancelButtonText != null && cancelButtonText && cancelText != null) {
      _buttonCancelPresent = true;
      _buttonCancel = InkWell(
          onTap: () {
            Navigator.pop(context);
            if (callbackPressCancel != null)
              callbackPressCancel();
          }, // needed
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(cancelText,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cancelColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          )
      );
    }

    List<Widget> _t = [];
    if (_buttonCancelPresent)
      _t.add(_buttonCancel);
    if (_buttonOKPresent)
      _t.add(_buttonOK);
    var _buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _t,
    );

    var _titleBuild = Container();
    if (!_noTitle) {
      _titleBuild = Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _titleColor,
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.all(_indent),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: _indent/2,),
                    _title,
                    //SizedBox(height: _indent/2,),
                    if (_line1) (SizedBox(height: _indent/2,)),
                    if (_line1) (Container(height: 0.5, color: getTextColor(_backgroundColor))),

                  ],
                ),
              ),
            ],
          ));
    }

    var _bodyBuild = Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_indent),
          child:Column(
          children: <Widget>[
            _body,
            SizedBox(height: _indent,),
            SizedBox(height: _indent,),
            if (_line2) (Container(height: 0.5, color: getTextColor(_backgroundColor))),
            SizedBox(height: _indent/2,),
            _buttons,
          ],
        )),

      ],
    ));

    var _align = Alignment.center;
    if (alignBottom != null && alignBottom)
      _align = Alignment.bottomCenter;

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) {
            _dialog = DialogScreen(body: _bodyBuild,
                title: _titleBuild,
                align: _align,
                backgroundColor: _backgroundColor,
                stars: _stars,
                starsCallback: starsCallback,
                tapBackground: () {
                  if (closeOnBackgroundTap != null && closeOnBackgroundTap)
                    Navigator.pop(context);
                });

            return _dialog;
          }, // open brand details screen
        ),
      );
    return this;
  }

  simpleDialog2(BuildContext context, Widget w, Color backgroundColor){
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => DialogScreen(body: w, backgroundColor: backgroundColor, stars: _stars,
          starsCallback: starsCallback,),      // open brand details screen
      ),
    );
  }

  Color getTextColor(Color color) {
    int d = 0;

    // Counting the perceptive luminance - human eye favors green color...
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(color.alpha, d, d, d);
  }

}

