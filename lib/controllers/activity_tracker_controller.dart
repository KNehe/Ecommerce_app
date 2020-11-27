import 'package:flutter/foundation.dart';

class ActivityTracker extends ChangeNotifier {
  String currentTask = '';

  setTaskCurrentTask(String task) {
    currentTask = task;
  }
}
