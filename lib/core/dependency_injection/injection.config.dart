// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_tts/flutter_tts.dart' as _i50;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../modules/achievements/data/datasources/achievements_local_datasource.dart'
    as _i288;
import '../../modules/achievements/data/repositories/achievements_repository_impl.dart'
    as _i300;
import '../../modules/achievements/domain/repositories/achievements_repository.dart'
    as _i997;
import '../../modules/achievements/domain/usecases/get_achievements_usecase.dart'
    as _i846;
import '../../modules/achievements/presentation/cubit/achievements_cubit.dart'
    as _i600;
import '../../modules/authentication/data/datasources/mock_auth_remote_datasource.dart'
    as _i643;
import '../../modules/authentication/data/repositories/auth_repository_impl.dart'
    as _i452;
import '../../modules/authentication/domain/usecases/login_usecase.dart'
    as _i875;
import '../../modules/authentication/domain/usecases/logout_usecase.dart'
    as _i333;
import '../../modules/authentication/presentation/cubit/auth_cubit.dart'
    as _i659;
import '../../modules/home/games/data/datasources/games_local_datasource.dart'
    as _i80;
import '../../modules/home/games/data/repositories/games_repository_impl.dart'
    as _i1058;
import '../../modules/home/games/domain/repositories/games_repository.dart'
    as _i82;
import '../../modules/home/games/domain/usecases/get_letter_puzzle_usecase.dart'
    as _i447;
import '../../modules/home/games/domain/usecases/save_game_result_usecase.dart'
    as _i778;
import '../../modules/home/games/presentation/cubit/letter_game_cubit.dart'
    as _i439;
import '../../modules/home/games/presentation/cubit/letter_quiz_cubit.dart'
    as _i284;
import '../../modules/home/games/presentation/cubit/letter_review_cubit.dart'
    as _i711;
import '../../modules/home/games/presentation/cubit/letter_trace_cubit.dart'
    as _i470;
import '../../modules/home/games/presentation/cubit/tashkeel_lesson_cubit.dart'
    as _i801;
import '../../modules/home/games/presentation/cubit/word_lesson_cubit.dart'
    as _i810;
import '../../modules/home/learning/data/datasources/learning_local_datasource.dart'
    as _i267;
import '../../modules/home/learning/data/repositories/learning_repository_impl.dart'
    as _i963;
import '../../modules/home/learning/domain/repositories/learning_repository.dart'
    as _i475;
import '../../modules/home/learning/domain/usecases/get_levels_usecase.dart'
    as _i352;
import '../../modules/home/learning/presentation/cubit/lesson_intro_cubit.dart'
    as _i882;
import '../../modules/home/learning/presentation/cubit/levels_cubit.dart'
    as _i421;
import '../../modules/leaderboard/data/datasources/leaderboard_local_datasource.dart'
    as _i74;
import '../../modules/leaderboard/data/repositories/leaderboard_repository_impl.dart'
    as _i721;
import '../../modules/leaderboard/domain/repositories/leaderboard_repository.dart'
    as _i232;
import '../../modules/leaderboard/domain/usecases/get_followers_usecase.dart'
    as _i463;
import '../../modules/leaderboard/domain/usecases/get_leaderboard_usecase.dart'
    as _i60;
import '../../modules/leaderboard/presentation/cubit/followers_cubit.dart'
    as _i229;
import '../../modules/leaderboard/presentation/cubit/leaderboard_cubit.dart'
    as _i409;
import '../../modules/onboarding/data/datasources/mock_onboarding_remote_datasource.dart'
    as _i842;
import '../../modules/onboarding/data/datasources/onboarding_local_datasource.dart'
    as _i163;
import '../../modules/onboarding/data/datasources/onboarding_remote_datasource.dart'
    as _i668;
import '../../modules/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i391;
import '../../modules/onboarding/domain/repositories/onboarding_repository.dart'
    as _i270;
import '../../modules/onboarding/domain/usecases/get_onboarding_questions_usecase.dart'
    as _i982;
import '../../modules/onboarding/domain/usecases/get_onboarding_status_usecase.dart'
    as _i1012;
import '../../modules/onboarding/domain/usecases/save_onboarding_answers_usecase.dart'
    as _i444;
import '../../modules/onboarding/presentation/cubit/onboarding_cubit.dart'
    as _i816;
import '../../modules/profile/data/datasources/profile_local_datasource.dart'
    as _i70;
import '../../modules/profile/data/repositories/profile_repository_impl.dart'
    as _i529;
import '../../modules/profile/domain/repositories/profile_repository.dart'
    as _i496;
import '../../modules/profile/presentation/cubit/feedback_cubit.dart' as _i363;
import '../../modules/profile/presentation/cubit/help_center_cubit.dart'
    as _i329;
import '../../modules/profile/presentation/cubit/profile_cubit.dart' as _i514;
import '../../modules/profile/presentation/cubit/settings_cubit.dart' as _i366;
import '../../modules/splash/presentation/cubit/splash_cubit.dart' as _i510;
import '../networking/dio_client.dart' as _i201;
import '../networking/network_info.dart' as _i303;
import '../routing/app_router.dart' as _i282;
import '../services/letter_audio_service.dart' as _i82;
import '../utils/app_imports.dart' as _i468;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i882.LessonIntroCubit>(() => _i882.LessonIntroCubit());
    gh.factory<_i510.SplashCubit>(() => _i510.SplashCubit());
    gh.lazySingleton<_i468.InternetConnection>(
      () => registerModule.internetConnection,
    );
    gh.lazySingleton<_i468.FlutterTts>(() => registerModule.flutterTts);
    gh.lazySingleton<_i201.DioClient>(() => _i201.DioClient());
    gh.lazySingleton<_i282.AppRouter>(() => _i282.AppRouter());
    gh.lazySingleton<_i668.OnboardingRemoteDataSource>(
      () => _i842.MockOnboardingRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i288.AchievementsLocalDataSource>(
      () => _i288.AchievementsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i267.LearningLocalDataSource>(
      () => _i267.LearningLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i82.LetterAudioService>(
      () => _i82.LetterAudioService(gh<_i50.FlutterTts>()),
    );
    gh.lazySingleton<_i997.AchievementsRepository>(
      () => _i300.AchievementsRepositoryImpl(
        gh<_i288.AchievementsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i468.AuthRemoteDataSource>(
      () => _i643.MockAuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i475.LearningRepository>(
      () => _i963.LearningRepositoryImpl(gh<_i267.LearningLocalDataSource>()),
    );
    gh.factory<_i846.GetAchievementsUseCase>(
      () => _i846.GetAchievementsUseCase(gh<_i997.AchievementsRepository>()),
    );
    gh.lazySingleton<_i163.OnboardingLocalDataSource>(
      () => _i163.OnboardingLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i80.GamesLocalDataSource>(
      () => _i80.GamesLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i303.NetworkInfo>(
      () => _i303.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i70.ProfileLocalDataSource>(
      () => _i70.ProfileLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i74.LeaderboardLocalDataSource>(
      () => _i74.LeaderboardLocalDataSourceImpl(),
    );
    gh.factory<_i801.TashkeelLessonCubit>(
      () => _i801.TashkeelLessonCubit(gh<_i468.LetterAudioService>()),
    );
    gh.factory<_i810.WordLessonCubit>(
      () => _i810.WordLessonCubit(gh<_i468.LetterAudioService>()),
    );
    gh.lazySingleton<_i352.GetLevelsUseCase>(
      () => _i352.GetLevelsUseCase(gh<_i475.LearningRepository>()),
    );
    gh.factory<_i600.AchievementsCubit>(
      () => _i600.AchievementsCubit(gh<_i846.GetAchievementsUseCase>()),
    );
    gh.factory<_i421.LevelsCubit>(
      () => _i421.LevelsCubit(gh<_i352.GetLevelsUseCase>()),
    );
    gh.lazySingleton<_i270.OnboardingRepository>(
      () => _i391.OnboardingRepositoryImpl(
        gh<_i163.OnboardingLocalDataSource>(),
        gh<_i668.OnboardingRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i82.GamesRepository>(
      () => _i1058.GamesRepositoryImpl(gh<_i80.GamesLocalDataSource>()),
    );
    gh.lazySingleton<_i496.ProfileRepository>(
      () => _i529.ProfileRepositoryImpl(gh<_i70.ProfileLocalDataSource>()),
    );
    gh.factory<_i284.LetterQuizCubit>(
      () => _i284.LetterQuizCubit(
        gh<_i352.GetLevelsUseCase>(),
        gh<_i468.LetterAudioService>(),
      ),
    );
    gh.factory<_i363.FeedbackCubit>(
      () => _i363.FeedbackCubit(gh<_i496.ProfileRepository>()),
    );
    gh.factory<_i329.HelpCenterCubit>(
      () => _i329.HelpCenterCubit(gh<_i496.ProfileRepository>()),
    );
    gh.factory<_i514.ProfileCubit>(
      () => _i514.ProfileCubit(gh<_i496.ProfileRepository>()),
    );
    gh.factory<_i366.SettingsCubit>(
      () => _i366.SettingsCubit(gh<_i496.ProfileRepository>()),
    );
    gh.lazySingleton<_i232.LeaderboardRepository>(
      () => _i721.LeaderboardRepositoryImpl(
        gh<_i74.LeaderboardLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i468.AuthRepository>(
      () => _i452.AuthRepositoryImpl(
        gh<_i468.AuthRemoteDataSource>(),
        gh<_i468.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i447.GetLetterPuzzleUseCase>(
      () => _i447.GetLetterPuzzleUseCase(gh<_i82.GamesRepository>()),
    );
    gh.lazySingleton<_i778.SaveGameResultUseCase>(
      () => _i778.SaveGameResultUseCase(gh<_i82.GamesRepository>()),
    );
    gh.factory<_i439.LetterGameCubit>(
      () => _i439.LetterGameCubit(
        gh<_i447.GetLetterPuzzleUseCase>(),
        gh<_i778.SaveGameResultUseCase>(),
      ),
    );
    gh.factory<_i470.LetterTraceCubit>(
      () => _i470.LetterTraceCubit(
        gh<_i447.GetLetterPuzzleUseCase>(),
        gh<_i778.SaveGameResultUseCase>(),
      ),
    );
    gh.lazySingleton<_i463.GetFollowersUseCase>(
      () => _i463.GetFollowersUseCase(gh<_i232.LeaderboardRepository>()),
    );
    gh.lazySingleton<_i60.GetLeaderboardUseCase>(
      () => _i60.GetLeaderboardUseCase(gh<_i232.LeaderboardRepository>()),
    );
    gh.lazySingleton<_i982.GetOnboardingQuestionsUseCase>(
      () =>
          _i982.GetOnboardingQuestionsUseCase(gh<_i270.OnboardingRepository>()),
    );
    gh.lazySingleton<_i1012.GetOnboardingStatusUseCase>(
      () => _i1012.GetOnboardingStatusUseCase(gh<_i270.OnboardingRepository>()),
    );
    gh.lazySingleton<_i444.SaveOnboardingAnswersUseCase>(
      () =>
          _i444.SaveOnboardingAnswersUseCase(gh<_i270.OnboardingRepository>()),
    );
    gh.lazySingleton<_i875.LoginUseCase>(
      () => _i875.LoginUseCase(gh<_i468.AuthRepository>()),
    );
    gh.lazySingleton<_i333.LogoutUseCase>(
      () => _i333.LogoutUseCase(gh<_i468.AuthRepository>()),
    );
    gh.factory<_i711.LetterReviewCubit>(
      () => _i711.LetterReviewCubit(gh<_i447.GetLetterPuzzleUseCase>()),
    );
    gh.factory<_i816.OnboardingCubit>(
      () => _i816.OnboardingCubit(
        gh<_i982.GetOnboardingQuestionsUseCase>(),
        gh<_i444.SaveOnboardingAnswersUseCase>(),
      ),
    );
    gh.factory<_i659.AuthCubit>(
      () =>
          _i659.AuthCubit(gh<_i468.LoginUseCase>(), gh<_i468.LogoutUseCase>()),
    );
    gh.factory<_i229.FollowersCubit>(
      () => _i229.FollowersCubit(gh<_i463.GetFollowersUseCase>()),
    );
    gh.factory<_i409.LeaderboardCubit>(
      () => _i409.LeaderboardCubit(gh<_i60.GetLeaderboardUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
