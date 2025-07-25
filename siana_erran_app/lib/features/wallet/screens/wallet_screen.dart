import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallet')),
      body: Center(
        child: Text(
          'Wallet Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}