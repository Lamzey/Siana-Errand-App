import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';

class TaskDescriptionInput extends StatefulWidget {
  const TaskDescriptionInput({super.key});

  @override
  State<TaskDescriptionInput> createState() => _TaskDescriptionInputState();
}

class _TaskDescriptionInputState extends State<TaskDescriptionInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final taskProvider = context.read<TaskProvider>();
    _controller = TextEditingController(text: taskProvider.taskDescription);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 4,
                onChanged: (value) {
                  taskProvider.setTaskDescription(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}