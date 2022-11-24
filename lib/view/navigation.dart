import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, required this.title});

  final String title;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  static const LatLng sourceLocation = LatLng(37.333435, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : const Text(
          "Navigation",
          style : TextStyle( color : Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(initialCameraPosition: CameraPosition(target: sourceLocation,zoom: 14.5),)
    );
  }
 
}

