import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/dishes.dart';
import 'package:fooddelivery/model/mostpopular.dart';
import 'package:fooddelivery/model/review.dart';
import 'package:fooddelivery/model/trending.dart';
import 'package:fooddelivery/ui/main/home.dart';
import 'package:fooddelivery/ui/menu/menu.dart';
import 'package:fooddelivery/widget/iList6.dart';
import 'package:fooddelivery/widget/ibox.dart';
import 'package:fooddelivery/widget/iboxCircle.dart';
import 'package:fooddelivery/widget/ibuttonCount.dart';
import 'package:fooddelivery/widget/icard1.dart';
import 'package:fooddelivery/widget/icard13.dart';
import 'package:fooddelivery/widget/iinkwell.dart';
import 'package:fooddelivery/widget/ilist1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'header.dart';

class DishesDetailsScreen extends StatefulWidget {
  final String title;
  final bool nomenu;
  DishesDetailsScreen({Key key, this.title, this.nomenu}) : super(key: key);
  @override
  _DishesDetailsScreenState createState() => _DishesDetailsScreenState();
}

class _DishesDetailsScreenState extends State<DishesDetailsScreen> with SingleTickerProviderStateMixin {

  ///////////////////////////////////////////////////////////////////////////////
  //

  _extrasClick(String id, bool value){
    print("User pressed Extras item with id: $id, set=$value");
  }

  _onDishesClick(String id, String heroId){
    print("User pressed Most Popular item with id: $id");
     setState(() {
       _load(id);
       _controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
     });
  }

  var _count = 1;
  _onPress(int count){
    print("Count = $count");
    _count = count;
  }

  _tapAddToCart(){
    print("User pressed \"Add to cart\" button. Count = $_count");
  }

  ///////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  var _controller = ScrollController();

  _load(String id){
    for (var item in trending)
      if (item.id == id)
        _this = item;

    for (var item in mostPopular)
      if (item.id == id)
        _this = item;
  }

  Dishes _this;

  @override
  void initState() {
    _load(idDishes);
    super.initState();
  }

  @override
  void dispose() {
    route.disposeLast();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: Menu(context: context, ),
        backgroundColor: theme.colorBackground,
        body: NestedScrollView(
          controller: _controller,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: windowHeight*0.35,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: theme.colorPrimary,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: _imageBuild(),
                  ),
                  title: Container(
                      child: Header(nomenu: true, white: true, transparent: true) // Home
                  ),
                )];
            },

            body: Stack (
              children: <Widget>[

                Container(
                  child: _body(),
                ),

                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: theme.colorBackground,
                      width: windowWidth,
                      height: 60.0,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: UnconstrainedBox(
                              child: Container(
                                  color: theme.colorPrimary,
                                  width: windowWidth,
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      _button(),
                                      IButtonCount(textStyle: theme.text20boldWhite, color: Colors.white, count: 1, pressButton: _onPress,),
                                    ],
                                  )

                              )

                          )),
                    ))

              ],
            )
        ));
  }

  _body(){
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: _children(),
      ),
    );
  }

  _children(){
    var list = List<Widget>();

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/orders.png", text: _this.text,  // dish name
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText,),
    ));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Text(strings.get(0), style: theme.text14),                                               // dish description
    ));

    list.add(SizedBox(height: 20,));

    list.add(_horizontalImages());                                                                    // dish images

    list.add(SizedBox(height: 20,));

    _extras(list);                                                                                    // Extras

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/ingredients.png", text: strings.get(79),               // Ingredients
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Text(strings.get(0), style: theme.text14),                                               // Ingredients description
    ));

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/brands.png", text: strings.get(80),                         // Nutrition
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    _nutrition(list);

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/info.png", text: strings.get(69),             // Information
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(_phone());

    list.add(SizedBox(height: 20,));

    list.add(_workTime());

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/top.png", text: strings.get(78),              // See Also
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    _mostPopular(list);

    list.add(SizedBox(height: 20,));

    list.add(Container(
      margin: EdgeInsets.only(left: 20),
      child: IList1(imageAsset: "assets/reviews.png", text: strings.get(77),        // "Reviews",
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));

    list.add(SizedBox(height: 10,));

    _reviews(list);

    return list;
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
          callback: _onDishesClick,
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
          callback: _onDishesClick,
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

  _addImage(List<Widget> list, double width, double height){
    list.add(UnconstrainedBox(
        child: Container(
          height: height,
          width: width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(_this.image),
                      fit: BoxFit.cover
                  ),
                ),
              )),
        )),
    );
    list.add(SizedBox(width: 10,));
  }

  _horizontalImages(){
    var list = List<Widget>();
    var width = windowWidth*0.4;
    var height = windowWidth*0.4*0.7;

    list.add(SizedBox(width: 10,));
    _addImage(list, width, height);
    _addImage(list, width, height);
    _addImage(list, width, height);

    return Container(
      height: height+20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }

  _imageBuild(){
    return Container(
        child: Hero(
          tag: idHeroes,
          child: Image.asset(_this.image,
              fit: BoxFit.cover
          ),
        )
    );
  }

  _phone(){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("Phone: 233 223 2334", style: theme.text14)
          ),
          IInkWell(child: IBoxCircle(child: _icon()), onPress: _callMe,)
        ],
      ),
    );
  }

  _icon(){
    String icon = "assets/call.png";
    return Container(
      padding: EdgeInsets.all(5),
        child: UnconstrainedBox(
        child: Container(
            height: 30,
            width: 30,
            child: Image.asset(icon,
              fit: BoxFit.contain, color: Colors.black,
            )
        ))
    );
  }

  _callMe() async {
    var uri = 'tel:233 223 2334';
    if (await canLaunch(uri))
      await launch(uri);
  }

  _workTime(){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          _oneitem(strings.get(70), "10:00AM-11:00PM"), // "Monday",
          _oneitem(strings.get(71), "10:00AM-11:00PM"), // "Tuesday",
          _oneitem(strings.get(72), "10:00AM-11:00PM"), // "Wednesday",
          _oneitem(strings.get(73), "10:00AM-11:00PM"), // "Thursday",
          _oneitem(strings.get(74), "10:00AM-11:00PM"), // "Friday",
          _oneitem(strings.get(75), "10:00AM-11:00PM"), // Saturday
          _oneitem(strings.get(76), "10:00AM-11:00PM"), // Sunday
        ],
      )
    );
  }

  _oneitem(String day, String time){
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(day, style: theme.text14),
          Text(time, style: theme.text14bold)
      ],
    ));
  }


  _nutrition(List<Widget> list){
    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

      _nutritionItem(strings.get(81), "280"), // "Calories",
      _nutritionItem(strings.get(82), "9g"), // Total Fat
      _nutritionItem(strings.get(83), "6g"), // Sugars
      _nutritionItem(strings.get(84), "320mg"), // Calcium

    ],
    )));

    list.add(Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          _nutritionItem(strings.get(85), "2mcg"), // Vitamin D
          _nutritionItem(strings.get(86), "15g"), // Protein
          _nutritionItem(strings.get(87), "35mg"), // Cholesterol
          _nutritionItem(strings.get(88), "1.6mg"), // Iron

        ],
        )));

  }

  _nutritionItem(String text1, String text2){
    return IBox(radius: 0, blur: 10, child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(text1, style: theme.text12grey,),
            Text(text2, style: theme.text14primary,),
          ],
      )));
  }

  _extras(List<Widget> list) {
    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: IList1(imageAsset: "assets/add.png",
        text: strings.get(89),                // Extras
        textStyle: theme.text16bold, imageColor: theme.colorDefaultText),
    ));
    list.add(SizedBox(height: 20,));
    list.add(IList6(initState: false, leading: CircleAvatar(backgroundImage: AssetImage("assets/b1.jpg"), radius: 20,),
      title: "4 CHEESO RINGS", titleStyle: theme.text18bold,
      subtitle: "Rings of cheese & onion in a crisp crumb",
      text: "\$1.76", textStyle: theme.text18boldPrimary,
      id: "extras1", callback: _extrasClick,
    ));
    list.add(IList6(initState: true, leading: CircleAvatar(backgroundImage: AssetImage("assets/b2.jpg"), radius: 20,),
      title: "POTATO CHIPS", titleStyle: theme.text18bold,
      subtitle: "A portion of tasty sweet potato chips",
      text: "\$0.28", textStyle: theme.text18boldPrimary,
      id: "extras2", callback: _extrasClick,
    ));
    list.add(IList6(initState: false, leading: CircleAvatar(backgroundImage: AssetImage("assets/b3.jpg"), radius: 20,),
      title: "DIPPING SAUCES", titleStyle: theme.text18bold,
      subtitle: "Wimpy Ketchup, Wimpy Mayo, BBQ or Firecracker",
      text: "\$1.02", textStyle: theme.text18boldPrimary,
      id: "extras3", callback: _extrasClick,
    ));
  }


  _button(){
    return Container(
      color: theme.colorPrimary,
      width: windowWidth*0.5,
      child: RaisedButton(
        elevation: 0,
        textColor: Colors.white,
        color: theme.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child:
        Text(strings.get(90), // "Add to cart",
            style: theme.text20boldWhite
        ),
        onPressed: () {
          _tapAddToCart();
        },
      ),
    );
  }


}

