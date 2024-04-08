import 'package:expense_tracker_app/core/firebase_options_files/firebase_options_staging.dart';
import 'package:expense_tracker_app/init_dependencies.dart';
import 'main_common.dart';

void main() async {
  await initDependencies();

  initializeAppAndRunApp(
    StagingFirebaseOptions.currentPlatform,
  );
}
