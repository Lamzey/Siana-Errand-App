import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:siana_erran_app/features/profile/screens/profile_screen.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class CreateErrandScreen extends StatefulWidget {
  const CreateErrandScreen({super.key});

  @override
  State<CreateErrandScreen> createState() => _CreateErrandScreenState();
}

class _CreateErrandScreenState extends State<CreateErrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        addLeading: true,
        title: "Submit Task",
        onAvatarTapped: () {
          pushScreenWithNavBar(context, ProfileScreen(addLeading: true));
        },
      ),
      body: Column(),
    );
  }
}
