import 'package:flutter/material.dart';
import 'package:siana_erran_app/features/home/widgets/active_erran_card_widget.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/features/home/widgets/past_erran_sections_widget.dart';

// Main Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            SizedBox(height: 32),
            ActiveErrandsSection(),
            SizedBox(height: 32),
            PastErrandsSection(),
            SizedBox(height: 32),
            HelpSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Custom App Bar Widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        'Home',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: const [
        NotificationButton(),
        SizedBox(width: 8),
        UserAvatar(),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Notification Button Widget
class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
    );
  }
}

// User Avatar Widget
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.orange[300],
      child: const Icon(Icons.person, color: Colors.white, size: 18),
    );
  }
}

// Greeting Section Widget
class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Hi Gao, Ready To Send An Errand?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 40),
        CreateErrandButton(),
      ],
    );
  }
}



// Active Errands Section Widget
class ActiveErrandsSection extends StatelessWidget {
  const ActiveErrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Active Errands'),
        const SizedBox(height: 16),
        ActiveErrandCard(
          icon: Icons.shopping_cart_outlined,
          title: 'Grocery Delivery',
          time: '10:30 AM',
          status: 'In Progress',
          progress: 0.6,
          price: 'ETB 15 min',
          statusColor: Colors.blue,
        ),
        const SizedBox(height: 12),
        ActiveErrandCard(
          icon: Icons.description_outlined,
          title: 'Document Pickup',
          time: '12:00 PM',
          status: 'Pending',
          progress: 0.3,
          price: 'ETB 30 min',
          statusColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        ActiveErrandCard(
          icon: Icons.local_laundry_service_outlined,
          title: 'Laundry Service',
          time: '04:45 PM',
          status: 'In Progress',
          progress: 0.8,
          price: 'ETB 45 min',
          statusColor: Colors.blue,
        ),
      ],
    );
  }
}


