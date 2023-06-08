import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petrol_ledger/component/permission_message_dialog_layout.dart';
import 'package:petrol_ledger/utils/extension.dart';

typedef PermissionGrantedCallback = void Function();

class StoragePermission {
  static const _permission = Permission.storage;

  static void _openAppSetting(BuildContext context) async {
    var result = await openAppSettings();
    if (!result && context.mounted) {
      context.showSnackBar(
          'Ooops! Cannot open the app setting. Please try open menually.');
    }
  }

  static Future<bool> _showRetionaleDialog(BuildContext context) async {
    var result = await context.showAlertDialog(
      child: PermissionMessageDialogLayout(
        message:
            "Storage permission was disabled.\nIt need to be granted to export sale data.",
        btnLabel1: 'Request Permission',
        btnLabel2: 'Cancel',
        callback1: () {
          Navigator.pop(context, true);
        },
        callback2: () {
          Navigator.pop(context, false);
        },
      ),
    );
    return result;
  }

  static Future<bool> _showDeniedMessageDialog(BuildContext context) async {
    var result = await context.showAlertDialog(
      child: PermissionMessageDialogLayout(
        message:
            "Storage permission was disabled permanently. Do you want to enable it from the system setting?",
        btnLabel1: 'Setting',
        btnLabel2: 'Cancel',
        callback1: () {
          Navigator.pop(context, true);
        },
        callback2: () {
          Navigator.pop(context, false);
        },
      ),
    );
    return result;
  }

  static void checkStoragePermission(
    BuildContext context, {
    PermissionGrantedCallback? onGranted,
  }) async {
    var canShowRationale = await _permission.shouldShowRequestRationale;
    if (canShowRationale && context.mounted) {
      var result = await _showRetionaleDialog(context);
      if (result && await _permission.request().isGranted) {
        if (onGranted != null) {
          onGranted();
        }
      }
    } else {
      var status = await _permission.request();
      if (status.isGranted) {
        if (onGranted != null) {
          onGranted();
        }
        return;
      }
      if (status.isPermanentlyDenied && context.mounted) {
        var result = await _showDeniedMessageDialog(context);
        if (result) {
          // ignore: use_build_context_synchronously
          _openAppSetting(context);
        }
      }
    }
  }
}
