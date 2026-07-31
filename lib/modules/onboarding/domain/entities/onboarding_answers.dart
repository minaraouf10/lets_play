import 'package:equatable/equatable.dart';

class OnboardingAnswers extends Equatable {
  const OnboardingAnswers({
    this.reason,
    this.proficiency,
    this.dailyGoalMinutes,
    this.dialect,
    this.startingPoint,
    this.isCompleted = false,
  });

  final String? reason;
  final String? proficiency;
  final int? dailyGoalMinutes;
  final String? dialect;
  final String? startingPoint;
  final bool isCompleted;

  OnboardingAnswers copyWith({
    String? reason,
    String? proficiency,
    int? dailyGoalMinutes,
    String? dialect,
    String? startingPoint,
    bool? isCompleted,
  }) {
    return OnboardingAnswers(
      reason: reason ?? this.reason,
      proficiency: proficiency ?? this.proficiency,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      dialect: dialect ?? this.dialect,
      startingPoint: startingPoint ?? this.startingPoint,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        reason,
        proficiency,
        dailyGoalMinutes,
        dialect,
        startingPoint,
        isCompleted,
      ];
}
