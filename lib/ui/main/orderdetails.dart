import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/orders.dart';
import 'package:fooddelivery/ui/main/header.dart';
import 'package:fooddelivery/ui/main/home.dart';
import 'package:fooddelivery/widget/icard14.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({Key key}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  double windowWidth = 0.0;
  double windowHeight = 0.0;

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
                child: Header(title: strings.get(119), nomenu: true,) // "My Orders",
            ),

            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: MediaQuery.of(context).padding.top+30),
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: _body(),
                ),
              ),
            )

          ],
        )
    );
  }

  _body(){
    var list = List<Widget>();
    var height = windowWidth*0.3;

    list.add(SizedBox(height: 20,));

    for (var item in orders)
      if (item.id == idOrder)
    list.add(Container(
        margin: EdgeInsets.only(right: 10),
        child: ICard14(
          heroId: idHeroes,
          color: theme.colorBackground,
          text: item.name,
          textStyle: theme.text16bold,
          text2: item.restaurant,
          textStyle2: theme.text14,
          text3: item.date,
          textStyle3: theme.text14,
          text4: item.total,
          textStyle4: theme.text18boldPrimary,
          width: windowWidth,
          height: height,
          image: item.image,
          id: item.id,
        )));


    list.add(SizedBox(height: 35,));

    list.add(_itemTextPastOrder("${strings.get(120)}", " - 22 june", true));  // "Order placed",
    list.add(_divider());
    list.add(_itemTextPastOrder("${strings.get(121)}", " - 23 june", true));  // Payment verification
    list.add(_divider());
    list.add(_itemTextPastOrder("${strings.get(122)}", "", false));  // Processing
    list.add(_divider());
    list.add(_itemTextPastOrder("${strings.get(123)}", "", false));  // On the way
    list.add(_divider());
    list.add(_itemTextPastOrder("${strings.get(124)}", "", false));  // Delivery
    list.add(SizedBox(height: 5,));

    return list;
  }


  _itemTextPastOrder(String leftText, String rightText, bool _delivery){
    var _icon = Icon(Icons.check_circle, color: theme.colorPrimary, size: 30);
    if (!_delivery)
      _icon = Icon(Icons.history, color: theme.colorGrey, size: 30,);
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: <Widget>[
            _icon,
            SizedBox(width: 20,),
            Text(leftText, style: theme.text14,),
            Text(rightText, style: theme.text14,),
          ],
        ));
  }

  _divider(){
    return Align(
      alignment: Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
          margin: EdgeInsets.only(left: 35),
          alignment: Alignment.centerLeft,
          height: 30, width: 1, color: theme.colorDefaultText,
        ),
      ),
    );
  }

}

