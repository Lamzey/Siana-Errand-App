import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';

import 'package:siana_erran_app/core/utils/errand_helper.dart';
import 'package:siana_erran_app/features/Errands/widgets/errands_widgets.dart';


class ErrandsDetailsScreen extends StatefulWidget {
  final ErrandModel errand;

  const ErrandsDetailsScreen({super.key, required this.errand});

  @override
  State<ErrandsDetailsScreen> createState() => _ErrandsDetailsScreenState();
}

class _ErrandsDetailsScreenState extends State<ErrandsDetailsScreen>
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
      title: "Errand Details",
      errand: currentErrand,
      onChatPressed: () => handleChatWithAgent(currentErrand),
      onCallPressed: () => handleCallAgent(currentErrand),
      onSharePressed: () => handleShareErrand(currentErrand),
      actionButtons: [
        SizedBox(
          width: double.infinity,
          child: CustomActionButton(
            text: ErrandStatusHelper.getMainActionText(currentErrand.status),
            backgroundColor: ErrandStatusHelper.getMainActionColor(
              currentErrand.status,
            ),
            onPressed: _handleMainAction,
          ),
        ),
      ],
    );

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
        showCancelDialog(context, _cancelErrand);
        break;
      default:
        _trackErrand();
        break;
    }
  }

  void _markAsCompleted() {
    setState(() {
      currentErrand = currentErrand.copyWith(
        status: ErrandStatus.completed,
        completedAt: DateTime.now(),
      );
    });
    Navigator.pop(context, currentErrand);
  }

  void _cancelErrand() {
    setState(() {
      currentErrand = currentErrand.copyWith(status: ErrandStatus.cancelled);
    });
  }

  void _trackErrand() {
    print('Track errand: ${currentErrand.id}');
  }
}

