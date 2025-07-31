import 'package:flutter/material.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class ErrandHistoryScreen extends StatefulWidget {
  const ErrandHistoryScreen({super.key});

  @override
  State<ErrandHistoryScreen> createState() => _ErrandHistoryScreenState();
}

class _ErrandHistoryScreenState extends State<ErrandHistoryScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabLabels = ['All', 'Completed', 'Pending', 'Cancelled'];
  
  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: CustomAppBar(title: "Errand History", addLeading: true),
      body: Column(
        children: [
          _buildTabSection(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPastErrandsSection(),
                  const SizedBox(height: 32),
                  _buildSavedLocationsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 12),
            child: SectionTitle(
              title: "Past Errands",
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _tabLabels.length,
                (index) => Padding(
                  padding: EdgeInsets.only(right: index < _tabLabels.length - 1 ? 8 : 0),
                  child: _buildTab(_tabLabels[index], index == _selectedTabIndex, index),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected, int index) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? const Color(0xFFFF6B6B) : Colors.grey[100],
          border: isSelected 
            ? null 
            : Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPastErrandsSection() {
    // Filter errands based on selected tab
    List<Map<String, dynamic>> allErrands = [
      {
        'icon': Icons.shopping_bag_outlined,
        'iconColor': const Color(0xFFFF6B6B),
        'title': 'Grocery Shopping',
        'date': 'Today, 3:30 PM',
        'location': 'Whole Foods Market, 123 Main St, Anytown',
        'status': 'Completed',
        'statusColor': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.local_laundry_service_outlined,
        'iconColor': const Color(0xFFFF6B6B),
        'title': 'Dry Cleaning Pickup',
        'date': 'Yesterday, 10:00 AM',
        'location': 'Cleaners Express, 456 Oak Ave, Anytown',
        'status': 'Completed',
        'statusColor': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.local_shipping_outlined,
        'iconColor': const Color(0xFFFF9800),
        'title': 'Package Drop-off',
        'date': 'Nov 15, 2:00 PM',
        'location': 'UPS Store, 789 Pine Ln, Anytown',
        'status': 'Pending',
        'statusColor': const Color(0xFFFF9800),
      },
      {
        'icon': Icons.build_outlined,
        'iconColor': const Color(0xFFFF6B6B),
        'title': 'Plumbing Repair',
        'date': 'Nov 14, 9:00 AM',
        'location': '101 Maple Dr, Anytown',
        'status': 'Cancelled',
        'statusColor': const Color(0xFFFF6B6B),
      },
      {
        'icon': Icons.library_books_outlined,
        'iconColor': const Color(0xFFFF9800),
        'title': 'Library Book Return',
        'date': 'Nov 13, 1:00 PM',
        'location': 'Community Library, 202 Elm St, Anytown',
        'status': 'Pending',
        'statusColor': const Color(0xFFFF9800),
      },
    ];

    // Filter errands based on selected tab
    List<Map<String, dynamic>> filteredErrands = allErrands;
    if (_selectedTabIndex != 0) { // Not "All"
      String selectedStatus = _tabLabels[_selectedTabIndex];
      filteredErrands = allErrands.where((errand) => errand['status'] == selectedStatus).toList();
    }

    if (filteredErrands.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No ${_tabLabels[_selectedTabIndex].toLowerCase()} errands found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filteredErrands.map((errand) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildErrandCard(
            icon: errand['icon'],
            iconColor: errand['iconColor'],
            title: errand['title'],
            date: errand['date'],
            location: errand['location'],
            status: errand['status'],
            statusColor: errand['statusColor'],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildErrandCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
    required String location,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavedLocationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
SectionTitle(
          title: "Saved Locations",
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle add new location
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add New Location',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLocationCard(
          title: 'Home Address',
          subtitle: 'Home',
          address: '123 Harmony Lane, Suite 4B, Cityville, State 1',
        ),
        const SizedBox(height: 12),
        _buildLocationCard(
          title: 'Main Office',
          subtitle: 'Work',
          address: '789 Business Park, Floor 10, Metro City, State',
        ),
        const SizedBox(height: 12),
        _buildLocationCard(
          title: 'Local Coffee Shop',
          subtitle: '',
          address: '555 Brew Street, Downtown, State 54321',
        ),
      ],
    );
  }

  Widget _buildLocationCard({
    required String title,
    required String subtitle,
    required String address,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle edit location
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle delete location
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}