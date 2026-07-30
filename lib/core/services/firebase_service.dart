import 'package:firebase_core/firebase_core.dart';

// Generate this file with the FlutterFire CLI:
//   flutterfire configure
// It is git-ignored (contains project ids, not secrets, but kept per-env).
import '../../firebase_options.dart';

/// Initialises Firebase once at app start.
class FirebaseService {
  const FirebaseService._();

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
