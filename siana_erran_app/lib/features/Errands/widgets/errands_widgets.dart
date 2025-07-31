import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';
import 'package:siana_erran_app/core/utils/errand_dotted_painter.dart';
import 'package:siana_erran_app/features/home/widgets/others_widgets.dart';

// Common Agent Profile Card Widget
class AgentProfileCard extends StatelessWidget {
  final ErrandModel errand;
  final VoidCallback? onChatPressed;
  final VoidCallback? onCallPressed;
  final bool showContactButtons;

  const AgentProfileCard({
    super.key,
    required this.errand,
    this.onChatPressed,
    this.onCallPressed,
    this.showContactButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    final agent = errand.agent;

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
          if (showContactButtons) ...[
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            AgentContactButtons(
              onChatPressed: onChatPressed,
              onCallPressed: onCallPressed,
            ),
          ],
        ],
      ),
    );
  }
}

// Agent Contact Buttons Widget
class AgentContactButtons extends StatelessWidget {
  final VoidCallback? onChatPressed;
  final VoidCallback? onCallPressed;

  const AgentContactButtons({
    super.key,
    this.onChatPressed,
    this.onCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onChatPressed,
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
            onPressed: onCallPressed,
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
}

// Map Section Widget
class ErrandMapSection extends StatelessWidget {
  final double? height;
  final bool showRoute;

  const ErrandMapSection({
    super.key,
    this.height,
    this.showRoute = true,
  });

  @override
  Widget build(BuildContext context) {
    final mapHeight = height ?? MediaQuery.sizeOf(context).height * 0.25;

    return Container(
      height: mapHeight,
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
          if (showRoute) ...[
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
        ],
      ),
    );
  }
}

// Map with Floating Agent Profile Widget
class MapWithAgentProfile extends StatelessWidget {
  final ErrandModel errand;
  final VoidCallback? onChatPressed;
  final VoidCallback? onCallPressed;
  final double? mapHeight;
  final bool showContactButtons;

  const MapWithAgentProfile({
    super.key,
    required this.errand,
    this.onChatPressed,
    this.onCallPressed,
    this.mapHeight,
    this.showContactButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Map Section
        ErrandMapSection(height: mapHeight),

        // Floating Agent Profile Section
        Positioned(
          left: 12,
          right: 12,
          bottom: -130, // Position it to float below the map
          child: AgentProfileCard(
            errand: errand,
            onChatPressed: onChatPressed,
            onCallPressed: onCallPressed,
            showContactButtons: showContactButtons,
          ),
        ),
      ],
    );
  }
}

// Errand Detail Item Widget
class ErrandDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final bool showDuration;
  final String? duration;

  const ErrandDetailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    this.showDuration = false,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
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
                    duration!,
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
}

// Payment Information Section Widget
class PaymentInformationSection extends StatelessWidget {
  final ErrandModel errand;
  final String? statusText;
  final Color? statusColor;

  const PaymentInformationSection({
    super.key,
    required this.errand,
    this.statusText,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final payment = errand.payment;
    final defaultStatusText = statusText ?? 'Pending';
    final defaultStatusColor = statusColor ?? Colors.orange;

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
                        'Payment Details',
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
                    color: defaultStatusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    defaultStatusText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: defaultStatusColor,
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
}

// Share & Safety Section Widget
class ShareSafetySection extends StatelessWidget {
  final VoidCallback? onSharePressed;

  const ShareSafetySection({
    super.key,
    this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: onSharePressed,
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
}

// Custom Action Button Widget
class CustomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool isOutlined;

  const CustomActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: Colors.grey[300]!),
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

// Status Badge Widget
class StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const StatusBadge({
    super.key,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

// Safety Tools Modal Widget
class SafetyToolsModal extends StatelessWidget {
  final VoidCallback? onEmergencyContacts;
  final VoidCallback? onShareLocation;
  final VoidCallback? onReportIssue;
  final VoidCallback? onRateAgent;
  final VoidCallback? onDownloadReceipt;
  final bool showRatingOptions;

  const SafetyToolsModal({
    super.key,
    this.onEmergencyContacts,
    this.onShareLocation,
    this.onReportIssue,
    this.onRateAgent,
    this.onDownloadReceipt,
    this.showRatingOptions = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          
          if (showRatingOptions) ...[
            ListTile(
              leading: const Icon(Icons.rate_review, color: Colors.blue),
              title: const Text('Rate Agent'),
              subtitle: const Text('Rate your experience with the agent'),
              onTap: onRateAgent,
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.green),
              title: const Text('Download Receipt'),
              subtitle: const Text('Get your errand receipt'),
              onTap: onDownloadReceipt,
            ),
          ] else ...[
            ListTile(
              leading: const Icon(Icons.emergency, color: Colors.red),
              title: const Text('Emergency Contacts'),
              subtitle: const Text('Quick access to emergency numbers'),
              onTap: onEmergencyContacts,
            ),
            ListTile(
              leading: const Icon(Icons.share_location, color: Colors.blue),
              title: const Text('Share Live Location'),
              subtitle: const Text('Share your real-time location'),
              onTap: onShareLocation,
            ),
          ],
          
          ListTile(
            leading: const Icon(Icons.report, color: Colors.orange),
            title: const Text('Report Issue'),
            subtitle: const Text('Report safety concerns'),
            onTap: onReportIssue,
          ),
          
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}