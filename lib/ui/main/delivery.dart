import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/widget/iCard27.dart';
import 'package:fooddelivery/widget/ibutton.dart';
import 'package:fooddelivery/widget/iinputField2.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  // User press "Continue" button
  //
  _pressContinueButton(){
    if (stage == 3)
      Navigator.pop(context);
    if (stage == 2)
      stage = 3;

    if (stage == 1) {
      print("User pressed \"Continue\" button");
      print("Address: ${editControllerAddress1.text}, city: ${editControllerCity
          .text}, phone: ${editControllerPhone
          .text}, comments: ${editControllerComments.text}");
      stage = 2;
    }
    setState(() {
    });
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  int stage = 1;
  double windowWidth = 0.0;
  double windowHeight = 0.0;
  final editControllerAddress1 = TextEditingController();
  final editControllerComments = TextEditingController();
  final editControllerCity = TextEditingController();
  final editControllerEmail = TextEditingController();
  final editControllerPhone = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    editControllerAddress1.dispose();
    editControllerComments.dispose();
    editControllerCity.dispose();
    editControllerEmail.dispose();
    editControllerPhone.dispose();
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

          Align(
              child: Container (
                child: ListView(
                  children: _getList(),
                ),)
          ),

        ],
    ));
  }

  _getList(){
    var list = List<Widget>();

    list.add(ICard27(
      colorActive: theme.colorPrimary,
      colorInactive: theme.colorDefaultText.withOpacity(0.5),
      stage: stage,
    ));
    list.add(SizedBox(height: 30,));
    list.add(Container(height: 1, color: theme.colorGrey,));
    list.add(SizedBox(height: 30,));

    if (stage == 1) {
      _body(list);
      list.add(SizedBox(height: 50,));
      list.add(_button());
    }

    if (stage == 2) {
      list.add(_item("assets/payment1.png", 1)); // cache on delivery
      list.add(SizedBox(height: 10,));
      list.add(_item("assets/payment3.png", 2)); // stripe
      list.add(SizedBox(height: 10,));
      list.add(_item("assets/payment4.png", 3)); // razorpay
      list.add(SizedBox(height: 30,));
      list.add(_button());
    }

    if (stage == 3) {
      list.add(UnconstrainedBox(
          child: Container(
              height: windowWidth*0.4,
              width: windowWidth*0.8,
              child: Image.asset("assets/success2.png",
                  fit: BoxFit.contain
              )
          )),
      );

      list.add(Container(
        alignment: Alignment.center,
          child: Text(strings.get(126), style: theme.text16bold,)
      )); // You Payment Receive to Seller
      list.add(SizedBox(height: windowWidth*0.2,));
      list.add(_button());
    }

    return list;
  }

  var _currVal = 1;

  _item(String image, int index){
    return Container(
        color: theme.colorBackgroundGray,
        child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Expanded(child: Container(
                    child: RadioListTile(
                      activeColor: theme.colorDefaultText,
                      title: Container(
                          alignment: Alignment.centerLeft,
                          child: UnconstrainedBox(
                              child: Container(
                                  height: windowWidth*0.1,
                                  width: windowWidth*0.20,
                                  child: Container(
                                    child: Image.asset(image,
                                        fit: BoxFit.contain
                                    ),
                                  )))
                      ),
                      groupValue: _currVal,
                      value: index,
                      onChanged: (val) {
                        setState(() {
                          _currVal = val;
                          //_itemSelect();
                        });
                      },
                    ))),

              ],
            )


        )
    );
  }

  _body(List<Widget> list){

      list.add(Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: IInputField2(hint : strings.get(102),                      // "Address 1"
            icon : Icons.location_on,
            controller : editControllerAddress1,
            colorDefaultText: theme.colorPrimary,
            colorBackground: theme.colorBackgroundDialog,
            type : TextInputType.text,
        ),
      ));

      list.add(Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: IInputField2(hint : strings.get(104),                      // City
              icon : Icons.location_city,
              controller : editControllerCity,
              type : TextInputType.text,
            colorDefaultText: theme.colorPrimary,
            colorBackground: theme.colorBackgroundDialog,
          ),
        ));

      list.add(Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: IInputField2(hint : strings.get(106),                      // Phone",
              icon : Icons.phone,
              controller : editControllerPhone,
              type : TextInputType.phone,
            colorDefaultText: theme.colorPrimary,
            colorBackground: theme.colorBackgroundDialog,
          ),
        ));

      list.add(Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: IInputField2(hint : strings.get(125),                      // Comments",
          icon : Icons.chat,
          controller : editControllerComments,
          type : TextInputType.phone,
          colorDefaultText: theme.colorPrimary,
          colorBackground: theme.colorBackgroundDialog,
        ),
      ));

      list.add(SizedBox(height: 30,));
  }

  _button(){
    return Container(
      margin: EdgeInsets.only(left: windowWidth*0.15, right: windowWidth*0.15),
      child: IButton(pressButton: _pressContinueButton,
        text: (stage == 3) ? strings.get(118) : strings.get(18), // Done or Continue
        color: theme.colorPrimary,
        textStyle: theme.text16boldWhite,),
    );
  }
}

