import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/features/Errands/widgets/errands_widgets.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

// Status Helper Class
class ErrandStatusHelper {
  // Location Status Methods
  static String getLocationStatus(ErrandStatus status, {required bool isPickup}) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return 'Pending';
      case ErrandStatus.inProgress:
        return isPickup ? 'In Progress' : 'Pending';
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return 'Complete';
      case ErrandStatus.cancelled:
        return 'Cancelled';
    }
  }

  static Color getLocationStatusColor(ErrandStatus status, {required bool isPickup}) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return Colors.orange;
      case ErrandStatus.inProgress:
        return isPickup ? Colors.blue : Colors.orange;
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return Colors.green;
      case ErrandStatus.cancelled:
        return Colors.red;
    }
  }

  // Pickup Specific Status
  static String getPickupStatus(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return 'Pending';
      case ErrandStatus.inProgress:
        return 'Started';
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return 'Complete';
      case ErrandStatus.cancelled:
        return 'Cancelled';
    }
  }

  static Color getPickupStatusColor(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return Colors.orange;
      case ErrandStatus.inProgress:
        return Colors.green;
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return Colors.green;
      case ErrandStatus.cancelled:
        return Colors.red;
    }
  }

  // Destination Specific Status
  static String getDestinationStatus(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
      case ErrandStatus.inProgress:
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
        return 'Pending';
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return 'Complete';
      case ErrandStatus.cancelled:
        return 'Cancelled';
    }
  }

  static Color getDestinationStatusColor(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
      case ErrandStatus.inProgress:
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
        return Colors.orange;
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return Colors.green;
      case ErrandStatus.cancelled:
        return Colors.red;
    }
  }

  // Time Status
  static String getTimeStatus(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
      case ErrandStatus.inProgress:
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
        return 'Pending';
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return 'Complete';
      case ErrandStatus.cancelled:
        return 'Cancelled';
    }
  }

  static Color getTimeStatusColor(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
      case ErrandStatus.inProgress:
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
        return Colors.orange;
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return Colors.green;
      case ErrandStatus.cancelled:
        return Colors.red;
    }
  }

  // Main Action Button Text & Color
  static String getMainActionText(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.completed:
        return 'Mark as Completed';
      case ErrandStatus.cancelled:
        return 'Errand Cancelled';
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return 'Cancel Errand';
      default:
        return 'Track Errand';
    }
  }

  static Color getMainActionColor(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.completed:
        return Colors.green;
      case ErrandStatus.cancelled:
        return Colors.grey;
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        return Colors.red;
      default:
        return Colors.black87;
    }
  }

  // Status Icon for List Items
  static IconData getStatusIcon(ErrandStatus status) {
    switch (status) {
      case ErrandStatus.pending:
        return Icons.schedule;
      case ErrandStatus.assigned:
        return Icons.person_add;
      case ErrandStatus.inProgress:
      case ErrandStatus.pickupComplete:
      case ErrandStatus.inTransit:
        return Icons.local_shipping;
      case ErrandStatus.delivered:
      case ErrandStatus.completed:
        return Icons.check_circle;
      case ErrandStatus.cancelled:
        return Icons.cancel;
    }
  }
}

// Action Handlers Mixin
mixin ErrandActionHandlers {
  void handleChatWithAgent(ErrandModel errand) {
    // Navigate to chat screen or open chat functionality
    // Navigator.pushNamed(context, '/chat', arguments: errand.agent);
    print('Chat with agent: ${errand.agent.name}');
  }

  void handleCallAgent(ErrandModel errand) {
    // Make phone call or show call dialog
    // url_launcher to make phone call
    print('Call agent: ${errand.agent.phoneNumber}');
  }

  void handleShareErrand(ErrandModel errand) {
    // Share errand details
    // share_plus package implementation
    print('Share errand: ${errand.id}');
  }

  void showCancelDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Errand'),
        content: const Text('Are you sure you want to cancel this errand?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void showSafetyToolsModal(
    BuildContext context, {
    VoidCallback? onEmergencyContacts,
    VoidCallback? onShareLocation,
    VoidCallback? onReportIssue,
    VoidCallback? onRateAgent,
    VoidCallback? onDownloadReceipt,
    bool showRatingOptions = false,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafetyToolsModal(
        onEmergencyContacts: onEmergencyContacts != null
            ? () {
                Navigator.pop(context);
                onEmergencyContacts();
              }
            : null,
        onShareLocation: onShareLocation != null
            ? () {
                Navigator.pop(context);
                onShareLocation();
              }
            : null,
        onReportIssue: onReportIssue != null
            ? () {
                Navigator.pop(context);
                onReportIssue();
              }
            : null,
        onRateAgent: onRateAgent != null
            ? () {
                Navigator.pop(context);
                onRateAgent();
              }
            : null,
        onDownloadReceipt: onDownloadReceipt != null
            ? () {
                Navigator.pop(context);
                onDownloadReceipt();
              }
            : null,
        showRatingOptions: showRatingOptions,
      ),
    );
  }

  void showPaymentModal(BuildContext context, ErrandModel errand, VoidCallback onPaymentComplete) {
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
                      Text(errand.payment.formattedAmount),
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
                        errand.payment.formattedAmount,
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
                  onPaymentComplete();
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

  void showRatingDialog(BuildContext context, ErrandModel errand, Function(int rating) onRatingSubmitted) {
    int selectedRating = 5;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Rate Your Agent'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How was your experience with ${errand.agent.displayName}?'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      color: index < selectedRating ? Colors.amber : Colors.grey[300],
                      size: 30,
                    ),
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
                onRatingSubmitted(selectedRating);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

// Common Screen Layout Builder
class ErrandScreenLayout extends StatelessWidget {
  final String title;
  final Widget? topSection;
  final ErrandModel errand;
  final VoidCallback? onChatPressed;
  final VoidCallback? onCallPressed;
  final List<Widget>? actionButtons;
  final bool showMapWithAgent;
  final double? mapHeight;
  final VoidCallback? onSharePressed;
  final String? paymentStatusText;
  final Color? paymentStatusColor;

  const ErrandScreenLayout({
    super.key,
    required this.title,
    required this.errand,
    this.topSection,
    this.onChatPressed,
    this.onCallPressed,
    this.actionButtons,
    this.showMapWithAgent = true,
    this.mapHeight,
    this.onSharePressed,
    this.paymentStatusText,
    this.paymentStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: title, addLeading: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section (Success indicator, Map with Agent Profile, etc.)
            if (topSection != null) ...[
              topSection!,
            ] else if (showMapWithAgent) ...[
              MapWithAgentProfile(
                errand: errand,
                onChatPressed: onChatPressed,
                onCallPressed: onCallPressed,
                mapHeight: mapHeight,
              ),
              const SizedBox(height: 150), // Space for floating profile
            ],
            
            // Errand Details Section
            _buildErrandDetailsSection(),

            const SizedBox(height: 8),

            // Payment Information Section
            PaymentInformationSection(
              errand: errand,
              statusText: paymentStatusText,
              statusColor: paymentStatusColor,
            ),

            const SizedBox(height: 8),

            // Share & Safety Section
            ShareSafetySection(
              onSharePressed: onSharePressed,
            ),

            const SizedBox(height: 24),

            // Action Buttons
            if (actionButtons != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: actionButtons!,
                ),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
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

          ErrandDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Pickup Location',
            subtitle: errand.pickupLocation.displayAddress,
            status: ErrandStatusHelper.getLocationStatus(errand.status, isPickup: true),
            statusColor: ErrandStatusHelper.getLocationStatusColor(errand.status, isPickup: true),
          ),

          ErrandDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Destination',
            subtitle: errand.destination.displayAddress,
            status: ErrandStatusHelper.getLocationStatus(errand.status, isPickup: false),
            statusColor: ErrandStatusHelper.getLocationStatusColor(errand.status, isPickup: false),
          ),

          ErrandDetailItem(
            icon: Icons.access_time_outlined,
            title: 'Time',
            subtitle: errand.timeDetails.formattedScheduledTime,
            status: ErrandStatusHelper.getTimeStatus(errand.status),
            statusColor: ErrandStatusHelper.getTimeStatusColor(errand.status),
            showDuration: true,
            duration: errand.timeDetails.durationText,
          ),
        ],
      ),
    );
  }
}

// Success Indicator Widget (for completed errands)
class SuccessIndicator extends StatefulWidget {
  final String title;
  final String subtitle;

  const SuccessIndicator({
    super.key,
    this.title = 'Order Complete',
    this.subtitle = 'Your errand has been completed successfully',
  });

  @override
  State<SuccessIndicator> createState() => _SuccessIndicatorState();
}

class _SuccessIndicatorState extends State<SuccessIndicator>
    with TickerProviderStateMixin {
  late AnimationController _checkAnimationController;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    
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
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            widget.subtitle,
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
}

// Import the SafetyToolsModal widget that we need
// (This should be imported from the widgets file)