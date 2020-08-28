import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FoodAndShelter extends StatefulWidget {
  @override
  _FoodAndShelterState createState() => _FoodAndShelterState();
}

class _FoodAndShelterState extends State<FoodAndShelter> {
  bool mapToogle = false;
  bool clientToogle = true;
  GoogleMapController mapController;

  var currentLocation;

  var client = [];

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final spinkit = SpinKitRotatingCircle(
    color: Colors.deepPurple,
  );

  populateDisasters() {
    Firestore.instance
        .collection('foodAndShelterLocation')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          setState(() {
            client.add(docs.documents[i].data);
          });
          print(client[i]);
          initMarker(docs.documents[i].data, docs.documents[i].documentID);
        }
      }
    });
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void initMarker(request, requestId) {
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueViolet,
      ),
      markerId: markerId,
      position:
          LatLng(request['location'].latitude, request['location'].longitude),
      infoWindow:
          InfoWindow(title: "Food and Shelter", snippet: request['name']),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void getCurrentLocation() async {
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToogle = true;
        populateDisasters();
      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    populateDisasters();
    super.initState();
  }

  Widget clientCard(client) {
    return Padding(
      padding: EdgeInsets.only(left: 7.0, top: 10),
      child: InkWell(
        onTap: () {
          zoomInMarker(client);
        },
        child: Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Name : ' + client['name'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Text(
                    //   'Type : ' + client['type'],
                    //   style: TextStyle(
                    //       color: Colors.black, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Text(
                    //   'Tier : ' + client['tier'],
                    //   style: TextStyle(
                    //       color: Colors.black, fontWeight: FontWeight.bold),
                    // ),

                    // Text()
                  ],
                ),
              ),
            )),
      ),
    );
  }

  zoomInMarker(client) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(client['location'].latitude, client['location'].longitude),
      zoom: 14,
      bearing: 90,
      tilt: 45,
    )));
  }

  googlemap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      trafficEnabled: true,
      indoorViewEnabled: true,
      buildingsEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      markers: Set<Marker>.of(markers.values),
      onMapCreated: mapCreated,
      initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: mapToogle
                ? Stack(
                    children: [
                      googlemap(),
                      Overlay.show(context),
                    ],
                  )
                : Center(
                    child: spinkit,
                  ),
          ),
          Positioned(
              top: 650,
              left: 20,
              child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: mapToogle
                      ? ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(8.0),
                          children: client.map((element) {
                            return clientCard(element);
                          }).toList(),
                        )
                      : Container(
                          height: 1.0,
                          width: 1.0,
                        ))),
        ],
      ),
    );
  }
}

class Overlay {
  static Widget show(BuildContext context) {
    final spinkit = SpinKitRipple(
      color: Colors.blue,
      size: 150.0,
    );

    return Center(
      child: spinkit,
      // height: 50,
      // width: 50,
      //color: Colors.white.withOpacity(0),
    );
  }
}
