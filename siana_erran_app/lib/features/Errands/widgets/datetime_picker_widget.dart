import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';
import 'package:siana_erran_app/providers/errand/ui_state_provider.dart';

import 'custom_calendar.dart';

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskProvider, UIStateProvider>(
      builder: (context, taskProvider, uiStateProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskProvider.dateTimeQuestionText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            _buildDateTimePicker(taskProvider, uiStateProvider, context),
          ],
        );
      },
    );
  }

  Widget _buildDateTimePicker(
    TaskProvider taskProvider,
    UIStateProvider uiStateProvider,
    BuildContext context,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: uiStateProvider.toggleDateTimeExpanded,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Date & Time',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (uiStateProvider.isDateTimeExpanded) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                const CustomCalendar(),
                const SizedBox(height: 16),
                if (taskProvider.isShadowTask)
                  _buildCurrentTimeButton(taskProvider)
                else
                  _buildTimeSelector(taskProvider, context),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTimeSelector(TaskProvider taskProvider, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(context, taskProvider),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '${taskProvider.selectedTime.hour.toString().padLeft(2, '0')}:${taskProvider.selectedTime.minute.toString().padLeft(2, '0')}${taskProvider.selectedTime.period == DayPeriod.am ? 'am' : 'pm'}',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Hours or Minutes:',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentTimeButton(TaskProvider taskProvider) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: taskProvider.toggleCurrentTime,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Current Time',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(
    BuildContext context,
    TaskProvider taskProvider,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: taskProvider.selectedTime,
    );
    if (picked != null && picked != taskProvider.selectedTime) {
      taskProvider.setSelectedTime(picked);
    }
  }
}
