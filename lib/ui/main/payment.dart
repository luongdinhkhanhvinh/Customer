import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/ui/main/header.dart';
import 'package:fooddelivery/widget/buttonBorder.dart';
import 'package:fooddelivery/widget/dialog.dart';
import 'package:fooddelivery/widget/ibackground3.dart';
import 'package:fooddelivery/widget/icard8.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  _pressPayButton(){
    print("Press Pay Button");
    _openDialog();
  }

  List<GroupModel> _group = [
    GroupModel(
      text: strings.get(108),  // "Credit/Debit Card",
      index: 1,
      image: "assets/payment1.png",
    ),
    GroupModel(
      text: strings.get(109),   // Cash On Delivery
      index: 2,
      image: "assets/payment2.png",
    ),
    GroupModel(
      text: strings.get(110),   // "PayPal",
      index: 3,
      image: "assets/payment3.png",
    ),
    GroupModel(
      text: strings.get(111),   // "Google Wallet",
      index: 4,
      image: "assets/payment4.png",
    ),
  ];

  int _currVal = 1;

  _itemSelect(){
    print("Select item: $_currVal");
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
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
      body: Stack(
        children: <Widget>[

          IBackground4(width: windowWidth, colorsGradient: theme.colorsGradient),

          Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: windowWidth,

                child: ICard8(
                  colorBackground: theme.colorPrimary,
                  color: theme.colorBackgroundDialog,
                  child: _body(),
                  //child2:
                ),)
          ),

          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Header(title: strings.get(112), nomenu: true, white: true, transparent: true)  // "Payment"
          ),

        ],
      ),
    );
  }

  _body(){
    return Container (
      margin: EdgeInsets.only(left: 20, right: 20),
      child: ListView(
        shrinkWrap: true,
        children:_getList(),
      ),);
  }


  _getList(){
    var list = List<Widget>();

    list.add(Text(strings.get(113), textAlign: TextAlign.left, style: theme.text20bold,)); // Methods
    list.add(SizedBox(height: 5,));
    list.add(Text(strings.get(114), textAlign: TextAlign.left, style: theme.text14,)); //  "Choose your payment method",
    list.add(SizedBox(height: 10,));
    list.add(Container(height: 0.5, color: theme.colorGrey,));
    list.add(SizedBox(height: 20,));

    for (var item in _group)
      list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Expanded(
            child: Container(
                child: RadioListTile(
                  activeColor: theme.colorDefaultText,
                  title: Text("${item.text}", style: theme.text14,),
                  groupValue: _currVal,
                  value: item.index,
                  onChanged: (val) {
                    setState(() {
                      _currVal = val;
                      _itemSelect();
                    });
                  },
                ))),

        UnconstrainedBox(
              child: Container(
                  height: windowWidth*0.1,
                  width: windowWidth*0.1,
                  child: Container(
                    child: Image.asset(item.image,
                        fit: BoxFit.contain
                    ),
                  )
              )),

      ],)
      );

    list.add(SizedBox(height: 30,));

    list.add(
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: IButtonBorder(text: strings.get(115),
            color: theme.colorPrimary, pressButton: _pressPayButton,             // Pay
          ),
        ),
    );

    list.add(SizedBox(height: 30,));

    return list;
  }

  _openDialog() {
    var callbackDone  = (){
      print ("Pressed Done");
      route.popToMain(context);
    };

    EasyDialog(
      titleWidget: UnconstrainedBox(
        child: Column(
          children: <Widget>[
            Container(
                height: 100,
                child: Container(
                  child: Image.asset("assets/success.png",
                      fit: BoxFit.contain
                  ),

                )),

            SizedBox(height: 10,),
            Text(strings.get(116), style: theme.text20bold,),   // "Success",

          ],
        ),

      ),
      closeOnBackgroundTap: true,
      colorBackground: theme.colorBackgroundDialog,
      text: strings.get(117),  // "You Payment Receive to Seller",
      titleLine: false,
      bodyLine: false,
      okText: strings.get(118), okColor: theme.colorPrimary, callbackPressOk: callbackDone, okButtonText: true,)
        .show(context);
  }

}

class GroupModel {
  String text;
  int index;
  String image;
  GroupModel({this.text, this.index, this.image});
}