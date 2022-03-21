import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

showAlertDialogFailure(
    {required BuildContext context,
    required String title,
    required String message,
    required String buttonConfirmationLabel,
    bool goBack = false}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.red, width: 4)),
          title: Text(title),
          content: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Text(message),
                const SizedBox(height: 10),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 2 * pi),
                  curve: Curves.elasticIn,
                  duration: const Duration(seconds: 3),
                  child: ClipOval(
                    child: Material(
                      color: Colors.amber,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: MediaQuery.of(context).size.width * 0.09,
                        ),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.rotate(
                      angle: value,
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (goBack) {
                  Modular.to.pop();
                }
                Modular.to.pop();
              },
              child: Text(buttonConfirmationLabel),
            ),
          ],
        );
      });
}

showAlertDialogSuccess(
    {required BuildContext context,
    required String title,
    required String message,
    required String buttonConfirmationLabel,
    required bool goBack}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.green, width: 4)),
          title: Text(title),
          content: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Text(message),
                const SizedBox(height: 10),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 2 * pi),
                  curve: Curves.bounceOut,
                  duration: const Duration(seconds: 3),
                  child: ClipOval(
                    child: Material(
                      color: Colors.amber,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Icon(
                          Icons.done_outlined,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.width * 0.09,
                        ),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.rotate(
                      angle: value,
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.pop();
                if (goBack) {
                  Modular.to.pop();
                }
              },
              child: Text(buttonConfirmationLabel),
            ),
          ],
        );
      });
}

showAConfirmationDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required Function yesFunction,
    required Function noFunction}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Não"),
            onPressed: () async => await noFunction(),
          ),
          TextButton(
            child: const Text("Sim"),
            onPressed: () async => await yesFunction(),
          )
        ],
      );
    },
  );
}
