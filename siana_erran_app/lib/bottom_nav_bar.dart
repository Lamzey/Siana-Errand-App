import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/features/Errands/screens/errand_history.dart';
import 'package:siana_erran_app/features/home/screens/home.dart';
import 'package:siana_erran_app/features/orders/screens/order_screen.dart';
import 'package:siana_erran_app/features/profile/screens/profile_screen.dart';
import 'package:siana_erran_app/features/settings/screens/setting_screen.dart';
import 'package:siana_erran_app/features/wallet/screens/wallet_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int? initialIndex;

  const BottomNavBar({super.key, this.initialIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
    clearHistoryOnInitialIndex: true,
  );

  List<PersistentTabConfig> _tabs() => [
    PersistentTabConfig(
      screen: HomeScreen(),
      item: ItemConfig(
        inactiveForegroundColor: Colors.grey.shade500,
        icon: const Icon(PhosphorIconsRegular.house),
        title: "Home",
      ),
    ),
    PersistentTabConfig(
      screen: OrdersScreen(),
      item: ItemConfig(
        inactiveForegroundColor: Colors.grey.shade500,
        icon: const Icon(PhosphorIconsRegular.shoppingBag),
        title: "Orders",
      ),
    ),
    PersistentTabConfig(
      screen: WalletScreen(),
      item: ItemConfig(
        inactiveForegroundColor: Colors.grey.shade500,
        icon: const Icon(PhosphorIconsRegular.wallet),
        title: "Wallet",
      ),
    ),
    PersistentTabConfig(
      screen: ProfileScreen(),
      item: ItemConfig(
        inactiveForegroundColor: Colors.grey.shade500,
        icon: const Icon(PhosphorIconsRegular.user),
        title: "Profile",
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs(),
      controller: _controller,
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          padding: EdgeInsets.only(left: 10, right: 10),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
