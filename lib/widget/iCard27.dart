import 'package:flutter/material.dart';

class ICard27 extends StatelessWidget {
  final Color colorActive;
  final Color colorInactive;
  final int stage;
  ICard27({this.colorActive = Colors.black, this.colorInactive = Colors.grey, this.stage = 1});

  @override
  Widget build(BuildContext context) {
    var width = 3.0;
    var radius = 4.0;
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: (stage >= 1) ? colorActive : colorInactive,
            size: 25,
          ),

          SizedBox(
            width: 15,
          ),

          Container(
            width: radius,
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 2) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: width, right: width),
            width: radius,
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 2) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: radius,
            margin: EdgeInsets.only(left: width, right: width),
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 2) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: radius,
            margin: EdgeInsets.only(left: width, right: width),
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 2) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),

          SizedBox(
            width: 15,
          ),

          Icon(
            Icons.credit_card,
            color: (stage >= 2) ? colorActive : colorInactive,
            size: 25,
          ),

          SizedBox(
            width: 15,
          ),

          Container(
            width: radius,
            margin: EdgeInsets.only(left: width, right: width),
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 3) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: radius,
            margin: EdgeInsets.only(left: width, right: width),
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 3) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: radius,
            margin: EdgeInsets.only(left: width, right: width),
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 3) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: radius,
            child: Container(
              decoration: BoxDecoration(
                color: (stage >= 3) ? colorActive : colorInactive,
                shape: BoxShape.circle,
              ),
            ),
          ),


          SizedBox(
            width: 15,
          ),


          Icon(
            Icons.check_circle,
            color: (stage >= 3) ? colorActive : colorInactive,
            size: 25,
          ),
        ],
      ),
    );
  }
}