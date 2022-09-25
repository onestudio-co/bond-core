import 'package:flutter/foundation.dart';

import 'analytics_event.dart';
import 'system_events.dart';

abstract class AnalyticsProvider {
  @mustCallSuper
  void log(AnalyticsEvent event) {
    if (event is UserBeginTutorial) {
      logBeginTutorial();
    } else if (event is UserCompleteTutorial) {
      logCompleteTutorial();
    } else if (event is UserSignedUp) {
      logSignedUp(event as UserSignedUp);
    } else if (event is UserLoggedIn) {
      logSignedIn(event as UserLoggedIn);
    } else if (event is UserUpdateProfile) {
      updateProfile(event as UserUpdateProfile);
    } else if (event is UserViewedItemList) {
      logViewItemList();
    } else if (event is UserAddedToCart) {
      logAddToCart(event as UserAddedToCart);
    } else if (event is UserBeginCheckout) {
      logBeginCheckout(event as UserBeginCheckout);
    } else if (event is UserMadePurchase) {
      logMadePurchase(event as UserMadePurchase);
    } else {
      logEvent(event);
    }
  }

  void logEvent(AnalyticsEvent event);

  void logBeginTutorial();

  void logCompleteTutorial();

  void logSignedUp(UserSignedUp event);

  void logSignedIn(UserLoggedIn event);

  void updateProfile(UserUpdateProfile event);

  void logViewItemList();

  void logAddToCart(UserAddedToCart event);

  void logBeginCheckout(UserBeginCheckout event);

  void logMadePurchase(UserMadePurchase event);
}
