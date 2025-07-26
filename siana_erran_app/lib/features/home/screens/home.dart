import 'package:flutter/material.dart';
import 'package:siana_erran_app/features/home/widgets/active_erran_card_widget.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/features/home/widgets/past_erran_sections_widget.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

// Main Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            SizedBox(height: 32),
            SectionTitle(title: 'Active Errands', fontSize: 20),
            ActiveErrandsSection(),
            SizedBox(height: 32),
            SectionTitle(title: 'Past Errands', fontSize: 20),
            SizedBox(height: 16),
            PastErrandsSection(),
            SizedBox(height: 32),
            SectionTitle(title: 'Need Help?', fontSize: 20),
            SizedBox(height: 8),
            HelpSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
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






