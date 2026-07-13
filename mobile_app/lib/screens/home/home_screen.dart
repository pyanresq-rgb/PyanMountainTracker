import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// lib/screens/home/home_screen.dart

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override  
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Load user sessions and active tracking
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with user info
              _buildHeader(),
              SizedBox(height: 24),

              // Status indicators
              _buildStatusIndicators(),
              SizedBox(height: 24),

              // Active sessions
              _buildActiveSessions(),
              SizedBox(height: 24),

              // Recent history
              _buildRecentHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Mohd Sufian',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFb8d600),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicators() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Divider(color: Colors.grey[300]),
          SizedBox(height: 12),
          _buildStatusRow(
            icon: Icons.location_on,
            label: 'GPS',
            status: 'ACTIVE',
            isActive: true,
          ),
          SizedBox(height: 12),
          _buildStatusRow(
            icon: Icons.signal_cellular_alt,
            label: 'INTERNET',
            status: 'CONNECTED',
            isActive: true,
          ),
          SizedBox(height: 12),
          _buildStatusRow(
            icon: Icons.cloud,
            label: 'SERVER',
            status: 'CONNECTED',
            isActive: true,
          ),
          SizedBox(height: 12),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildStatusRow({
    required IconData icon,
    required String label,
    required String status,
    required bool isActive,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isActive ? Color(0xFFb8d600) : Colors.grey,
          size: 24,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? Color(0xFFb8d600) : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveSessions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Sessions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mount Semeru Trek',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('Session ID: PMT000001', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('5 Participants', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb8d600),
                      minimumSize: Size(double.infinity, 36),
                    ),
                    child: Text('View Details', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentHistory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Sessions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PMT00000${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '2.5 km • 1h 20m',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
