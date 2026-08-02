// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../modules/authentication/data/datasources/auth_remote_datasource.dart'
    as _i648;
import '../../modules/authentication/data/datasources/mock_auth_remote_datasource.dart'
    as _i643;
import '../../modules/authentication/data/repositories/auth_repository_impl.dart'
    as _i452;
import '../../modules/authentication/domain/repositories/auth_repository.dart'
    as _i457;
import '../../modules/authentication/domain/usecases/login_usecase.dart'
    as _i875;
import '../../modules/authentication/domain/usecases/logout_usecase.dart'
    as _i333;
import '../../modules/authentication/presentation/cubit/auth_cubit.dart'
    as _i659;
import '../../modules/games/data/datasources/games_local_datasource.dart'
    as _i1020;
import '../../modules/games/data/repositories/games_repository_impl.dart'
    as _i340;
import '../../modules/games/domain/repositories/games_repository.dart'
    as _i1028;
import '../../modules/games/domain/usecases/get_letter_puzzle_usecase.dart'
    as _i952;
import '../../modules/games/domain/usecases/save_game_result_usecase.dart'
    as _i714;
import '../../modules/games/presentation/cubit/letter_game_cubit.dart' as _i464;
import '../../modules/learning/data/datasources/learning_local_datasource.dart'
    as _i1022;
import '../../modules/learning/data/repositories/learning_repository_impl.dart'
    as _i418;
import '../../modules/learning/domain/repositories/learning_repository.dart'
    as _i917;
import '../../modules/learning/domain/usecases/get_levels_usecase.dart'
    as _i727;
import '../../modules/learning/presentation/cubit/lesson_intro_cubit.dart'
    as _i1030;
import '../../modules/learning/presentation/cubit/levels_cubit.dart' as _i472;
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
import '../../modules/splash/presentation/cubit/splash_cubit.dart' as _i510;
import '../networking/dio_client.dart' as _i201;
import '../networking/network_info.dart' as _i303;
import '../routing/app_router.dart' as _i282;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i1030.LessonIntroCubit>(() => _i1030.LessonIntroCubit());
    gh.factory<_i510.SplashCubit>(() => _i510.SplashCubit());
    gh.lazySingleton<_i161.InternetConnection>(
      () => registerModule.internetConnection,
    );
    gh.lazySingleton<_i201.DioClient>(() => _i201.DioClient());
    gh.lazySingleton<_i282.AppRouter>(() => _i282.AppRouter());
    gh.lazySingleton<_i668.OnboardingRemoteDataSource>(
      () => _i842.MockOnboardingRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i648.AuthRemoteDataSource>(
      () => _i643.MockAuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i1020.GamesLocalDataSource>(
      () => _i1020.GamesLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i163.OnboardingLocalDataSource>(
      () => _i163.OnboardingLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i303.NetworkInfo>(
      () => _i303.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i1022.LearningLocalDataSource>(
      () => _i1022.LearningLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i917.LearningRepository>(
      () => _i418.LearningRepositoryImpl(gh<_i1022.LearningLocalDataSource>()),
    );
    gh.lazySingleton<_i270.OnboardingRepository>(
      () => _i391.OnboardingRepositoryImpl(
        gh<_i163.OnboardingLocalDataSource>(),
        gh<_i668.OnboardingRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1028.GamesRepository>(
      () => _i340.GamesRepositoryImpl(gh<_i1020.GamesLocalDataSource>()),
    );
    gh.lazySingleton<_i727.GetLevelsUseCase>(
      () => _i727.GetLevelsUseCase(gh<_i917.LearningRepository>()),
    );
    gh.lazySingleton<_i457.AuthRepository>(
      () => _i452.AuthRepositoryImpl(
        gh<_i648.AuthRemoteDataSource>(),
        gh<_i303.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i875.LoginUseCase>(
      () => _i875.LoginUseCase(gh<_i457.AuthRepository>()),
    );
    gh.lazySingleton<_i333.LogoutUseCase>(
      () => _i333.LogoutUseCase(gh<_i457.AuthRepository>()),
    );
    gh.lazySingleton<_i952.GetLetterPuzzleUseCase>(
      () => _i952.GetLetterPuzzleUseCase(gh<_i1028.GamesRepository>()),
    );
    gh.lazySingleton<_i714.SaveGameResultUseCase>(
      () => _i714.SaveGameResultUseCase(gh<_i1028.GamesRepository>()),
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
    gh.factory<_i472.LevelsCubit>(
      () => _i472.LevelsCubit(gh<_i727.GetLevelsUseCase>()),
    );
    gh.factory<_i659.AuthCubit>(
      () =>
          _i659.AuthCubit(gh<_i875.LoginUseCase>(), gh<_i333.LogoutUseCase>()),
    );
    gh.factory<_i816.OnboardingCubit>(
      () => _i816.OnboardingCubit(
        gh<_i982.GetOnboardingQuestionsUseCase>(),
        gh<_i444.SaveOnboardingAnswersUseCase>(),
      ),
    );
    gh.factory<_i464.LetterGameCubit>(
      () => _i464.LetterGameCubit(
        gh<_i952.GetLetterPuzzleUseCase>(),
        gh<_i714.SaveGameResultUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
