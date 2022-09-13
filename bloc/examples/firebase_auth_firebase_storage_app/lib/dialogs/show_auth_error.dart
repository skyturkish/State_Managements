import 'package:firebase_auth_firebase_storage_app/auth/auth_error.dart';
import 'package:firebase_auth_firebase_storage_app/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showAuthError({
  required BuildContext context,
  required AuthError authError,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'Ok': true,
    },
  );
}
