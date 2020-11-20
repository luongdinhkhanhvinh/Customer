import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/widget/iappBar.dart';
import 'package:fooddelivery/widget/ibackground3.dart';
import 'package:fooddelivery/widget/ibox.dart';
import 'package:fooddelivery/widget/ibutton.dart';
import 'package:fooddelivery/widget/iinputField2.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  _pressSendButton(){
    print("User pressed \"SEND\" button");
    print("E-mail: ${editControllerEmail.text}");
    route.pushToStart(context, "/main");
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  final editControllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    route.disposeLast();
    editControllerEmail.dispose();
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

           IBackground4(width: windowWidth, colorsGradient: theme.colorsGradient),

           IAppBar(context: context, text: "", color: Colors.white),

           Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, windowHeight*0.1),
                  width: windowWidth,
                  child: _body(),
                  )
           ),

        ],
      ),
    );
  }

  _body(){
    return ListView(
      shrinkWrap: true,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 15, right: 20),
          alignment: Alignment.centerLeft,
          child: Text(strings.get(20),                        // "Forgot password"
              style: theme.text20boldWhite
          ),
        ),
        SizedBox(height: 20,),

        IBox(
            color: theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(height: 25,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child:
                    IInputField2(
                      hint: strings.get(21),            // "E-mail address"
                      icon: Icons.alternate_email,
                      colorDefaultText: theme.colorPrimary,
                      colorBackground: theme.colorBackgroundDialog,
                      controller: editControllerEmail,
                    )
                ),
                SizedBox(height: 25,),

                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(pressButton: _pressSendButton, text: strings.get(23), // SEND
                    color: theme.colorPrimary,
                    textStyle: theme.text16boldWhite,),
                ),
                SizedBox(height: 25,),
              ],
            )
        ),

      ],
    );
  }

}