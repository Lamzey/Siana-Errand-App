import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/models/wallet/payment_model.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class WalletScreen extends StatefulWidget {
  final bool addBackBTN;
  const WalletScreen({super.key, this.addBackBTN = false});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  String? selectedPaymentMethod;
  late TabController _tabController;

  // Sample user payment methods (would come from API)
  final List<UserPaymentMethod> userPaymentMethods = [
    UserPaymentMethod(
      id: '1',
      type: 'mobile_money',
      title: 'MTN Mobile Money',
      details: '0244123456',
      accountName: 'John Doe',
      isVerified: true,
      isDefault: true,
    ),
    UserPaymentMethod(
      id: '2',
      type: 'bank',
      title: 'GCB Bank',
      details: '1234567890',
      accountName: 'John Doe',
      isVerified: true,
      isDefault: false,
    ),
  ];

  final List<PaymentMethodTemplate> availablePaymentTypes = [
    PaymentMethodTemplate(
      id: 'mobile_money',
      name: 'Mobile Money',
      subtitle: 'MTN, Vodafone, AirtelTigo',
      icon: Icons.phone_android,
      color: const Color(0xFF2196F3),
      fields: ['Phone Number', 'Network Provider'],
    ),
    PaymentMethodTemplate(
      id: 'bank',
      name: 'Bank Transfer',
      subtitle: 'Local bank account',
      icon: Icons.account_balance,
      color: const Color(0xFF4CAF50),
      fields: ['Account Number', 'Bank Name', 'Branch'],
    ),
    PaymentMethodTemplate(
      id: 'paystack',
      name: 'Paystack Gateway',
      subtitle: 'Accept cards & online payments',
      icon: Icons.credit_card,
      color: const Color(0xFF0E3B81),
      fields: ['Business Email'],
    ),
    PaymentMethodTemplate(
      id: 'cash',
      name: 'Cash Payment',
      subtitle: 'In-person cash exchange',
      icon: Icons.money,
      color: const Color(0xFFFF9800),
      fields: ['Preferred Location', 'Available Times'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF0E3B81), const Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.swap_horiz,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'P2P Payment Methods',
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
                  'Add your payment details to receive payments from other users',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF0E3B81),
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: const Color(0xFF0E3B81),
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  icon: Icon(Icons.account_balance_wallet),
                  text: 'My Methods',
                ),
                Tab(icon: Icon(Icons.add_circle_outline), text: 'Add New'),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildMyPaymentMethodsTab(), _buildAddNewMethodTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPaymentMethodsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Payment Methods',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              TextButton.icon(
                onPressed: () => _tabController.animateTo(1),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF0E3B81),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (userPaymentMethods.isEmpty)
            _buildEmptyState()
          else
            ...userPaymentMethods.map(
              (method) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildUserPaymentMethodCard(method),
              ),
            ),

          const SizedBox(height: 24),

          // Stats Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0E3B81).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF0E3B81).withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: const Color(0xFF10B981),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Your P2P Activity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                          Text(
                            'Completed Trades',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 30, color: Colors.grey[300]),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '98.5%',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                          Text(
                            'Success Rate',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewMethodTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a payment method to add your details',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),

          const SizedBox(height: 20),

          ...availablePaymentTypes.map(
            (template) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPaymentTemplateCard(template),
            ),
          ),

          const SizedBox(height: 24),

          // Help Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.help_outline, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'How P2P Payments Work',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• Add your payment method details\n'
                  '• Other users can send you payments directly\n'
                  '• You verify and confirm receipt\n'
                  '• Funds are released to complete the transaction',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserPaymentMethodCard(UserPaymentMethod method) {
    final template = availablePaymentTypes.firstWhere(
      (t) => t.id == method.type,
      orElse: () => availablePaymentTypes.first,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: method.isDefault
              ? template.color.withValues(alpha: 0.3)
              : const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: template.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(template.icon, color: template.color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          method.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        if (method.isDefault) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Default',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        if (method.isVerified) ...[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.verified,
                            color: const Color(0xFF10B981),
                            size: 14,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      method.details,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      method.accountName,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Color(0xFF9CA3AF)),
                onSelected: (value) =>
                    _handlePaymentMethodAction(value, method),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 16),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  if (!method.isDefault)
                    const PopupMenuItem(
                      value: 'default',
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 16),
                          SizedBox(width: 8),
                          Text('Set as Default'),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTemplateCard(PaymentMethodTemplate template) {
    return GestureDetector(
      onTap: () => _showAddPaymentMethodForm(template),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
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
                color: template.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(template.icon, color: template.color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    template.subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Required: ${template.fields.join(', ')}',
                    style: TextStyle(
                      fontSize: 12,
                      color: template.color,
                      fontWeight: FontWeight.w500,
                    ),
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

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Payment Methods Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first payment method to start receiving payments from other users',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _tabController.animateTo(1),
            icon: const Icon(Icons.add),
            label: const Text('Add Payment Method'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E3B81),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentMethodAction(String action, UserPaymentMethod method) {
    switch (action) {
      case 'edit':
        _showEditPaymentMethodForm(method);
        break;
      case 'default':
        _setAsDefault(method);
        break;
      case 'delete':
        _deletePaymentMethod(method);
        break;
    }
  }

  void _showAddPaymentMethodForm(PaymentMethodTemplate template) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentMethodFormModal(
        template: template,
        onSave: (data) {
          // Handle saving new payment method
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${template.name} added successfully!'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        },
      ),
    );
  }

  void _showEditPaymentMethodForm(UserPaymentMethod method) {
    final template = availablePaymentTypes.firstWhere(
      (t) => t.id == method.type,
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentMethodFormModal(
        template: template,
        existingMethod: method,
        onSave: (data) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment method updated successfully!'),
              backgroundColor: Color(0xFF10B981),
            ),
          );
        },
      ),
    );
  }

  void _setAsDefault(UserPaymentMethod method) {
    setState(() {
      for (var m in userPaymentMethods) {
        m.isDefault = m.id == method.id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${method.title} set as default'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  void _deletePaymentMethod(UserPaymentMethod method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Payment Method'),
        content: Text('Are you sure you want to delete ${method.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                userPaymentMethods.removeWhere((m) => m.id == method.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment method deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Modal for adding/editing payment methods
class PaymentMethodFormModal extends StatefulWidget {
  final PaymentMethodTemplate template;
  final UserPaymentMethod? existingMethod;
  final Function(Map<String, String>) onSave;

  const PaymentMethodFormModal({
    super.key,
    required this.template,
    this.existingMethod,
    required this.onSave,
  });

  @override
  State<PaymentMethodFormModal> createState() => _PaymentMethodFormModalState();
}

class _PaymentMethodFormModalState extends State<PaymentMethodFormModal> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (String field in widget.template.fields) {
      _controllers[field] = TextEditingController();
    }

    // Add account name field for all methods
    _controllers['Account Name'] = TextEditingController();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.template.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.template.icon,
                    color: widget.template.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add ${widget.template.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.template.fields.map(
                      (field) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          controller: _controllers[field],
                          decoration: InputDecoration(
                            labelText: field,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: widget.template.color,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter $field';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        controller: _controllers['Account Name'],
                        decoration: InputDecoration(
                          labelText: 'Account Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: widget.template.color,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter account name';
                          }
                          return null;
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _savePaymentMethod,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.template.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _savePaymentMethod() {
    if (_formKey.currentState!.validate()) {
      final data = <String, String>{};
      for (var entry in _controllers.entries) {
        data[entry.key] = entry.value.text;
      }
      widget.onSave(data);
    }
  }
}

