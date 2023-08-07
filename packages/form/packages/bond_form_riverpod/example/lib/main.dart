import 'package:example/routes/app_router.dart';
import 'package:bond_core/bond_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_run_tasks.dart';
import 'bond_app.dart';

void main() => run(
      () => ProviderScope(
        child: BondApp(
          appRouter: sl<AppRouter>(),
        ),
      ),
      RunAppTasks(),
    );
