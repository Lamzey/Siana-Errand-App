import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:siana_erran_app/features/profile/screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onAvatarTapped;
  final Color backgroundColor;
  final Color titleColor;
  final Color notificationIconColor;
  final Color? avatarBackgroundColor;
  final IconData notificationIcon;
  final IconData avatarIcon;
  final double elevation;
  final bool centerTitle;
  final bool addLeading;
  final bool addProfile;

  const CustomAppBar({
    super.key,
    this.title = 'Home',
    this.onNotificationPressed,
    this.onAvatarTapped,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.notificationIconColor = Colors.black54,
    this.avatarBackgroundColor,
    this.notificationIcon = Icons.notifications_outlined,
    this.avatarIcon = Icons.person,
    this.elevation = 0,
    this.centerTitle = true,
    this.addLeading = false,
    this.addProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: false,
      leading: addLeading
          ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 32,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      actions: [
        IconButton(
          onPressed: onNotificationPressed,
          icon: Icon(notificationIcon, color: notificationIconColor),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onAvatarTapped,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: avatarBackgroundColor ?? Colors.orange[300],
            child: Icon(avatarIcon, color: Colors.white, size: 18),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
