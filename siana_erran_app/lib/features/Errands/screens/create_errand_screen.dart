import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:siana_erran_app/features/Errands/widgets/datetime_picker_widget.dart';
import 'package:siana_erran_app/features/Errands/widgets/estimation_quote_display.dart';
import 'package:siana_erran_app/features/Errands/widgets/task_desciption_input.dart';
import 'package:siana_erran_app/features/profile/screens/profile_screen.dart';
import 'package:siana_erran_app/providers/errand/location_provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';
import 'package:siana_erran_app/providers/errand/ui_state_provider.dart';
import 'package:siana_erran_app/widgets/customappbar_widgets.dart';


import '../widgets/task_type_selector.dart';
import '../widgets/location_section_widget.dart';


class CreateErrandScreen extends StatefulWidget {
  const CreateErrandScreen({super.key});

  @override
  State<CreateErrandScreen> createState() => _CreateErrandScreenState();
}

class _CreateErrandScreenState extends State<CreateErrandScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => UIStateProvider()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          addLeading: true,
          title: "Submit Task",
          onAvatarTapped: () {
            pushScreenWithNavBar(context, ProfileScreen(addLeading: true));
          },
        ),
        body: const CreateErrandBody(),
      ),
    );
  }
}

class CreateErrandBody extends StatelessWidget {
  const CreateErrandBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<TaskProvider, LocationProvider, UIStateProvider>(
      builder:
          (context, taskProvider, locationProvider, uiStateProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TaskTypeSelector(),
                  const SizedBox(height: 24),
                  const LocationSectionWidget(),
                  const SizedBox(height: 24),
                  const DateTimePickerWidget(),
                  const SizedBox(height: 24),
                  const TaskDescriptionInput(),
                  const SizedBox(height: 24),
                  const EstimatedQuoteDisplay(),
                  const SizedBox(height: 32),
                  _buildConfirmButton(
                    taskProvider,
                    locationProvider,
                    uiStateProvider,
                    context,
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Extra space for bottom navigation
                ],
              ),
            );
          },
    );
  }

  Widget _buildConfirmButton(
    TaskProvider taskProvider,
    LocationProvider locationProvider,
    UIStateProvider uiStateProvider,
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
            taskProvider.hasSelectedTaskTypes && !uiStateProvider.isSubmitting
            ? () => _submitTask(
                taskProvider,
                locationProvider,
                uiStateProvider,
                context,
              )
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              taskProvider.hasSelectedTaskTypes && !uiStateProvider.isSubmitting
              ? Colors.black
              : Colors.grey,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: uiStateProvider.isSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Confirm Task Submission',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Future<void> _submitTask(
    TaskProvider taskProvider,
    LocationProvider locationProvider,
    UIStateProvider uiStateProvider,
    BuildContext context,
  ) async {
    try {
      uiStateProvider.setSubmitting(true);
      uiStateProvider.clearError();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Get task data
      final taskData = taskProvider.getTaskData();
      final locationData = locationProvider.getLocationData();

      // Combine data for submission
      final submissionData = {
        ...taskData,
        ...locationData,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Log submission data (in real app, send to API)
      debugPrint('Task Submission Data: $submissionData');

      // Show success dialog
      final selectedTypesList = taskProvider.selectedTaskTypes.toList();
      final taskTypesText = selectedTypesList.length == 1
          ? selectedTypesList.first.toLowerCase()
          : selectedTypesList.map((e) => e.toLowerCase()).join(', ');

      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Task Submitted'),
              content: Text(
                'Your $taskTypesText task has been submitted successfully!',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    // Reset form
                    taskProvider.resetForm();
                    locationProvider.resetLocations();
                    uiStateProvider.resetUIState();
                    // Go back to previous screen
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      uiStateProvider.setErrorMessage(
        'Failed to submit task. Please try again.',
      );
      debugPrint('Task submission error: $error');
    } finally {
      uiStateProvider.setSubmitting(false);
    }
  }
}
