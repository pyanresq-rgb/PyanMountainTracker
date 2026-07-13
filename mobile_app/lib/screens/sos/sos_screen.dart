import 'package:flutter/material.dart';

// lib/screens/sos/sos_screen.dart

class SosScreen extends StatefulWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Emergency'),
        backgroundColor: Color(0xFFb8d600),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Large SOS button
            Container(
              padding: EdgeInsets.all(24),
              child: GestureDetector(
                onLongPress: () {
                  _showSosConfirmation(context);
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'SOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Press & Hold to Send Emergency Alert',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 32),

            // Message input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter emergency message (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 32),

            // Active SOS alerts
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Alerts',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: Text('John Doe - Emergency Alert'),
                      subtitle: Text('Location: 6.2088°N, 106.8456°E'),
                      trailing: Icon(Icons.warning, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSosConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send SOS Alert?'),
        content: Text('This will alert all members in your current group.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Send SOS alert
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('SOS Alert Sent!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Send Alert'),
          ),
        ],
      ),
    );
  }
}
