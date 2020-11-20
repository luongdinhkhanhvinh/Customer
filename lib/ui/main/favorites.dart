import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/favorites.dart';
import 'package:fooddelivery/ui/main/home.dart';
import 'package:fooddelivery/widget/icard13.dart';
import 'package:fooddelivery/widget/iinkwell.dart';
import 'package:fooddelivery/widget/ilist2.dart';
import 'package:fooddelivery/widget/isearch.dart';

class FavoritesScreen extends StatefulWidget {
  final Function(String) callback;
  FavoritesScreen({this.callback});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {


  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  _onPressSearch(String value){
    print("User search word: $value");
  }

  _onItemClick(String id, String heroId){
    print("User pressed item with id: $id");
    idHeroes = heroId;
    idDishes = id;
    route.setDuration(1);
    route.push(context, "/dishesdetails");
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  bool _selectList = true;

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+50),
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          shrinkWrap: true,
          children: _children()
        )
    );
  }

  _children(){
    var list = List<Widget>();

    list.add(Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: ISearch(
        hint: strings.get(34), // "Search",
        icon: Icons.search,
        onChangeText: _onPressSearch,
        colorDefaultText: theme.colorDefaultText,
        colorBackground: theme.colorBackground,
      ),
    ));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList2(imageAsset: "assets/favorites.png",
        text: strings.get(38),                      // "Favorites",
        textStyle: theme.text16bold,
        imageColor: theme.colorDefaultText,
        child1: IInkWell(child: _listIcon(), onPress: _onListIconClick,),
        child2: IInkWell(child: _tileIcon(), onPress: _onTileIconClick,),
      )
    ));

    list.add(SizedBox(height: 10,));

    if (!_selectList)
      _mostPopularTile(list);
    else
      _mostPopularList(list);

    list.add(SizedBox(height: 200,));

    return list;
  }

  _listIcon(){
    if (_selectList)
      return UnconstrainedBox(
          child: Container(
              height: 30,
              width: 30,
              child: Image.asset("assets/list.png",
                fit: BoxFit.contain, color: theme.colorPrimary,
              )
          ));
    else
      return UnconstrainedBox(
          child: Container(
              height: 20,
              width: 20,
              child: Image.asset("assets/list.png",
                fit: BoxFit.contain, color: theme.colorDefaultText,
              )
          ));
  }

  _tileIcon(){
    if (!_selectList)
      return UnconstrainedBox(
          child: Container(
              height: 30,
              width: 30,
              child: Image.asset("assets/tile.png",
                fit: BoxFit.contain, color: theme.colorPrimary,
              )
          ));
    else
      return UnconstrainedBox(
          child: Container(
              height: 20,
              width: 20,
              child: Image.asset("assets/tile.png",
                fit: BoxFit.contain, color: theme.colorDefaultText,
              )
          ));
  }

  _mostPopularTile(List<Widget> list){
    var height = windowWidth*0.5*0.8;
    bool first = true;
    Widget t1;
    for (var item in favorites) {
      if (first) {
         t1 = ICard13(
           color: theme.colorBackground,
          text: item.text,
          width: windowWidth * 0.5 - 15,
          height: height,
          image: item.image,
          id: item.id,
          stars: item.star,
          colorStars: theme.colorPrimary,
          textStyle: theme.text16bold,
          callback: _onItemClick,
        );
         first = false;
      }else{
        var t2 = ICard13(
          color: theme.colorBackground,
          text: item.text,
          width: windowWidth * 0.5 - 15,
          height: height,
          image: item.image,
          id: item.id,
          stars: item.star,
          colorStars: theme.colorPrimary,
          textStyle: theme.text16bold,
          callback: _onItemClick,
        );
        list.add(Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: <Widget>[
              t1,
              SizedBox(width: 10,),
              t2
            ],
          ),
        ));
        first = true;
      }
    }
    if (!first){
      list.add(Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: <Widget>[
            t1,
            SizedBox(width: 10,),
            Container(width: windowWidth * 0.5 - 15,)
          ],
        ),
      ));
    }
  }

  _mostPopularList(List<Widget> list){
    var height = windowWidth*0.4;
    for (var item in favorites) {
      list.add(Container(
        margin: EdgeInsets.only(right: 10),
          child: ICard13(
            color: theme.colorBackground,
            text: item.text,
            width: windowWidth,
            height: height,
            image: item.image,
            id: item.id,
            stars: item.star,
            colorStars: theme.colorPrimary,
            textStyle: theme.text16bold,
            callback: _onItemClick,
        )));
    }
  }

  _onListIconClick(){
    if (!_selectList){
      setState(() {
        _selectList = true;
      });
    }
  }
  _onTileIconClick(){
    if (_selectList){
      setState(() {
        _selectList = false;
      });
    }
  }

}