import 'package:flutter/material.dart';

Future showAnimatedDialog(BuildContext context, Widget child, {bool dismissible = false}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: dismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, animation1, animation2) => child,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (context, a1, a2, widget){
      return Transform.scale(
        scale: a1.value,
        child: widget
      );
    }
  );
}