import 'package:flutter/material.dart';

import 'package:siana_erran_app/core/models/wallet/payment_model.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class WalletScreen extends StatefulWidget {
  final bool addBackBTN;
  const WalletScreen({super.key, this.addBackBTN = false});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String? selectedPaymentMethod;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'paystack',
      name: 'Paystack',
      subtitle: 'Secure online payment',
      icon: Icons.credit_card,
      color: const Color(0xFF0E3B81),
      isPrimary: true,
    ),
    PaymentMethod(
      id: 'mobile_money',
      name: 'Mobile Money',
      subtitle: 'MTN, Vodafone, AirtelTigo',
      icon: Icons.phone_android,
      color: const Color(0xFF2196F3),
    ),
    PaymentMethod(
      id: 'bank_transfer',
      name: 'Bank Transfer',
      subtitle: 'Direct bank account payment',
      icon: Icons.account_balance,
      color: const Color(0xFF4CAF50),
    ),
    PaymentMethod(
      id: 'cash_delivery',
      name: 'Cash on Delivery',
      subtitle: 'Pay when you receive the item',
      icon: Icons.local_shipping,
      color: const Color(0xFFFF9800),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: "Payment Methods",
        addLeading: widget.addBackBTN,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0E3B81),
                          const Color(0xFF1565C0),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Select Payment Method',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose your preferred way to pay securely',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Primary Payment Method
                  const Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildPaymentMethodCard(paymentMethods[0]),

                  const SizedBox(height: 24),

                  // Other Payment Methods
                  const Text(
                    'Other Payment Options',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...paymentMethods
                      .skip(1)
                      .map(
                        (method) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildPaymentMethodCard(method),
                        ),
                      ),

                  const SizedBox(height: 32),

                  // Add New Payment Method
                  _buildAddNewPaymentCard(),
                ],
              ),
            ),
          ),

          // Bottom Action Button
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: selectedPaymentMethod != null
                      ? () => _handleContinuePayment()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E3B81),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: const Color(0xFFE0E0E0),
                  ),
                  child: Text(
                    selectedPaymentMethod != null
                        ? 'Continue with ${_getSelectedMethodName()}'
                        : 'Select a Payment Method',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    final isSelected = selectedPaymentMethod == method.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method.id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? method.color : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? method.color.withOpacity(0.1)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: method.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(method.icon, color: method.color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      if (method.isPrimary) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Recommended',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    method.subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? method.color : const Color(0xFFD1D5DB),
                  width: 2,
                ),
                color: isSelected ? method.color : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewPaymentCard() {
    return GestureDetector(
      onTap: () => _showAddPaymentMethodDialog(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: Color(0xFF6B7280), size: 24),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Payment Method',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Connect your bank account or card',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }

  String _getSelectedMethodName() {
    final method = paymentMethods.firstWhere(
      (m) => m.id == selectedPaymentMethod,
      orElse: () => paymentMethods.first,
    );
    return method.name;
  }

  void _handleContinuePayment() {
    // Handle payment continuation logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Proceeding with ${_getSelectedMethodName()}'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  void _showAddPaymentMethodDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Add New Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.credit_card,
                        color: Color(0xFF0E3B81),
                      ),
                      title: const Text('Add Credit/Debit Card'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.account_balance,
                        color: Color(0xFF4CAF50),
                      ),
                      title: const Text('Link Bank Account'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.phone_android,
                        color: Color(0xFF2196F3),
                      ),
                      title: const Text('Add Mobile Money'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
