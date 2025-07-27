import 'package:flutter/material.dart';
import 'package:siana_erran_app/features/Errands/constants/task_constants.dart';

class TaskProvider extends ChangeNotifier {
  // Task Types
  Set<String> _selectedTaskTypes = {'Delivery'};
  
  // Date/Time
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _useCurrentTime = false;
  
  // Form Data
  String _taskDescription = TaskConstants.defaultTaskDescription;
  double _estimatedQuote = TaskConstants.defaultEstimatedQuote;
  
  // Getters
  Set<String> get selectedTaskTypes => _selectedTaskTypes;
  List<String> get mainTaskTypes => TaskConstants.mainTaskTypes;
  List<String> get additionalTaskTypes => TaskConstants.additionalTaskTypes;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  bool get useCurrentTime => _useCurrentTime;
  String get taskDescription => _taskDescription;
  double get estimatedQuote => _estimatedQuote;
  
  // Computed properties
  bool get hasSelectedTaskTypes => _selectedTaskTypes.isNotEmpty;
  bool get isShadowTask => _selectedTaskTypes.contains('Shadow');
  String get dateTimeQuestionText => isShadowTask ? 'When is the deadline?' : 'When is the appointment?';
  
  // Methods
  void toggleTaskType(String taskType) {
    if (_selectedTaskTypes.contains(taskType)) {
      _selectedTaskTypes.remove(taskType);
    } else {
      _selectedTaskTypes.add(taskType);
    }
    notifyListeners();
  }
  
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  
  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }
  
  void toggleCurrentTime() {
    _useCurrentTime = !_useCurrentTime;
    if (_useCurrentTime) {
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    }
    notifyListeners();
  }
  
  void setTaskDescription(String description) {
    _taskDescription = description;
    notifyListeners();
  }
  
  void updateEstimatedQuote(double quote) {
    _estimatedQuote = quote;
    notifyListeners();
  }
  
  void resetForm() {
    _selectedTaskTypes = {'Delivery'};
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _useCurrentTime = false;
    _taskDescription = TaskConstants.defaultTaskDescription;
    _estimatedQuote = TaskConstants.defaultEstimatedQuote;
    notifyListeners();
  }
  
  Map<String, dynamic> getTaskData() {
    return {
      'taskTypes': _selectedTaskTypes.toList(),
      'selectedDate': _selectedDate,
      'selectedTime': _selectedTime,
      'useCurrentTime': _useCurrentTime,
      'taskDescription': _taskDescription,
      'estimatedQuote': _estimatedQuote,
    };
  }
}