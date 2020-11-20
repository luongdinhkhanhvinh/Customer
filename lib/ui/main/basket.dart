import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/basket.dart';
import 'package:fooddelivery/model/dishes.dart';
import 'package:fooddelivery/ui/main/header.dart';
import 'package:fooddelivery/widget/buttonBorder.dart';
import 'package:fooddelivery/widget/icard9a.dart';
import 'package:fooddelivery/widget/ilist1.dart';

class BasketScreen extends StatefulWidget {
  final String title;
  final Function onMenuClick;
  BasketScreen({Key key, this.title, this.onMenuClick}) : super(key: key);
  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> with TickerProviderStateMixin{

  ///////////////////////////////////////////////////////////////////////////////
  //
  // Increment and Decrement
  //
  _onItemChangeCount(String id, int value){
    print("Increment item. id: $id, new value: $value");
    setState(() {
      for (var d in basket)
        if (d.id == id)
          d.count = value;
    });
  }

  _pressCheckoutButton(){
    print("User pressed Checkout");
    route.push(context, "/delivery");
  }

  //
  //
  //
  ///////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;

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
        body: Container(
        color: theme.colorBackground,
        child: Stack(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(left: 0, right: 0, top: MediaQuery.of(context).padding.top+40),
            child: ListView(
              children: _getDataActive(),
            ),
          ),

          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Header(title: strings.get(98), nomenu: true,) // Basket
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: theme.colorBackground,
                borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),


              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _bottomBar()
              ),
            ),
          ),

        ],
      ),

    ));
  }

  List<Widget> _bottomBar(){
    var list = List<Widget>();
    double _total = 0;
    for (var item in basket)
      _total += (item.price*item.count);

    list.add(_itemText(strings.get(93), "\$${_total.toStringAsFixed(2)}", false));  // "Subtotal",
    list.add(SizedBox(height: 5,));
    list.add(_itemText(strings.get(94), "\$30", false));                            // "Shopping costs",
    list.add(SizedBox(height: 5,));
    var _taxes = _total*0.25;
    list.add(_itemText(strings.get(95), "\$${_taxes.toStringAsFixed(2)}", false));  // "Taxes",
    list.add(SizedBox(height: 5,));
    _total += _taxes + 30;
    list.add(_itemText(strings.get(96), "\$${_total.toStringAsFixed(2)}", true));  // "Total",
    list.add(SizedBox(height: 15,));
    list.add(Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: IButtonBorder(text: strings.get(97),
        color: theme.colorPrimary, pressButton: _pressCheckoutButton,             // Checkout
      ),
    ));
    list.add(SizedBox(height: 15,));
    return list;
  }

  List<Widget> _getDataActive(){
    var list = List<Widget>();

    list.add(Container(
      margin: EdgeInsets.only(left: 15),
      child: IList1(imageAsset: "assets/shop.png", text: strings.get(99), textStyle: theme.text16bold,), // "Shopping Cart",
    ));
    list.add(Container(
      margin: EdgeInsets.only(left: 50),
      child: Text(strings.get(100), style: theme.text14,), // "Verify your quantity and click checkout",
    ));
    list.add(SizedBox(height: 20,));

    for (var item in basket)
      list.add(_item(item));

    list.add(SizedBox(height: 200,));
    return list;
  }

  _itemText(String leftText, String rightText, bool bold){
    var _style = theme.text14;
    if (bold)
      _style = theme.text14bold;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(leftText, style: _style,),
          ),
          Text(rightText, style: _style,),
        ],
      ),
    );
  }

  _item(Dishes item){
    return ICard9a(
      color: theme.colorBackgroundDialog,
      width: windowWidth,
      height: 100,
      colorArrows: theme.colorDefaultText,
      title1: item.text, title1Style: theme.text16bold,
      title2Style: theme.text18bold,
      price: "${item.currency}${item.price.toStringAsFixed(2)}", priceTitleStyle: theme.text20boldPrimary,
      image: item.image,
      incDec: _onItemChangeCount,
      heroTag: item.id,
      count: item.count,
    );
  }


}

