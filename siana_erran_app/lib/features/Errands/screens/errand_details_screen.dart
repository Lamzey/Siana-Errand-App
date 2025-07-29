import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/features/Errands/constants/details_errand_contsants.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class ErrandsDetailsScreen extends StatefulWidget {
  final ErrandModel errand;

  const ErrandsDetailsScreen({super.key, required this.errand});

  @override
  State<ErrandsDetailsScreen> createState() => _ErrandsDetailsScreenState();
}

class _ErrandsDetailsScreenState extends State<ErrandsDetailsScreen> {
  late ErrandModel currentErrand;

  @override
  void initState() {
    super.initState();
    currentErrand = widget.errand;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Errand Details", addLeading: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Section with floating agent profile
            _buildMapWithAgentProfile(),
            
            // Add spacing for the floating profile card
            const SizedBox(height: 90), // Adjust based on profile card height
            
            // Errand Details Section
            _buildErrandDetailsSection(),

            const SizedBox(height: 8),

            // Payment Information Section
            _buildPaymentSection(),

            const SizedBox(height: 8),

            // Share & Safety Section
            _buildShareSafetySection(),

            const SizedBox(height: 24),

            // Action Button (Complete/Cancel based on status)
            _buildMainActionButton(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMapWithAgentProfile() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Map Section
        _buildMapSection(),

        // Floating Agent Profile Section
        Positioned(
          left: 12,
          right: 12,
          bottom: -85, // Position it to float below the map
          child: _buildAgentProfileSection(),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage('${imagePath}maps.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
      
          // Pickup location marker
          const Positioned(
            left: 60,
            top: 80,
            child: Icon(Icons.location_on, color: Colors.red, size: 30),
          ),
          // Destination marker
          const Positioned(
            right: 80,
            top: 60,
            child: Icon(Icons.location_on, color: Colors.blue, size: 30),
          ),
          // Route line
          Positioned(
            left: 75,
            top: 95,
            right: 95,
            child: CustomPaint(
              painter: DottedLinePainter(),
              size: const Size(double.infinity, 2),
            ),
          ),
          // Vehicle icon
          const Positioned(
            left: 70,
            bottom: 80,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black,
              child: Icon(Icons.directions_car, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentProfileSection() {
    final agent = currentErrand.agent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
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
                    style: TextStyle(
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
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
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
            child: Text(
              'Errand Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          _buildDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Pickup Location',
            subtitle: currentErrand.pickupLocation.displayAddress,
            status: _getLocationStatus(isPickup: true),
            statusColor: _getLocationStatusColor(isPickup: true),
          ),

          _buildDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Destination',
            subtitle: currentErrand.destination.displayAddress,
            status: _getLocationStatus(isPickup: false),
            statusColor: _getLocationStatusColor(isPickup: false),
          ),

          _buildDetailItem(
            icon: Icons.access_time_outlined,
            title: 'Time',
            subtitle: currentErrand.timeDetails.formattedScheduledTime,
            status: currentErrand.status.displayName,
            statusColor: currentErrand.status.statusColor,
            showDuration: true,
            duration: currentErrand.timeDetails.durationText,
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
            child: Text(
              'Payment Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
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
                        'Payment Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${payment.formattedAmount} - ${payment.paymentMethodDisplay}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
            child: Text(
              'Share & Safety',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
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
                      Text(
                        'Let friends and family track your progress.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _handleShareErrand,
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
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

  Widget _buildMainActionButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleMainAction,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getMainActionColor(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            _getMainActionText(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
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
                    color: Colors.black87,
                  ),
                ),
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

  // Helper methods
  String _getLocationStatus({required bool isPickup}) {
    switch (currentErrand.status) {
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

  Color _getLocationStatusColor({required bool isPickup}) {
    switch (currentErrand.status) {
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

  String _getMainActionText() {
    switch (currentErrand.status) {
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

  Color _getMainActionColor() {
    switch (currentErrand.status) {
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
    // Share errand details
    // share_plus package implementation
    print('Share errand: ${currentErrand.id}');
  }

  void _handleMainAction() {
    switch (currentErrand.status) {
      case ErrandStatus.completed:
        _markAsCompleted();
        break;
      case ErrandStatus.cancelled:
        // Do nothing or show info
        break;
      case ErrandStatus.pending:
      case ErrandStatus.assigned:
        _showCancelDialog();
        break;
      default:
        _trackErrand();
        break;
    }
  }

  void _markAsCompleted() {
    // Update errand status and navigate back
    setState(() {
      currentErrand = currentErrand.copyWith(
        status: ErrandStatus.completed,
        completedAt: DateTime.now(),
      );
    });
    Navigator.pop(context, currentErrand);
  }

  void _showCancelDialog() {
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
              _cancelErrand();
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _cancelErrand() {
    setState(() {
      currentErrand = currentErrand.copyWith(status: ErrandStatus.cancelled);
    });
  }

  void _trackErrand() {
    // Navigate to tracking screen
    // Navigator.pushNamed(context, '/track', arguments: currentErrand);
    print('Track errand: ${currentErrand.id}');
  }
}

// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Example usage and navigation
class ExampleErrandListScreen extends StatelessWidget {
  const ExampleErrandListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Errands')),
      body: ListView.builder(
        itemCount: sampleErrands.length,
        itemBuilder: (context, index) {
          final errand = sampleErrands[index];
          return ErrandListTile(
            errand: errand,
            onTap: () => _navigateToErrandDetails(context, errand),
          );
        },
      ),
    );
  }

  void _navigateToErrandDetails(BuildContext context, ErrandModel errand) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ErrandsDetailsScreen(errand: errand),
      ),
    ).then((updatedErrand) {
      // Handle any updates when returning from details screen
      if (updatedErrand != null && updatedErrand is ErrandModel) {
        // Update your state management here (Provider, Bloc, etc.)
        print('Errand updated: ${updatedErrand.status}');
      }
    });
  }
}

// Custom ErrandListTile widget for the list screen
class ErrandListTile extends StatelessWidget {
  final ErrandModel errand;
  final VoidCallback onTap;

  const ErrandListTile({super.key, required this.errand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: errand.status.statusColor.withOpacity(0.1),
          child: Icon(_getStatusIcon(), color: errand.status.statusColor),
        ),
        title: Text(
          errand.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(errand.description),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  errand.agent.name,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 12),
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  errand.timeDetails.formattedScheduledTime,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: errand.status.statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                errand.status.displayName,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: errand.status.statusColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              errand.payment.formattedAmount,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (errand.status) {
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
