import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/features/home/screens/home.dart';
import 'package:siana_erran_app/features/orders/screens/order_screen.dart';
import 'package:siana_erran_app/features/profile/screens/profile_screen.dart';
import 'package:siana_erran_app/features/settings/screens/setting_screen.dart';
import 'package:siana_erran_app/features/wallet/screens/wallet_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int? initialIndex;

  const BottomNavBar({
    super.key,
    this.initialIndex,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: const Icon(PhosphorIconsRegular.house),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: OrdersScreen(),
          item: ItemConfig(
            icon: const Icon(PhosphorIconsRegular.shoppingBag),
            title: "Orders",
          ),
        ),
        PersistentTabConfig(
          screen: WalletScreen(),
          item: ItemConfig(
            icon: const Icon(PhosphorIconsRegular.wallet),
            title: "Wallet",
          ),
        ),
        PersistentTabConfig(
          screen: ProfileScreen(),
          item: ItemConfig(
            icon: const Icon(PhosphorIconsRegular.user),
            title: "Profile",
          ),
        ),
        PersistentTabConfig(
          screen: SettingsScreen(),
          item: ItemConfig(
            icon: const Icon(PhosphorIconsRegular.gear),
            title: "Settings",
          ),
        ),

      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs(),
      controller: _controller,
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
