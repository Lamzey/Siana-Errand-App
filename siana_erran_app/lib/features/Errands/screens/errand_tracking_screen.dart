import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';

import 'package:siana_erran_app/core/utils/errand_helper.dart';
import 'package:siana_erran_app/features/Errands/widgets/errands_widgets.dart';

class ErrandTrackingScreen extends StatefulWidget {
  final ErrandModel errand;
  const ErrandTrackingScreen({super.key, required this.errand});

  @override
  State<ErrandTrackingScreen> createState() => _ErrandTrackingScreenState();
}

class _ErrandTrackingScreenState extends State<ErrandTrackingScreen>
    with ErrandActionHandlers {
  late ErrandModel currentErrand;

  @override
  void initState() {
    super.initState();
    currentErrand = widget.errand;
  }

  @override
  Widget build(BuildContext context) {
    return ErrandScreenLayout(
      title: "Track Errand",
      errand: currentErrand,
      onChatPressed: () => handleChatWithAgent(currentErrand),
      onCallPressed: () => handleCallAgent(currentErrand),
      onSharePressed: () => handleShareErrand(currentErrand),
      paymentStatusText: "Pending",
      paymentStatusColor: Colors.orange,
      actionButtons: [
        Row(
          children: [
            Expanded(
              child: CustomActionButton(
                text: 'Errand In Progress',
                backgroundColor: Colors.orange,
                onPressed: _handleErrandInProgress,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomActionButton(
                text: 'Safety Tools',
                icon: Icons.security,
                isOutlined: true,
                textColor: Colors.black87,
                onPressed: _handleSafetyTools,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleErrandInProgress() {
    print('Errand in progress: ${currentErrand.id}');
  }

  void _handleSafetyTools() {
    showSafetyToolsModal(
      context,
      onEmergencyContacts: () => print('Emergency contacts'),
      onShareLocation: () => print('Share location'),
      onReportIssue: () => print('Report issue'),
    );
  }
}
