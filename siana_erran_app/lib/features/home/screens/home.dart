import 'package:flutter/material.dart';

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
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.menu, color: Colors.black54),
        ),
      ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hi Gao, Ready To Send An Errand?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        CreateErrandButton(),
      ],
    );
  }
}

// Create New Errand Button Widget
class CreateErrandButton extends StatelessWidget {
  const CreateErrandButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 20),
            SizedBox(width: 8),
            Text(
              'Create New Errand',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
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

// Past Errands Section Widget
class PastErrandsSection extends StatelessWidget {
  const PastErrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Past Errands'),
        const SizedBox(height: 16),
        PastErrandItem(
          title: 'Coffee Delivery',
          date: 'Yesterday, 06:15 AM',
          price: '\$8.50',
        ),
        PastErrandItem(
          title: 'Package Drop-off',
          date: 'Jan 24, 2024',
          price: '\$12.00',
        ),
        PastErrandItem(
          title: 'Pharmacy Pickup',
          date: 'Jan 22, 2024',
          price: '\$15.25',
        ),
      ],
    );
  }
}

// Help Section Widget
class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Need Help?'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {},
          child: const Row(
            children: [
              Icon(Icons.headset_mic_outlined, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                'Quick Support & Chat',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

// Active Errand Card Widget
class ActiveErrandCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String status;
  final double progress;
  final String price;
  final Color statusColor;
  final VoidCallback? onTap;

  const ActiveErrandCard({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.status,
    required this.progress,
    required this.price,
    required this.statusColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ErrandIcon(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: ErrandInfo(
                    title: title,
                    status: status,
                    statusColor: statusColor,
                  ),
                ),
                ErrandTimePrice(time: time, price: price),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.black26),
              ],
            ),
            const SizedBox(height: 12),
            ErrandProgressBar(progress: progress, color: statusColor),
          ],
        ),
      ),
    );
  }
}

// Errand Icon Widget
class ErrandIcon extends StatelessWidget {
  final IconData icon;

  const ErrandIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.black54, size: 20),
    );
  }
}

// Errand Info Widget
class ErrandInfo extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;

  const ErrandInfo({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: TextStyle(
            fontSize: 14,
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Errand Time and Price Widget
class ErrandTimePrice extends StatelessWidget {
  final String time;
  final String price;

  const ErrandTimePrice({super.key, required this.time, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}

// Errand Progress Bar Widget
class ErrandProgressBar extends StatelessWidget {
  final double progress;
  final Color color;

  const ErrandProgressBar({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[200],
      valueColor: AlwaysStoppedAnimation<Color>(color),
      minHeight: 4,
    );
  }
}

// Past Errand Item Widget
class PastErrandItem extends StatelessWidget {
  final String title;
  final String date;
  final String price;
  final VoidCallback? onReorder;
  final VoidCallback? onTap;

  const PastErrandItem({
    super.key,
    required this.title,
    required this.date,
    required this.price,
    this.onReorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: PastErrandInfo(title: title, date: date),
            ),
            PastErrandPrice(price: price),
            const SizedBox(width: 8),
            ReorderButton(onPressed: onReorder),
          ],
        ),
      ),
    );
  }
}

// Past Errand Info Widget
class PastErrandInfo extends StatelessWidget {
  final String title;
  final String date;

  const PastErrandInfo({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(date, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }
}

// Past Errand Price Widget
class PastErrandPrice extends StatelessWidget {
  final String price;

  const PastErrandPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

// Reorder Button Widget
class ReorderButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ReorderButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Reorder',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}