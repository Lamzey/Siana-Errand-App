import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/core/utils/errand_dotted_painter.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class CompletedErrandScreen extends StatefulWidget {
  final ErrandModel errand;
  const CompletedErrandScreen({super.key, required this.errand});

  @override
  State<CompletedErrandScreen> createState() => _CompletedErrandScreenState();
}

class _CompletedErrandScreenState extends State<CompletedErrandScreen>
    with TickerProviderStateMixin {
  late ErrandModel currentErrand;
  late AnimationController _checkAnimationController;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    currentErrand = widget.errand;
    
    // Initialize animation for the success checkmark
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _checkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkAnimationController,
      curve: Curves.elasticOut,
    ));
    
    // Start animation after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _checkAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _checkAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Task Completion", addLeading: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Success Indicator Section
            _buildSuccessIndicator(),
            
            const SizedBox(height: 32),
            
            // Agent Profile Section (without map)
            _buildAgentProfileSection(),
            
            const SizedBox(height: 24),
            
            // Errand Details Section
            _buildErrandDetailsSection(),

            const SizedBox(height: 8),

            // Payment Information Section
            _buildPaymentSection(),

            const SizedBox(height: 8),

            // Share & Safety Section
            _buildShareSafetySection(),

            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtonsSection(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          // Animated Success Checkmark
          AnimatedBuilder(
            animation: _checkAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _checkAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          // Success Text
          const Text(
            'Order Complete',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Your errand has been completed successfully',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAgentProfileSection() {
    final agent = currentErrand.agent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.orange[200],
                backgroundImage: agent.profileImage.isNotEmpty
                    ? NetworkImage(agent.profileImage)
                    : null,
                child: agent.profileImage.isEmpty
                    ? const Icon(Icons.person, color: Colors.white, size: 30)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          ' ${agent.ratingText}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    agent.agentCode,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    agent.vehicle.displayName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 12),
          _buildContactButtons(),
        ],
      ),
    );
  }

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              _handleChatWithAgent();
            },
            icon: Icon(PhosphorIcons.chatCircle()),
            label: const Text(
              'Chat with Agent',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              side: BorderSide(color: Colors.grey[300]!),
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              _handleCallAgent();
            },
            icon: Icon(PhosphorIcons.phone()),
            label: const Text(
              'Call Agent',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              side: BorderSide(color: Colors.grey[300]!),
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrandDetailsSection() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: SectionTitle(title: "Errand Details"),
          ),

          _buildDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Pickup Location',
            subtitle: currentErrand.pickupLocation.displayAddress,
            status: 'Complete',
            statusColor: Colors.green,
          ),

          _buildDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Destination',
            subtitle: currentErrand.destination.displayAddress,
            status: 'Complete',
            statusColor: Colors.green,
          ),

          _buildDetailItem(
            icon: Icons.access_time_outlined,
            title: 'Time',
            subtitle: currentErrand.timeDetails.formattedScheduledTime,
            status: 'Complete',
            statusColor: Colors.green,
            showDuration: true,
            duration: currentErrand.timeDetails.durationText,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
    bool showDuration = false,
    String? duration,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (showDuration && duration != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    final payment = currentErrand.payment;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: SectionTitle(title: "Payment Information"),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estimated Cost',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${payment.formattedAmount} - ${payment.paymentMethodDisplay}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildShareSafetySection() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: SectionTitle(title: "Share & Safety"),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.share_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share Errand Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Let friends and family track your progress.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _handleShareErrand,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _handleMakePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Make Payment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _handleSafetyTools,
              icon: const Icon(Icons.security, size: 18),
              label: const Text(
                'Safety Tools',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.grey[300]!),
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Action handlers
  void _handleChatWithAgent() {
    // Navigate to chat screen or open chat functionality
    // Navigator.pushNamed(context, '/chat', arguments: currentErrand.agent);
    print('Chat with agent: ${currentErrand.agent.name}');
  }

  void _handleCallAgent() {
    // Make phone call or show call dialog
    // url_launcher to make phone call
    print('Call agent: ${currentErrand.agent.phoneNumber}');
  }

  void _handleShareErrand() {
    // Share completion status
    print('Share completed errand: ${currentErrand.id}');
  }

  void _handleMakePayment() {
    // Navigate to payment screen or process payment
    _showPaymentModal();
  }

  void _handleSafetyTools() {
    // Open safety tools modal
    _showSafetyToolsModal();
  }

  void _showPaymentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Payment Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            
            // Payment details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Errand Fee:'),
                      Text(currentErrand.payment.formattedAmount),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service Fee:'),
                      Text('\$2.50'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        currentErrand.payment.formattedAmount,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _processPayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Complete Payment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showSafetyToolsModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Safety Tools',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.rate_review, color: Colors.blue),
              title: const Text('Rate Agent'),
              subtitle: const Text('Rate your experience with the agent'),
              onTap: () {
                Navigator.pop(context);
                _showRatingDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.green),
              title: const Text('Download Receipt'),
              subtitle: const Text('Get your errand receipt'),
              onTap: () {
                Navigator.pop(context);
                _downloadReceipt();
              },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: Colors.orange),
              title: const Text('Report Issue'),
              subtitle: const Text('Report any concerns'),
              onTap: () {
                Navigator.pop(context);
                _reportIssue();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    // Process payment logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment processed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate Your Agent'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How was your experience with ${currentErrand.agent.displayName}?'),
            const SizedBox(height: 16),
            // Star rating could go here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => 
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Submit rating
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt() {
    // Download receipt logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Receipt downloaded successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _reportIssue() {
    // Navigate to issue reporting screen
    print('Report issue for errand: ${currentErrand.id}');
  }
}