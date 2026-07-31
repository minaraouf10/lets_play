import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/onboarding_question.dart';
import '../../domain/entities/onboarding_option.dart';
import '../../domain/entities/onboarding_answers.dart';
import '../../domain/entities/onboarding_step.dart';
import '../models/onboarding_answers_model.dart';
import '../../../../core/constants/app_assets.dart';

abstract class OnboardingLocalDataSource {
  Future<List<OnboardingQuestion>> getQuestions();
  Future<void> saveAnswers(OnboardingAnswers answers);
  Future<OnboardingAnswers> getSavedAnswers();
  Future<bool> isOnboardingCompleted();
}

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  static const String _boxName = 'onboarding';

  static const List<OnboardingQuestion> _seedQuestions = [
    // Step 1 – Reason
    OnboardingQuestion(
      step: OnboardingStep.reason,
      bannerText: 'Why have you chosen to study Arabic?',
      bannerColor: Color(0xFF1E6FFF), // primary color
      options: [
        OnboardingOption(id: 'future_trips', label: 'Get ready for future trips', assetPath: AppAssets.reasonFutureTrips),
        OnboardingOption(id: 'connections', label: 'Establish connections', assetPath: AppAssets.reasonConnections),
        OnboardingOption(id: 'education', label: 'Enhance my educational', assetPath: AppAssets.reasonEducational),
        OnboardingOption(id: 'career', label: 'Advance my career', assetPath: AppAssets.reasonCareer),
        OnboardingOption(id: 'other', label: 'Other', assetPath: AppAssets.reasonOther),
      ],
    ),
    // Step 2 – Proficiency
    OnboardingQuestion(
      step: OnboardingStep.proficiency,
      bannerText: 'What is your level of proficiency in Arabic?',
      bannerColor: Color(0xFFFF7A00), // orange
      options: [
        OnboardingOption(id: 'beginner', label: "I'm a beginner in Arabic"),
        OnboardingOption(id: 'few_words', label: 'I know a few words'),
        OnboardingOption(id: 'conversational', label: 'I can hold conversations'),
        OnboardingOption(id: 'intermediate_plus', label: 'I have an intermediate or higher level'),
      ],
    ),
    // Step 3 – Daily Goal
    OnboardingQuestion(
      step: OnboardingStep.dailyGoal,
      bannerText: 'What is your daily goal for learning Arabic?',
      bannerColor: Color(0xFF00A3FF), // light blue
      options: [
        OnboardingOption(id: '10', label: '10 min/day', trailingLabel: 'Casual'),
        OnboardingOption(id: '15', label: '15 min/day', trailingLabel: 'Regular'),
        OnboardingOption(id: '20', label: '20 min/day', trailingLabel: 'Serious'),
        OnboardingOption(id: '25', label: '25 min/day', trailingLabel: 'Intense'),
      ],
    ),
    // Step 3.5 - Dialect
    OnboardingQuestion(
      step: OnboardingStep.dialect,
      bannerText: 'Which dialect of Arabic are you interested in?',
      bannerColor: Color(0xFFFFD700), // yellow
      options: [
        OnboardingOption(id: 'levantine', label: 'Levantine'),
        OnboardingOption(id: 'egyptian', label: 'Egyptian'),
        OnboardingOption(id: 'gulf', label: 'Gulf'),
        OnboardingOption(id: 'msa', label: 'Modern standard arabic'),
      ],
    ),
    // Step 3.6 - Launching
    OnboardingQuestion(
      step: OnboardingStep.launching,
      bannerText: "Launching",
      bannerColor: Color(0xFF0114FF), // Blue
      options: [
        OnboardingOption(
          id: 'ad_free',
          label: 'AD FREE!',
          trailingLabel: 'No more interruptions\nwith LetsPlay+',
          assetPath: 'assets/images/intrto_icons/ad_free.svg',
        ),
        OnboardingOption(
          id: 'unlimited_hearts',
          label: 'Unlimited Hearts',
          trailingLabel: 'Play whenever with\nunlimited lives',
          assetPath: 'assets/images/intrto_icons/unlimited_hearts.svg',
        ),
        OnboardingOption(
          id: 'personalized',
          label: 'Personalized\nLessons',
          trailingLabel: 'Customized only for you\nand your needs',
          assetPath: 'assets/images/intrto_icons/personalized_lessons.svg',
        ),
      ],
    ),
    // Step 4 – Benefits
    OnboardingQuestion(
      step: OnboardingStep.benefits,
      bannerText: "Here's what you can accomplish!",
      bannerColor: Color(0xFF6C2BD9), // purple
      options: [
        OnboardingOption(
          id: 'engage',
          label: 'Engage in confident conversations',
          trailingLabel: 'Interact with people with less difficulty.',
          assetPath: 'assets/images/intrto_icons/engage_in_confident.svg',
        ),
        OnboardingOption(
          id: 'expand',
          label: 'Expand your vocabulary significantly',
          trailingLabel: 'Learn new words that will make you express yourself better.',
          assetPath: 'assets/images/intrto_icons/significantly.svg',
        ),
        OnboardingOption(
          id: 'cultivate',
          label: 'Cultivate a consistent learning routine',
          trailingLabel: 'Build the healthy habit of learning something new everyday.',
          assetPath: 'assets/images/intrto_icons/cultivate_consistent.svg',
        ),
      ],
    ),
    // Step 5 – Starting Point
    OnboardingQuestion(
      step: OnboardingStep.startingPoint,
      bannerText: "Now let's find the best place to start!",
      bannerColor: Color(0xFFFF2D6F), // accentPink
      options: [
        OnboardingOption(
          id: 'from_scratch',
          label: 'Start from Scratch',
          assetPath: 'assets/images/intrto_icons/start_from_scratch.svg',
        ),
        OnboardingOption(
          id: 'find_my_place',
          label: 'Find my starting place',
          assetPath: 'assets/images/intrto_icons/start_palceing.svg',
        ),
      ],
    ),
  ];

  @override
  Future<List<OnboardingQuestion>> getQuestions() async {
    return _seedQuestions;
  }

  @override
  Future<void> saveAnswers(OnboardingAnswers answers) async {
    final box = await Hive.openBox(_boxName);
    // Store as a plain Map — Hive can only persist an entity directly
    // once a generated TypeAdapter is registered for it.
    await box.put(
      'answers',
      OnboardingAnswersModel.fromEntity(answers).toMap(),
    );
    await box.put('completed', answers.isCompleted);
  }

  @override
  Future<OnboardingAnswers> getSavedAnswers() async {
    final box = await Hive.openBox(_boxName);
    final stored = box.get('answers');
    if (stored is Map) {
      return OnboardingAnswersModel.fromMap(stored);
    }
    // default empty answers
    return const OnboardingAnswers();
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    final box = await Hive.openBox(_boxName);
    return box.get('completed') as bool? ?? false;
  }
}
