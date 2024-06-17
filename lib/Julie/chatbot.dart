import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom widget/custom_elevated_button.dart';
import '../drawer/articles_page.dart';
import '../drawer/instruction_page.dart';
import '../drawer/profile_page.dart';
import 'julie.dart';
import '../custom widget/gradient_text.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late GoogleMapController mapController;
  LatLng? _center;
  List<Marker> _therapistMarkers = [];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      _getCurrentLocation();
    } else {
      Fluttertoast.showToast(
          msg: "Location permission denied",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });
    _getTherapistsNearby(position.latitude, position.longitude);
  }

  void _getTherapistsNearby(double lat, double lng) async {
    const apiKey = "AIzaSyBRtbhQNMp89eC-jm7SxfcxL-JLa242W4U";
    const radius = 50000; // in meters
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=psychotherapist&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];

      setState(() {
        _therapistMarkers = (results as List)
            .map((result) => Marker(
          markerId: MarkerId(result['place_id']),
          position: LatLng(
            result['geometry']['location']['lat'],
            result['geometry']['location']['lng'],
          ),
          infoWindow: InfoWindow(title: result['name']),
        ))
            .toList();
      });
    } else {
      Fluttertoast.showToast(
          msg: "Failed to load nearby psychotherapists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Comfort Space', style: Theme.of(context).textTheme.displayLarge),
        ),
        drawer: Menu(),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF69170),
                          Color(0xFF7D96E6),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 16.0),
                              child: (Text(
                                "Hi! You Can Ask Me",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: (Text(
                                "Anything",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 16.0, bottom: 16.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (_) => Chat()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: GradientText(
                                    "Ask Now",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF69170),
                                        Color(0xFF7D96E6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/icon.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 16.0),
                    child: ListView(
                      children: [
                        CarouselSlider(
                          items: [
                            // 1st Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/drawer.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 2nd Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/drawer1.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 3rd Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/drawer2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 4th Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/drawer3.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // 5th Image of Slider
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/drawer4.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],

                          // Slider Container properties
                          options: CarouselOptions(
                            height: 180.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 275.0, // Set the desired height for the map
                          child: _center == null
                              ? Center(child: CircularProgressIndicator())
                              : GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: _center!,
                              zoom: 15.0,
                            ),
                            myLocationEnabled: true,
                            markers: Set<Marker>.of(_therapistMarkers),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      final encodedQuery = Uri.encodeQueryComponent("Psychotherapist near me");
                      final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$encodedQuery");
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 10),
                        Text(
                          'Psychotherapist Near Me',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    Color color = Colors.black;
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 40, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Profile',
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 25, color: color),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Articles()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Articles',
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 25, color: color),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.book_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Instructions',
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 25, color: color),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Instruction()));
                  },
                ),
                SizedBox(height: 30),
                SizedBox(height: 30),
                SizedBox(height: height / .8),
                Text(
                  'Copyright©2023 | @Aditya',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 15, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
