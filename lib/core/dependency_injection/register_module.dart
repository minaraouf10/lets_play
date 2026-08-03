import '../utils/app_imports.dart';

/// Registers third-party singletons that we don't own (can'annotate).
@module
abstract class RegisterModule {
  // Commented out while Firebase is not linked
  // @lazySingleton
  // FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  // @lazySingleton
  // FirebaseFirestore get firestore => FirebaseFirestore.instance;

  // @lazySingleton
  // FirebaseStorage get storage => FirebaseStorage.instance;

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();
}
