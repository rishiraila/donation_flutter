import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'donors.dart';
import 'donors_details.dart';
import 'reports.dart';

class AdminDashboard extends StatefulWidget {
  final String adminName;

  const AdminDashboard({Key? key, required this.adminName}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  int? _hoveredIndex;

  final List<Widget> _tabs = [
    DashboardTab(),
    DonorsPage(),
    DonorDetailsAdminPage(),
    ReportsPage(),
  ];

  final List<String> _tabTitles = [
    'Dashboard',
    'Donors',
    'Donor Details',
    'Reports',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onLogout() {
    Navigator.pop(context); // Or use Navigator.pushReplacement
  }

  void _onTabSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (MediaQuery.of(context).size.width < 600) {
      Navigator.pop(context); // Close drawer on mobile
    }
  }

  Widget buildSidebar() {
    return Container(
      width: 220,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Welcome ${widget.adminName}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildTabButton('Dashboard', 0, icon: Icons.dashboard),
          buildTabButton('Donors', 1, icon: Icons.people),
          buildTabButton('Transaction Details', 2, icon: Icons.info_outline),
          buildTabButton('Reports', 3, icon: Icons.bar_chart),
          const Spacer(),
          buildTabButton('Logout', -1, icon: Icons.logout, isLogout: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildTabButton(
  String title,
  int index, {
  bool isLogout = false,
  required IconData icon,
}) {
  bool isSelected = _selectedIndex == index;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLogout ? _onLogout : () => _onTabSelect(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.red
                : Colors.transparent, // active tab is red
            borderRadius: BorderRadius.circular(30), // rounded pill shape
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
      onEnter: (event) {
        setState(() {
          _hoveredIndex = index;
        });
      },
      onExit: (event) {
        setState(() {
          _hoveredIndex = null;
        });
      },
    ),
  );
}


  AppBar buildTopBar(bool isMobile) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          Text(
            _tabTitles[_selectedIndex],
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: _onLogout,
          tooltip: 'Logout',
        ),
        const SizedBox(width: 8),
      ],
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

 @override
Widget build(BuildContext context) {
  bool isMobile = MediaQuery.of(context).size.width < 600;

  return Scaffold(
    key: _scaffoldKey,
    drawer: isMobile ? Drawer(child: buildSidebar()) : null,
    appBar: isMobile
        ? AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              _tabTitles[_selectedIndex],
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.red),
                onPressed: _onLogout,
                tooltip: 'Logout',
              ),
            ],
          )
        : null,
    body: Row(
      children: [
        // ✅ Sidebar
        if (!isMobile) buildSidebar(),

        // ✅ Main Content with topbar aligned after sidebar
        Expanded(
          child: Column(
            children: [
              if (!isMobile)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _tabTitles[_selectedIndex],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        onPressed: _onLogout,
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                ),

              // ✅ Main Page Content
              Expanded(
                child: _tabs[_selectedIndex],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
