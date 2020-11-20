import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/widget/dialog.dart';
import 'package:fooddelivery/widget/iVerifySMS.dart';
import 'package:fooddelivery/widget/iappBar.dart';
import 'package:fooddelivery/widget/ibackground3.dart';
import 'package:fooddelivery/widget/ibox.dart';
import 'package:fooddelivery/widget/ibutton.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  @override
  _VerifyPhoneNumberScreenState createState() => _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  _pressContinueButton(){
    print("User pressed \"CONTINUE\" button");
    print("Phone: ${editControllerPhone.text}");
    _openDialog();
  }

  _onChangeCode(String code){
    print('Code onChanged $code');
  }

  _callbackDone(){
    print("User pressed \"Continue\" button");
    route.pushToStart(context, "/main");
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  final editControllerPhone = TextEditingController();

  _openDialog(){
    EasyDialog(
      title: strings.get(31), // "Almost done!",
      text: strings.get(32), // Code verification success
      closeOnBackgroundTap: true,
      colorBackground: theme.colorBackgroundDialog,
      titleLine: false,
      bodyLine: true,
      okText: strings.get(18), okColor: theme.colorPrimary,     // "Continue",
      callbackPressOk: _callbackDone, okButtonText: true,)
        .show(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    route.disposeLast();
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
          child: Text(strings.get(30),                        // "Verify phone number"
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
                    child: IVerifySMS(color: theme.colorPrimary,
                    callback: _onChangeCode,),
                ),
                SizedBox(height: 45,),

                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(pressButton: _pressContinueButton, text: strings.get(29), // CONTINUE
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

