import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CDialog {
  static ProgressDialog _pr;

  CDialog(BuildContext context) {
    _pr = ProgressDialog(context);
    _pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    _pr.style(
      message: 'Please wait...',
    );
  }

  show() {
    _pr.show();
  }

  hide() {
    _pr.hide();
  }
}
