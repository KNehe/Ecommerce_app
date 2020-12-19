import 'package:flutter/foundation.dart';

class ActivityTracker extends ChangeNotifier {
  String _currentTask = '';

  setTaskCurrentTask(String task) {
    _currentTask = task;
  }

  String get currentTask => _currentTask;
}
