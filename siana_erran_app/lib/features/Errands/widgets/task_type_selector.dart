import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';

import '../constants/task_constants.dart';

class TaskTypeSelector extends StatelessWidget {
  const TaskTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'What type of task?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            _buildMainTaskTypes(taskProvider),
            const SizedBox(height: 12),
            _buildAdditionalTaskTypes(taskProvider),
          ],
        );
      },
    );
  }

  Widget _buildMainTaskTypes(TaskProvider taskProvider) {
    return Row(
      children: taskProvider.mainTaskTypes.map((type) {
        final isSelected = taskProvider.selectedTaskTypes.contains(type);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: type != taskProvider.mainTaskTypes.last ? 8.0 : 0,
            ),
            child: GestureDetector(
              onTap: () => taskProvider.toggleTaskType(type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      TaskConstants.taskTypeIcons[type] ?? Icons.help_outline,
                      size: 16,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      type,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAdditionalTaskTypes(TaskProvider taskProvider) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: taskProvider.additionalTaskTypes.map((type) {
        final isSelected = taskProvider.selectedTaskTypes.contains(type);
        return GestureDetector(
          onTap: () => taskProvider.toggleTaskType(type),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  TaskConstants.taskTypeIcons[type] ?? Icons.help_outline,
                  size: 16,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}