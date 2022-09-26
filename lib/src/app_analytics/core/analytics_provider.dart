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

  void logBeginTutorial() {
    throw UnimplementedError('Begin tutorial not implemented');
  }

  void logCompleteTutorial() {
    throw UnimplementedError('Complete tutorial not implemented');
  }

  void logSignedUp(UserSignedUp event) {
    throw UnimplementedError('Signed up not implemented');
  }

  void logSignedIn(UserLoggedIn event) {
    throw UnimplementedError('Signed in not implemented');
  }

  void updateProfile(UserUpdateProfile event) {
    throw UnimplementedError('Update profile not implemented');
  }

  void logViewItemList() {
    throw UnimplementedError('View item list not implemented');
  }

  void logAddToCart(UserAddedToCart event) {
    throw UnimplementedError('Add to cart not implemented');
  }

  void logBeginCheckout(UserBeginCheckout event) {
    throw UnimplementedError('Begin checkout not implemented');
  }

  void logMadePurchase(UserMadePurchase event) {
    throw UnimplementedError('Made purchase not implemented');
  }
}
