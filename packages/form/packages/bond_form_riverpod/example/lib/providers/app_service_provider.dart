import 'package:get_it/get_it.dart';
import 'package:bond_core/bond_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    it.registerLazySingleton(() => sharedPreferences);
  }
}
