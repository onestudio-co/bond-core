import 'core/analytics_event.dart';
import 'core/system_events.dart';

abstract class AnalyticsProvider {
  void log(AnalyticsEvent event) {
    try {
      _log(event);
    } on UnimplementedError catch (_) {
      logEvent(event);
    }
  }

  void _log(AnalyticsEvent event) {
    switch (event.systemEventType) {
      case SystemEvents.beginTutorial:
        logBeginTutorial(event);
        break;
      case SystemEvents.completeTutorial:
        logCompleteTutorial(event);
        break;
      case SystemEvents.signedUp:
        logSignedUp(event, event as UserSignedUp);
        break;
      case SystemEvents.signedIn:
        logSignedIn(event, event as UserSignedIn);
        break;
      case SystemEvents.signedOut:
        logSignedOut(event, event as UserSignedOut);
        break;
      case SystemEvents.updateProfile:
        updateProfile(event, event as UserUpdateProfile);
        break;
      case SystemEvents.viewItemList:
        logViewItemList(event, event as UserViewedItemList);
        break;
      case SystemEvents.viewItem:
        logViewItem(event, event as UserViewItem);
        break;
      case SystemEvents.selectItem:
        logSelectItem(event, event as UserSelectItem);
        break;
      case SystemEvents.viewPromotion:
        logViewPromotion(event, event as UserViewPromotion);
        break;
      case SystemEvents.selectPromotion:
        logSelectPromotion(event, event as UserSelectPromotion);
        break;
      case SystemEvents.addToCart:
        logAddToCart(event, event as UserAddedToCart);
        break;
      case SystemEvents.removeFromCart:
        logRemoveFromCart(event, event as UserRemovedFromCart);
        break;
      case SystemEvents.beginCheckout:
        logBeginCheckout(event, event as UserBeginCheckout);
        break;
      case SystemEvents.madePurchase:
        logMadePurchase(event, event as UserMadePurchase);
        break;
      case SystemEvents.refundOrder:
        logRefundOrder(event, event as UserRefundOrder);
        break;
      case SystemEvents.shareContent:
        logShareContent(event, event as UserShareContent);
        break;
      case SystemEvents.search:
        logSearch(event, event as UserSearch);
        break;
      case SystemEvents.viewSearchResults:
        logViewSearchResults(event, event as UserViewSearchResult);
        break;
      case SystemEvents.unknown:
        logEvent(event);
        break;
    }
  }

  void logEvent(AnalyticsEvent event);

  void setUserId(int userId);

  void setUserAttributes(Map<String, dynamic> attributes);

  void setCurrentScreen(String screenName) {
    throw UnimplementedError('Set current screen not implemented');
  }

  void logBeginTutorial(AnalyticsEvent event) {
    throw UnimplementedError('Begin tutorial not implemented');
  }

  void logCompleteTutorial(AnalyticsEvent event) {
    throw UnimplementedError('Complete tutorial not implemented');
  }

  void logSignedUp(AnalyticsEvent event, UserSignedUp data) {
    throw UnimplementedError('Signed up not implemented');
  }

  void logSignedIn(AnalyticsEvent event, UserSignedIn data) {
    throw UnimplementedError('Signed in not implemented');
  }

  void logSignedOut(AnalyticsEvent event, UserSignedOut data) {
    throw UnimplementedError('Signed out not implemented');
  }

  void updateProfile(AnalyticsEvent event, UserUpdateProfile data) {
    throw UnimplementedError('Update profile not implemented');
  }

  void logViewItemList(AnalyticsEvent event, UserViewedItemList data) {
    throw UnimplementedError('View item list not implemented');
  }

  void logViewItem(AnalyticsEvent event, UserViewItem data) {
    throw UnimplementedError('View item not implemented');
  }

  void logSelectItem(AnalyticsEvent event, UserSelectItem data) {
    throw UnimplementedError('Select item not implemented');
  }

  void logViewPromotion(AnalyticsEvent event, UserViewPromotion data) {
    throw UnimplementedError('View promotion not implemented');
  }

  void logSelectPromotion(AnalyticsEvent event, UserSelectPromotion data) {
    throw UnimplementedError('Select promotion not implemented');
  }

  void logAddToCart(AnalyticsEvent event, UserAddedToCart data) {
    throw UnimplementedError('Add to cart not implemented');
  }

  void logRemoveFromCart(AnalyticsEvent event, UserRemovedFromCart data) {
    throw UnimplementedError('Remove from cart not implemented');
  }

  void logBeginCheckout(AnalyticsEvent event, UserBeginCheckout data) {
    throw UnimplementedError('Begin checkout not implemented');
  }

  void logMadePurchase(AnalyticsEvent event, UserMadePurchase data) {
    throw UnimplementedError('Made purchase not implemented');
  }

  void logRefundOrder(AnalyticsEvent event, UserRefundOrder data) {
    throw UnimplementedError('Refund order not implemented');
  }

  void logShareContent(AnalyticsEvent event, UserShareContent data) {
    throw UnimplementedError('Share not implemented');
  }

  void logSearch(AnalyticsEvent event, UserSearch data) {
    throw UnimplementedError('Search not implemented');
  }

  void logViewSearchResults(AnalyticsEvent event, UserViewSearchResult data) {
    throw UnimplementedError('View search results not implemented');
  }
}
