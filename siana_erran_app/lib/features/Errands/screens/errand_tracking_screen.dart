import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/core/utils/errand_dotted_painter.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';

class ErrandTrackingScreen extends StatefulWidget {
  final ErrandModel errand;
  const ErrandTrackingScreen({super.key, required this.errand});

  @override
  State<ErrandTrackingScreen> createState() => _ErrandTrackingScreenState();
}

class _ErrandTrackingScreenState extends State<ErrandTrackingScreen> {
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
      appBar: CustomAppBar(title: "Track Errand", addLeading: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Section with floating agent profile
            _buildMapWithAgentProfile(),
            
            // Add spacing for the floating profile card
            const SizedBox(height: 150),
            
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
          bottom: -130, // Position it to float below the map
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
            status: _getPickupStatus(),
            statusColor: _getPickupStatusColor(),
          ),

          _buildDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Destination',
            subtitle: currentErrand.destination.displayAddress,
            status: _getDestinationStatus(),
            statusColor: _getDestinationStatusColor(),
          ),

          _buildDetailItem(
            icon: Icons.access_time_outlined,
            title: 'Time',
            subtitle: currentErrand.timeDetails.formattedScheduledTime,
            status: _getTimeStatus(),
            statusColor: _getTimeStatusColor(),
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
              onPressed: _handleErrandInProgress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Errand In Progress',
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

  // Helper methods for status
  String _getPickupStatus() {
    switch (currentErrand.status) {
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

  Color _getPickupStatusColor() {
    switch (currentErrand.status) {
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

  String _getDestinationStatus() {
    switch (currentErrand.status) {
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

  Color _getDestinationStatusColor() {
    switch (currentErrand.status) {
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

  String _getTimeStatus() {
    switch (currentErrand.status) {
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

  Color _getTimeStatusColor() {
    switch (currentErrand.status) {
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

  void _handleErrandInProgress() {
    // Handle errand in progress action
    print('Errand in progress: ${currentErrand.id}');
    // This could show more details, update status, or navigate to detailed tracking
  }

  void _handleSafetyTools() {
    // Open safety tools modal or screen
    _showSafetyToolsModal();
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
              leading: const Icon(Icons.emergency, color: Colors.red),
              title: const Text('Emergency Contacts'),
              subtitle: const Text('Quick access to emergency numbers'),
              onTap: () {
                Navigator.pop(context);
                // Handle emergency contacts
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_location, color: Colors.blue),
              title: const Text('Share Live Location'),
              subtitle: const Text('Share your real-time location'),
              onTap: () {
                Navigator.pop(context);
                // Handle location sharing
              },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: Colors.orange),
              title: const Text('Report Issue'),
              subtitle: const Text('Report safety concerns'),
              onTap: () {
                Navigator.pop(context);
                // Handle issue reporting
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}