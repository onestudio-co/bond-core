import 'package:one_studio_core/src/injection.dart';

import 'core/analytics_event.dart';
import 'core/analytics_provider.dart';

class AppAnalytics {

  static AnalyticsProvider analyticsProvider = sl<AnalyticsProvider>();

  static void fire(AnalyticsEvent event) {
    analyticsProvider.log(event);
    // for (var provider in providers) {
    //   log('AppAnalytics provider ${provider.runtimeType} fire log ${event.key} and params ${event.params}');
    //   provider.log(event);
    // }
  }
}
