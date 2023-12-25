
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io' show Platform;

import 'package:serviceocity/view/account/logic.dart';

class InitFcm{

  void initialize({ bool setToken = false }) async{
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return;
    }


    OneSignal.Debug.setLogLevel(OSLogLevel.none);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);

    OneSignal.consentRequired(false);

    OneSignal.initialize("36e26b39-f645-4ce9-8de4-3c88e099bb08");

    OneSignal.Notifications.clearAll();

    if(setToken){
      Get.find<AccountLogic>().setPlayerId(token: OneSignal.User.pushSubscription.token);
    }
    OneSignal.User.pushSubscription.addObserver((state) {});

    OneSignal.Notifications.addPermissionObserver((state) {
     // print("Has permission $state");
    });

    OneSignal.Notifications.addClickListener((event) {
      // print('NOTIFICATION 3 CLICK LISTENER CALLED WITH EVENT: ${event.notification}');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      event.notification.display();
    });

    OneSignal.InAppMessages.paused(true);
  }
}