import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/ui/main/account.dart';
import 'package:fooddelivery/ui/main/favorites.dart';
import 'package:fooddelivery/ui/main/header.dart';
import 'package:fooddelivery/ui/main/home.dart';
import 'package:fooddelivery/ui/main/map.dart';
import 'package:fooddelivery/ui/main/orders.dart';
import 'package:fooddelivery/ui/menu/menu.dart';
import 'package:fooddelivery/widget/easyDialog2.dart';
import 'package:fooddelivery/widget/ibottombar.dart';
import 'package:fooddelivery/widget/ibutton2.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  _MainScreenState _state;
  @override
  _MainScreenState createState() {
    _state = _MainScreenState();
    return _state;
  }
  route(String value){
    _state.routes(value);
  }
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //

  _callbackChange(){
    print("User pressed Change password");
    print("Old password: ${editControllerOldPassword.text}, New password: ${editControllerNewPassword1.text}, "
        "New password 2: ${editControllerNewPassword2.text}");
  }


  _callbackSave(){
    print("User pressed Save profile");
    print("User Name: ${editControllerName.text}, E-mail: ${editControllerEmail.text}, Phone: ${editControllerPhone.text}");
  }

  _bottonBarChange(int index){
    print("User pressed bottom bar button with index: $index");
    setState(() {
      _currentPage = index;
    });
  }

  _openMenu(){
    print("Open menu");
    setState(() {
      _scaffoldKey.currentState.openDrawer();
    });
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  final editControllerName = TextEditingController();
  final editControllerEmail = TextEditingController();
  final editControllerPhone = TextEditingController();
  final editControllerOldPassword = TextEditingController();
  final editControllerNewPassword1 = TextEditingController();
  final editControllerNewPassword2 = TextEditingController();
  var _currentPage = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    route.disposeLast();
    editControllerName.dispose();
    editControllerEmail.dispose();
    editControllerPhone.dispose();
    editControllerOldPassword.dispose();
    editControllerNewPassword1.dispose();
    editControllerNewPassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;

    String _headerText = strings.get(47); // "Map",
    switch(_currentPage){
      case 1:
        _headerText = strings.get(36); // "My Orders",
        break;
      case 2:
        _headerText = strings.get(33); // "Home",
        break;
      case 3:
        _headerText = strings.get(37); // "Account",
        break;
      case 4:
        _headerText = strings.get(38); // "Favorites",
        break;
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu(context: context, callback: routes,),
      backgroundColor: theme.colorBackground,
      body: Stack(
        children: <Widget>[

          if (_currentPage == 0)
            MapScreen(),
          if (_currentPage == 1)
            OrdersScreen(),
          if (_currentPage == 2)
            HomeScreen(),
          if (_currentPage == 3)
            AccountScreen(onDialogOpen: _openDialogs),
          if (_currentPage == 4)
            FavoritesScreen(),

          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Header(title: _headerText, onMenuClick: _openMenu)
          ),

          IBottomBar(colorBackground: theme.colorBackground, colorSelect: theme.colorPrimary,
                colorUnSelect: theme.colorDefaultText, callback: _bottonBarChange, initialSelect: _currentPage,
              getItem: (){return _currentPage;},
              icons: ["assets/map.png", "assets/orders.png", "assets/home.png", "assets/account.png", "assets/favorites.png"]
          ),

          IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: theme.colorGrey,
            body: _dialogBody, backgroundColor: theme.colorBackground,),


        ],
      ),
    );
  }

  routes(String route){
    if (route == "map")
      setState(() {
        _currentPage = 0;
      });
    if (route == "orders")
      setState(() {
        _currentPage = 1;
      });
    if (route == "home")
      setState(() {
        _currentPage = 2;
      });
    if (route == "account")
      setState(() {
        _currentPage = 3;
      });
    if (route == "favorites")
      setState(() {
        _currentPage = 4;
      });
    if (route == "redraw")
      print ("mainscreen redraw");
      setState(() {
      });
  }

  _openDialogs(String name){
    if (name == "EditProfile")
      _openEditProfileDialog();
    if (name == "makePhoto")
      getImage();
    if (name == "changePassword")
      _pressChangePasswordButton();
  }

  double _show = 0;
  Widget _dialogBody = Container();

  _openEditProfileDialog(){

    editControllerName.text = account.userName;
    editControllerEmail.text = account.email;
    editControllerPhone.text = account.phone;

    _dialogBody = Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Text(strings.get(136), textAlign: TextAlign.center, style: theme.text18boldPrimary,) // "Edit profile",
          ), // "Reason to Reject",
          SizedBox(height: 20,),
          Text("${strings.get(137)}:", style: theme.text12bold,),  // "User Name",
          _edit(editControllerName, strings.get(138), false),                //  "Enter your User Name",
          SizedBox(height: 20,),
          Text("${strings.get(139)}:", style: theme.text12bold,),  // "E-mail",
          _edit(editControllerEmail, strings.get(140), false),                //  "Enter your User E-mail",
          SizedBox(height: 20,),
          Text("${strings.get(59)}:", style: theme.text12bold,),  // Phone
          _edit(editControllerPhone, strings.get(141), false),                //  "Enter your User Phone",
          SizedBox(height: 30,),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(142),                  // Change
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                        _callbackSave();
                      }
                  ),
                  SizedBox(width: 10,),
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(135),              // Cancel
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                      }
                  ),
                ],
              )),

        ],
      ),
    );

    setState(() {
      _show = 1;
    });
  }

  _edit(TextEditingController _controller, String _hint, bool _obscure){
    return Container(
      height: 30,
      child: TextField(
        controller: _controller,
        onChanged: (String value) async {
        },
        cursorColor: theme.colorDefaultText,
        style: theme.text14,
        cursorWidth: 1,
        obscureText: _obscure,
        textAlign: TextAlign.left,
        maxLines: 1,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: _hint,
            hintStyle: theme.text14
        ),
      ),
    );
  }

  _pressChangePasswordButton(){
    _dialogBody = Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Text(strings.get(145), textAlign: TextAlign.center, style: theme.text18boldPrimary,) // "Change password",
          ), // "Reason to Reject",
          SizedBox(height: 20,),
          Text("${strings.get(129)}:", style: theme.text12bold,),  // "Old password",
          _edit(editControllerOldPassword, strings.get(130), true),                //  "Enter your old password",
          SizedBox(height: 20,),
          Text("${strings.get(131)}:", style: theme.text12bold,),  // "New password",
          _edit(editControllerNewPassword1, strings.get(132), true),                //  "Enter your new password",
          SizedBox(height: 20,),
          Text("${strings.get(133)}:", style: theme.text12bold,),  // "Confirm New password",
          _edit(editControllerNewPassword2, strings.get(134), true),                //  "Enter your new password",
          SizedBox(height: 30,),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(142),                  // Change
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                        _callbackChange();
                      }
                  ),
                  SizedBox(width: 10,),
                  IButton2(
                      color: theme.colorPrimary,
                      text: strings.get(135),              // Cancel
                      textStyle: theme.text14boldWhite,
                      pressButton: (){
                        setState(() {
                          _show = 0;
                        });
                      }
                  ),
                ],
              )),

        ],
      ),
    );

    setState(() {
      _show = 1;
    });
  }

  Future getImage2(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null && pickedFile.path != null) {
      print("Photo file: ${pickedFile.path}");
      setState(() {
        //_avatar = pickedFile.path;
      });
    }
  }

  getImage(){
    _dialogBody = Column(
      children: [
        InkWell(
            onTap: () {
              getImage2(ImageSource.gallery);
              setState(() {
                _show = 0;
              });
            }, // needed
            child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 40,
                color: theme.colorBackgroundGray,
                child: Center(
                  child: Text(strings.get(143)), // "Open Gallery",
                )
            )),
        InkWell(
            onTap: () {
              getImage2(ImageSource.camera);
              setState(() {
                _show = 0;
              });
            }, // needed
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(bottom: 10),
              height: 40,
              color: theme.colorBackgroundGray,
              child: Center(
                child: Text(strings.get(144)), //  "Open Camera",
              ),
            )),
        SizedBox(height: 20,),
        IButton2(
            color: theme.colorPrimary,
            text: strings.get(135),              // Cancel
            textStyle: theme.text14boldWhite,
            pressButton: (){
              setState(() {
                _show = 0;
              });
            }
        ),
      ],
    );
    setState(() {
      _show = 1;
    });
  }

}

