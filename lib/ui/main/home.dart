import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/categories.dart';
import 'package:fooddelivery/model/mostpopular.dart';
import 'package:fooddelivery/model/review.dart';
import 'package:fooddelivery/model/topRestourants.dart';
import 'package:fooddelivery/model/trending.dart';
import 'package:fooddelivery/widget/icard1.dart';
import 'package:fooddelivery/widget/icard10.dart';
import 'package:fooddelivery/widget/icard11.dart';
import 'package:fooddelivery/widget/icard12.dart';
import 'package:fooddelivery/widget/icard13.dart';
import 'package:fooddelivery/widget/isearch.dart';
import 'package:fooddelivery/widget/ilist1.dart';
import 'package:fooddelivery/widget/ipromotion.dart';
import 'package:fooddelivery/model/promotion.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) callback;
  final Color color;
  HomeScreen({this.color = Colors.black, this.callback});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String idDishes;
String idRestaurant;
String idRestaurantOnMap;
String idCategory;
String idHeroes;
String idOrder;

class _HomeScreenState extends State<HomeScreen> {


  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //
  _pressPromotion(int id){
    print("User press promotion with id: $id");
  }

  _onPressSearch(String value){
    print("Search word: $value");
  }

  _onTopRestaurantClick(String id, String heroId){
    print("User pressed Top Restaurant with id: $id");
    idHeroes = heroId;
    idRestaurant = id;
    route.setDuration(1);
    route.push(context, "/restaurantdetails");
  }

  _onTopRestaurantNavigateIconClick(String id){
    print("User pressed Top Restaurant Route icon with id: $id");
    idRestaurantOnMap = id;
    route.mainScreen.route("map");
  }

  _onCategoriesClick(String id, String heroId){
    print("User pressed Category item with id: $id");
    idHeroes = heroId;
    idCategory = id;
    route.setDuration(1);
    route.push(context, "/categorydetails");
  }

  _onTrendingClick(String id, String heroId){
    print("User pressed Trending item with id: $id");
    idDishes = id;
    idHeroes = heroId;
    route.setDuration(1);
    route.push(context, "/dishesdetails");
  }

  _onMostPopularClick(String id, String heroId){
    print("User pressed Most Popular item with id: $id");
    idHeroes = heroId;
    idDishes = id;
    route.setDuration(1);
    route.push(context, "/dishesdetails");
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;

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

    list.add(SizedBox(height: 15,));

    list.add(IPromotion(dataPromotion, height: windowWidth*0.5, width: windowWidth*0.9, colorActivy: theme.colorPrimary,
      style: theme.text22primaryShadow, buttonText: strings.get(97), buttonTextStyle: theme.text14boldWhite, pressButton: _pressPromotion, // Explore
      seconds: 4,));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/top.png", text: strings.get(39),    // "Top Restaurants",
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    list.add(_horizontalTopRestaurants());

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/trending.png", text: strings.get(40),     // "Trending this week",
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    list.add(_horizontalTrending());

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/categories.png", text: strings.get(41),   // "Food categories",
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    list.add(_horizontalCategories());

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/popular.png", text: strings.get(42),        // "Most Popular",
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    _mostPopular(list);

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/reviews.png", text: strings.get(43),      // "Recent Reviews",
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    _reviews(list);

    list.add(SizedBox(height: 200,));

    return list;
  }

  _reviews(List<Widget> list){
    for (var item in reviews)
      list.add(Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: ICard1(
          color: theme.colorPrimary,
          title: item.name, text: item.text, date: item.date,
          titleStyle: theme.text18bold, textStyle: theme.text16, dateStyle: theme.text14grey,
          userAvatar: item.image, rating: item.star,
        ),
      ));
  }

  _mostPopular(List<Widget> list){
    var height = windowWidth*0.5*0.8;
    bool first = true;
    Widget t1;
    for (var item in mostPopular) {
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
          callback: _onMostPopularClick,
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
          callback: _onMostPopularClick,
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

  _horizontalCategories(){
    var list = List<Widget>();
    var height = windowWidth*0.4*0.8;
    for (var item in categories) {
      list.add(ICard12(
        color: theme.colorBackground,
        text: item.text,
        width: windowWidth * 0.4,
        height: height,
        image: item.image,
        id: item.id,
        textStyle: theme.text16bold,
        callback: _onCategoriesClick,
      ));
      list.add(SizedBox(width: 10,));
    }
    return Container(
      height: height+20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }

  _horizontalTrending(){
    var list = List<Widget>();
    var height = windowWidth*0.4*0.8;
    for (var item in trending) {
      list.add(ICard11(
        color: theme.colorBackground,
        text: item.text,
        text2: item.restaurant,
        textInLabel: "${item.currency}${item.price}",
        width: windowWidth * 0.4,
        height: height,
        image: item.image,
        colorLabel: theme.colorCompanion4,
        id: item.id,
        title: theme.text16bold,
        body: theme.text14,
        callback: _onTrendingClick,
      ));
      list.add(SizedBox(width: 10,));
    }
    return Container(
      height: height+20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }

  _horizontalTopRestaurants(){
    var list = List<Widget>();
    var height = windowWidth*0.6*0.7;
    for (var item in topRestourant) {
      list.add(ICard10(
        color: theme.colorBackground,
        text: item.text,
        text2: item.text2,
        width: windowWidth * 0.6,
        height: height,
        image: item.image,
        stars: item.stars,
        colorStars: theme.colorPrimary,
        id: item.id,
        starsCount: item.starsCount,
        title: theme.text18boldPrimary,
        body: theme.text16,
        callback: _onTopRestaurantClick,
        callbackNavigateIcon: _onTopRestaurantNavigateIconClick,
      ));
      list.add(SizedBox(width: 10,));
    }
    return Container(
      height: height+20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }


}