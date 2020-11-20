import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/model/map.dart';
import 'package:fooddelivery/model/topRestourants.dart';
import 'package:fooddelivery/ui/main/home.dart';
import 'package:fooddelivery/widget/iboxCircle.dart';
import 'package:fooddelivery/widget/icard10.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapScreen extends StatefulWidget {
  final Function(String) callback;
  final Color color;
  MapScreen({this.color = Colors.black, this.callback});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  //

  _onTopRestaurantClick(String id, String heroId){
    print("User pressed Top Restaurant with id: $id");
    idRestaurantOnMap = id;
    markers.clear();
    _addMarkers();
    _navigateToMap();
  }

  _onTopRestaurantNavigateIconClick(String id){
    print("User pressed Top Restaurant Route icon with id: $id");
    idRestaurantOnMap = id;
    markers.clear();
    _addMarkers();
    _navigateToMap();
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;
  String _mapStyle;

  @override
  void initState() {
    _addMarkers();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(48.836010, 2.331359), zoom: 12,); // paris coordinates
  Set<Marker> markers = {};
  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    if (_controller != null)
      if (theme.darkMode)
        _controller.setMapStyle(_mapStyle);
      else
        _controller.setMapStyle(null);

    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+40),
        child: Stack(children: <Widget>[

          _map(),

          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15,),
                  _buttonPlus(),
                  _buttonMinus(),
                ],
              )
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(bottom: 70),
                child: _horizontalTopRestaurants()
            ),
          )


      ]
        )
    );
  }

  _map(){
    return GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false, // Whether to show zoom controls (only applicable for Android).
        myLocationEnabled: true,  // For showing your current location on the map with a blue dot.
        myLocationButtonEnabled: false, // This button is used to bring the user location to the center of the camera view.
        initialCameraPosition: _kGooglePlex,
        onCameraMove:(CameraPosition cameraPosition){

        },
        onTap: (LatLng pos) {

        },
        onLongPress: (LatLng pos) {

        },
        markers: markers != null ? Set<Marker>.from(markers) : null,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          if (theme.darkMode)
            _controller.setMapStyle(_mapStyle);
          if (idRestaurantOnMap != null)
            _navigateToMap();
        });
  }

  _buttonPlus(){
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(child: Icon(Icons.add, size: 30, color: Colors.black,)),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: (){
                  _controller.animateCamera(
                    CameraUpdate.zoomIn(),
                  );
                }, // needed
              )),
        )
      ],
    );
  }

  _buttonMinus(){
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(child: Icon(Icons.remove, size: 30, color: Colors.black,)),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: (){
                  _controller.animateCamera(
                    CameraUpdate.zoomOut(),
                  );
                }, // needed
              )),
        )
      ],
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

  _addMarkers(){
    for (var item in mapMarkers) {
      if (idRestaurantOnMap != null) {
        if (item.id == idRestaurantOnMap) {
          _addMarker(item);
          break;
        }
      }else
        _addMarker(item);
    }
  }

  MarkerId _lastMarkerId;

  _addMarker(MapMarkers item){
    print("add marker ${item.id}");
    _lastMarkerId = MarkerId(item.id);
      final marker = Marker(
          markerId: _lastMarkerId,
          position: LatLng(
              item.lat, item.lng
          ),
          infoWindow: InfoWindow(
            title: item.title,
            onTap: () {

            },
            //snippet: id,
          ),
          //icon: myIcon,
          onTap: () {

          }
      );
      markers.add(marker);
  }
  var _bearing = 0.0;

  _navigateToMap(){
    _bearing += 90;
    for (var item in mapMarkers)
        if (item.id == idRestaurantOnMap) {
          _controller.showMarkerInfoWindow(_lastMarkerId  );
          _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    bearing: _bearing,
                  target: LatLng(item.lat, item.lng),
                  zoom: 13,
                ),
              )

          );
        }
  }
}