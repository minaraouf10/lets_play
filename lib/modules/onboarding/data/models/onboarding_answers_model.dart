import '../../domain/entities/onboarding_answers.dart';

class OnboardingAnswersModel extends OnboardingAnswers {
  const OnboardingAnswersModel({
    super.reason,
    super.proficiency,
    super.dailyGoalMinutes,
    super.dialect,
    super.startingPoint,
    super.isCompleted = false,
  });

  factory OnboardingAnswersModel.fromMap(Map<dynamic, dynamic> map) {
    return OnboardingAnswersModel(
      reason: map['reason'] as String?,
      proficiency: map['proficiency'] as String?,
      dailyGoalMinutes: map['dailyGoalMinutes'] as int?,
      dialect: map['dialect'] as String?,
      startingPoint: map['startingPoint'] as String?,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  factory OnboardingAnswersModel.fromEntity(OnboardingAnswers entity) {
    return OnboardingAnswersModel(
      reason: entity.reason,
      proficiency: entity.proficiency,
      dailyGoalMinutes: entity.dailyGoalMinutes,
      dialect: entity.dialect,
      startingPoint: entity.startingPoint,
      isCompleted: entity.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reason': reason,
      'proficiency': proficiency,
      'dailyGoalMinutes': dailyGoalMinutes,
      'dialect': dialect,
      'startingPoint': startingPoint,
      'isCompleted': isCompleted,
    };
  }
}
