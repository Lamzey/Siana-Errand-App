import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:siana_erran_app/features/Errands/screens/create_errand_screen.dart';
import 'package:siana_erran_app/features/home/widgets/active_erran_card_widget.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/features/home/widgets/past_erran_sections_widget.dart';
import 'package:siana_erran_app/features/profile/screens/profile_screen.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

// Main Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool minActive = true;
  bool minPast = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        addLeading: false,
        onAvatarTapped: () {
          pushScreen(context, screen: ProfileScreen(addLeading: true));
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SectionTitle(title: 'Active Errands', fontSize: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      minActive = !minActive;
                    });
                  },
                  icon: Icon(
                    minActive
                        ? Icons.arrow_drop_down_rounded
                        : Icons.arrow_drop_up_outlined,
                    size: 32,
                  ),
                ),
              ],
            ),
            Visibility(visible: minActive, child: ActiveErrandsSection()),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SectionTitle(title: 'Past Errands', fontSize: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      minPast = !minPast;
                    });
                  },
                  icon: Icon(
                    minPast
                        ? Icons.arrow_drop_down_rounded
                        : Icons.arrow_drop_up_outlined,
                    size: 32,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Visibility(visible: minPast, child: PastErrandsSection()),
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
        CreateErrandButton(
          onTap: () {
            pushScreenWithNavBar(context, CreateErrandScreen());
          },
        ),
      ],
    );
  }
}
