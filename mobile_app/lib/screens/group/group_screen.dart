import 'package:flutter/material.dart';

// lib/screens/group/group_screen.dart

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
        backgroundColor: Color(0xFFb8d600),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'My Groups'),
            Tab(text: 'Available'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyGroupsList(),
          _buildAvailableGroups(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFb8d600),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMyGroupsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text('Group ${index + 1}'),
            subtitle: Text('5 members'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildAvailableGroups() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text('Available Group ${index + 1}'),
            subtitle: Text('${index + 2} members • Distance: ${(index + 1) * 5}km'),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text('Join'),
            ),
          ),
        );
      },
    );
  }
}
