import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/widget/iline.dart';
import 'package:fooddelivery/widget/ilist5.dart';
import 'package:fooddelivery/widget/label.dart';

class Menu extends StatelessWidget {
  @required final BuildContext context;
  final Function(String) callback;
  Menu({this.context, this.callback});

  //////////////////////////////////////////////////////////////////
  //
  //
  //
  _onMenuClickItem(int id){
    print("User click menu item: $id");
    switch(id){
      case 1:   // home
        callback("home");
        break;
      case 2:   // notifications
        route.push(context, "/notify");
        break;
      case 3:   // My Orders
        callback("orders");
        break;
      case 4:   // Wish List
        callback("favorites");
        break;
      case 7:   // Help
        route.push(context, "/help");
        break;
      case 8:   // Settings
        callback("account");
        break;
      case 9:   // Language
        route.pushLanguage(context, callback);
        break;
      case 10:   // dark & light mode
        theme.changeDarkMode();
        callback("redraw");
        break;
      case 11:   // term of service
        route.push(context, "/term");
        break;
    }
  }

  _changeNotify(bool value){
    print("Notification button change value: $value");
  }
  //
  //
  //
  //////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: theme.colorBackground,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: MediaQuery
                  .of(context)
                  .padding
                  .top,),
              Container(
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      UnconstrainedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(account.userAvatar),
                            radius: 35,),
                          margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                        ),
                      ),
                      SizedBox(width: 20,),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(account.userName, style: theme.text18boldPrimary,),
                            Text(account.email, style: theme.text16,),
                          ],
                        ),
                      )
                    ],

                  )
              ),

              ILine(),

              _item(1, strings.get(33), "assets/home.png"), // 'Home'
              _item(2, strings.get(35), "assets/notifyicon.png"),  // Notifications
              _itemWithNumber(3, strings.get(36), "assets/prod.png", 4), // 'My orders'
              _item(4, strings.get(38), "assets/heart.png"), // "Favorites",
              ILine(),
              _item(7, strings.get(51), "assets/help.png"), // Help & Support
              _item(8, strings.get(37), "assets/settings.png"), // "Account",
              _item(9, strings.get(62), "assets/language.png"), // Languages
              IList5(icon:  UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/notifyicon.png",
                          fit: BoxFit.contain, color: theme.colorPrimary,
                      )
                  )),
                text : strings.get(35),                                   // Notifications
                textStyle: theme.text16bold,
                activeColor: theme.colorPrimary,
                inactiveTrackColor: theme.colorGrey,
                press: _changeNotify,
              ),
              _item(11, strings.get(68), "assets/help.png"),      // Term of service
              ILine(),
              _darkMode(),

            ],
          ),
        )
    );
  }

  _darkMode(){
    if (theme.darkMode)
      return _item(10, "Light colors", "assets/brands.png");
    return _item(10, "Dark colors", "assets/brands.png");
  }

  _item(int id, String name, String imageAsset){
    return Stack(
      children: <Widget>[
        ListTile(
          title: Text(name, style: theme.text16bold,),
          leading:  UnconstrainedBox(
              child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(imageAsset,
                      fit: BoxFit.contain,
                      color: theme.colorPrimary,
                  )

              )),
        ),
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  Navigator.pop(context);
                  _onMenuClickItem(id);
                }, // needed
              )),
        )
      ],
    );
  }

  _itemWithNumber(int id, String name, String imageAsset, int number){
    return Stack(
      children: <Widget>[
        ListTile(
          title: Text(name, style: theme.text16bold,),
          leading:  UnconstrainedBox(
              child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(imageAsset,
                      fit: BoxFit.contain,
                      color: theme.colorPrimary,
                  )
              )),
          trailing: ILabel(text: " $number ", color: Colors.black, colorBackgroud: Colors.white),
        ),
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  Navigator.pop(context);
                  _onMenuClickItem(id);
                }, // needed
              )),
        )
      ],
    );
  }

}