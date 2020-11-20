import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/notification.dart';
import 'package:fooddelivery/ui/main/header.dart';
import 'package:fooddelivery/widget/ICard29FileCaching.dart';

class NotificationScreen extends StatefulWidget {
  final Function(String) callback;
  NotificationScreen({Key key, this.callback}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  ///////////////////////////////////////////////////////////////////////////////
  //
  //
  _dismissItem(String id){
    print("Dismiss item: $id");

    Notifications _delete;
    for (var item in _this)
      if (item.id == id)
        _delete = item;

    if (_delete != null) {
      _this.remove(_delete);
      setState(() {
      });
    }

  }

  //
  ///////////////////////////////////////////////////////////////////////////////
  double windowWidth = 0.0;
  double windowHeight = 0.0;
  List<Notifications> _this = [
    Notifications(id: "6", date: "2020-08-09 12:22", title: "New Order", text: "You have an order assigned for you",
        image: "https://www.valeraletun.ru/codecanyon/push.jpg"),
    Notifications(id: "5", date: "2020-08-09 14:24", title: "New Order", text: "You have an order assigned for you",
        image: "https://www.valeraletun.ru/adminbsb/public/images/1599664761055top3.jpg"),
    Notifications(id: "4", date: "2020-08-09 16:01", title: "New Order", text: "You have an order assigned for you",
        image: "https://www.valeraletun.ru/adminbsb/public/images/16010335599951-AvocadoVeggie-v2.png"),
    Notifications(id: "3", date: "2020-08-09 12:22", title: "New Order", text: "You have an order assigned for you",
        image: "https://www.valeraletun.ru/adminbsb/public/images/1599677404919pr4.jpg"),
    Notifications(id: "2", date: "2020-08-09 12:22", title: "New Order", text: "You have an order assigned for you",
        image: "https://www.valeraletun.ru/codecanyon/push.jpg"),
    Notifications(id: "1", date: "2020-08-09 17:04", title: "Order Completed!", text: "Congratulation! You payouts has been approved!",
        image: "https://www.valeraletun.ru/codecanyon/push.jpg"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+30),
          child: _body(),
        ),

        Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Header(title: strings.get(35), nomenu: true,) // "Notificaciones",
        ),
      ],
    ));
  }

  _body(){
    var size = 0;
    if (_this == null)
      return Container();
    for (var _ in _this)
      size++;
    if (size == 0)
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UnconstrainedBox(
                  child: Container(
                      height: windowHeight/3,
                      width: windowWidth/2,
                      child: Container(
                        child: Image.asset("assets/nonotify.png",
                          fit: BoxFit.contain,
                        ),
                      )
                  )),
              SizedBox(height: 20,),
              Text(strings.get(44),    // "Not Have Notifications",
                  overflow: TextOverflow.clip,
                  style: theme.text16bold
              ),
              SizedBox(height: 50,),
            ],
          )

      );
    return ListView(
      children: _body2(),
    );
  }

  _body2(){
    var list = List<Widget>();

    list.add(Container(
      color: theme.colorBackgroundDialog,
      child: ListTile(
        leading: UnconstrainedBox(
            child: Container(
                height: 35,
                width: 35,
                child: Image.asset("assets/notifyicon.png",
                  fit: BoxFit.contain,
                ))),
        title: Text(strings.get(45), style: theme.text20bold,),  // "Notifications",
        subtitle: Text(strings.get(46), style: theme.text14,),  // "Swipe left the notification to delete it",
      ),
    ));

    list.add(SizedBox(height: 20,));

    for (var _data in _this) {
      list.add(
          ICard29FileCaching(
              id: _data.id,
              color: theme.colorGrey.withOpacity(0.1),
              title: _data.title,
              titleStyle: theme.text14bold,
              userAvatar: _data.image,
              colorProgressBar: theme.colorPrimary,
              text: _data.text,
              textStyle: theme.text14,
              balloonColor: theme.colorPrimary,
              date: _data.date,
              dateStyle: theme.text12grey,
              callback: _dismissItem
          )
      );
    }
    return list;
  }


}

