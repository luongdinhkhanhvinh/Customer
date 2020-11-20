import 'package:fooddelivery/model/product.dart';

///////////////////////////////////////////////////////////////////////////////
//
// Promotion  data
//
var dataPromotion = [
  Promotion(image: "assets/p1.jpg", id: 1),
  Promotion(image: "assets/p2.jpg", id: 2),
  Promotion(image: "assets/p3.jpg", id: 3),
  Promotion(image: "assets/p4.jpg", id: 4),
];

//
//
//
///////////////////////////////////////////////////////////////////////////////


class Promotion {
  final String image;
  final String text;
  final List<Products> data;
  final int id;

  Promotion({this.image, this.text, this.data, this.id});
}
