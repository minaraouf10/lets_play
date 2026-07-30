
import '../../domain/entities/onboarding_answers.dart';
import '../../domain/entities/onboarding_question.dart';

abstract class OnboardingRemoteDataSource {
  Future<List<OnboardingQuestion>> getQuestions();
  Future<void> saveAnswers(OnboardingAnswers answers);
}

// @LazySingleton(as: OnboardingRemoteDataSource)
// class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
//   // TODO: Implement Firebase logic when Firebase is linked.
//   @override
//   Future<List<OnboardingQuestion>> getQuestions() async {
//     // Placeholder implementation.
//     return [];
//   }
//
//   @override
//   Future<void> saveAnswers(OnboardingAnswers answers) async {
//     // Placeholder implementation.
//   }
// }
