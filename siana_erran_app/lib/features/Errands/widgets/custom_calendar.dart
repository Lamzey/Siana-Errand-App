import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siana_erran_app/providers/errand/task_provider.dart';
import '../constants/task_constants.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Column(
          children: [
            _buildCalendarHeader(taskProvider),
            const SizedBox(height: 8),
            _buildCalendarGrid(taskProvider),
          ],
        );
      },
    );
  }

  Widget _buildCalendarHeader(TaskProvider taskProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            final newDate = DateTime(
              taskProvider.selectedDate.year,
              taskProvider.selectedDate.month - 1,
              1,
            );
            taskProvider.setSelectedDate(newDate);
          },
          icon: const Icon(Icons.chevron_left, color: Colors.grey),
        ),
        Text(
          '${TaskConstants.monthNames[taskProvider.selectedDate.month - 1]} ${taskProvider.selectedDate.year}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            final newDate = DateTime(
              taskProvider.selectedDate.year,
              taskProvider.selectedDate.month + 1,
              1,
            );
            taskProvider.setSelectedDate(newDate);
          },
          icon: const Icon(Icons.chevron_right, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(TaskProvider taskProvider) {
    final daysInMonth = DateTime(
      taskProvider.selectedDate.year, 
      taskProvider.selectedDate.month + 1, 
      0
    ).day;
    final firstDayWeekday = DateTime(
      taskProvider.selectedDate.year, 
      taskProvider.selectedDate.month, 
      1
    ).weekday;
    final today = DateTime.now();

    return Column(
      children: [
        // Weekday headers
        Row(
          children: TaskConstants.weekDayAbbreviations.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        // Calendar grid
        ...List.generate(6, (weekIndex) {
          return Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber = weekIndex * 7 + dayIndex - firstDayWeekday + 2;
              
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const Expanded(child: SizedBox(height: 40));
              }

              final date = DateTime(
                taskProvider.selectedDate.year, 
                taskProvider.selectedDate.month, 
                dayNumber
              );
              final isSelected = taskProvider.selectedDate.day == dayNumber;
              final isToday = date.year == today.year && 
                             date.month == today.month && 
                             date.day == today.day;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    taskProvider.setSelectedDate(date);
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        dayNumber.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected 
                              ? Colors.white 
                              : isToday 
                                  ? Colors.blue 
                                  : Colors.black,
                          fontWeight: isSelected || isToday 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}