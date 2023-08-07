import 'package:bond_core/bond_core.dart';

import '../providers/app_service_provider.dart';
import '../providers/cache_service_provider.dart';

final List<ServiceProvider> providers = [
  // Framework Service Providers
  AppServiceProvider(),
  CacheServiceProvider(),
];
