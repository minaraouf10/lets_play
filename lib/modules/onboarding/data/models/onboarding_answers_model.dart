import '../../domain/entities/onboarding_answers.dart';

class OnboardingAnswersModel extends OnboardingAnswers {
  const OnboardingAnswersModel({
    super.reason,
    super.proficiency,
    super.dailyGoalMinutes,
    super.startingPoint,
    super.isCompleted = false,
  });

  factory OnboardingAnswersModel.fromMap(Map<dynamic, dynamic> map) {
    return OnboardingAnswersModel(
      reason: map['reason'] as String?,
      proficiency: map['proficiency'] as String?,
      dailyGoalMinutes: map['dailyGoalMinutes'] as int?,
      startingPoint: map['startingPoint'] as String?,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  factory OnboardingAnswersModel.fromEntity(OnboardingAnswers entity) {
    return OnboardingAnswersModel(
      reason: entity.reason,
      proficiency: entity.proficiency,
      dailyGoalMinutes: entity.dailyGoalMinutes,
      startingPoint: entity.startingPoint,
      isCompleted: entity.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reason': reason,
      'proficiency': proficiency,
      'dailyGoalMinutes': dailyGoalMinutes,
      'startingPoint': startingPoint,
      'isCompleted': isCompleted,
    };
  }
}
