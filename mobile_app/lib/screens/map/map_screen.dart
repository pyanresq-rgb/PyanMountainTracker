import 'package:flutter/material.dart';

// lib/screens/map/map_screen.dart

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Tracking Map'),
        backgroundColor: Color(0xFFb8d600),
      ),
      body: Stack(
        children: [
          // Google Maps will be here
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Text('Google Maps Integration'),
            ),
          ),

          // Floating action button for tracking controls
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color(0xFFb8d600),
              child: Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }
}
