import 'package:flutter/material.dart';

// lib/screens/profile/profile_screen.dart

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFb8d600),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: EdgeInsets.all(24),
              color: Color(0xFFb8d600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Color(0xFFb8d600)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Mohd Sufian',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'mohd.sufian@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Profile info
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem('Phone', '+60123456789'),
                  Divider(),
                  _buildProfileItem('IC Number', '900101-01-1234'),
                  Divider(),
                  _buildProfileItem('Date of Birth', '1990-01-01'),
                  Divider(),
                  _buildProfileItem('Emergency Contact', '+60987654321'),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb8d600),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
