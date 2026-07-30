import 'package:injectable/injectable.dart';
import '../../domain/entities/onboarding_answers.dart';
import '../../domain/entities/onboarding_question.dart';
import 'onboarding_remote_datasource.dart';

@LazySingleton(as: OnboardingRemoteDataSource)
class MockOnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  @override
  Future<List<OnboardingQuestion>> getQuestions() async {
    // In mock, return empty list; real questions come from local datasource.
    return [];
  }

  @override
  Future<void> saveAnswers(OnboardingAnswers answers) async {
    // No-op for mock.
    return;
  }
}
