// Flutter Framework
export 'package:flutter/material.dart';
export 'package:flutter_localizations/flutter_localizations.dart';

// Package Dependencies
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:get_it/get_it.dart';
export 'package:go_router/go_router.dart';

// Core Constants & Theme
export '../constants/app_assets.dart';
export '../constants/app_constants.dart';
export '../constants/app_dimensions.dart';
export '../theme/app_colors.dart';
export '../theme/app_text_styles.dart';
export '../theme/app_theme.dart';

// Core Routing & DI
export '../routing/app_router.dart';
export '../routing/app_routes.dart';
export '../routing/app_shell_route.dart';
export '../dependency_injection/injection.dart';

// Core Utils
export 'usecase.dart';
export 'validators.dart';

export 'package:hive_flutter/hive_flutter.dart';
export '../../../../core/utils/app_imports.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:flutter_tts/flutter_tts.dart';
export '../services/letter_audio_service.dart';
export 'package:game_test/modules/home/learning/presentation/widgets/level_color_mapper.dart';
export 'package:game_test/modules/home/learning/presentation/widgets/lesson_intro_info_box.dart';
export 'package:game_test/modules/home/learning/presentation/widgets/lesson_intro_play_button.dart';
export 'package:game_test/modules/home/learning/presentation/widgets/lesson_intro_play_step.dart';
export 'package:game_test/modules/home/learning/domain/entities/level_type.dart';
export 'package:game_test/modules/home/learning/domain/entities/lesson_entity.dart';
export 'package:game_test/modules/home/learning/domain/entities/level_entity.dart';
export 'package:injectable/injectable.dart';
export 'package:game_test/core/dependency_injection/injection.config.dart';
export 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
export 'package:equatable/equatable.dart';
export '../../modules/authentication/presentation/pages/login_page.dart';
export '../../modules/splash/presentation/pages/splash_page.dart';
export '../../modules/home/games/presentation/pages/letter_game_page.dart';
export '../../modules/home/games/presentation/pages/great_job_page.dart';
export '../../modules/home/games/presentation/pages/letter_review_page.dart';
export '../../modules/home/games/presentation/pages/letter_trace_page.dart';
export '../../modules/home/games/presentation/pages/letter_quiz_page.dart';
export '../../modules/home/games/presentation/pages/number_quiz_page.dart';
export '../../modules/home/games/presentation/pages/word_lesson_page.dart';
export '../../modules/home/games/presentation/pages/grammar_lesson_page.dart';
export '../../modules/home/games/presentation/pages/tashkeel_lesson_page.dart';
export '../../modules/home/learning/presentation/pages/lesson_intro_page.dart';
export '../../modules/onboarding/presentation/pages/onboarding_page.dart';
export '../../modules/achievements/presentation/pages/achievements_page.dart';
export '../../modules/layout/presentation/pages/layout_page.dart';
export '../../modules/leaderboard/presentation/pages/leaderboard_page.dart';
export '../../modules/leaderboard/presentation/pages/followers_page.dart';
export '../../modules/profile/presentation/pages/profile_page.dart';
export '../../modules/profile/presentation/pages/settings_page.dart';
export '../../modules/profile/presentation/pages/feedback_page.dart';
export '../../modules/profile/presentation/pages/help_center_page.dart';
export '../../modules/home/learning/presentation/pages/levels_map_page.dart';
export '../errors/failures.dart';
export 'package:game_test/modules/authentication/presentation/cubit/auth_cubit.dart';
export 'package:game_test/modules/authentication/presentation/widgets/login_form_body.dart';
export 'package:flutter/gestures.dart';
export 'package:game_test/modules/authentication/presentation/widgets/login_footer.dart';
export 'package:game_test/modules/authentication/presentation/widgets/login_social_row.dart';
export 'package:game_test/modules/authentication/presentation/widgets/remember_me_row.dart';
export '../../../../core/widgets/app_button.dart';
export '../../../../core/widgets/app_text_field.dart';
export '../../../../core/widgets/coming_soon_snackbar.dart';
export '../../../../core/widgets/neo_container.dart';
export '../../../../core/widgets/app_search_field.dart';
export 'package:game_test/modules/authentication/domain/usecases/login_usecase.dart';
export 'package:game_test/modules/authentication/domain/usecases/logout_usecase.dart';
export 'package:game_test/modules/authentication/domain/entities/user_entity.dart';
export 'package:game_test/modules/authentication/domain/repositories/auth_repository.dart';
export 'package:firebase_auth/firebase_auth.dart';
export '../../../../core/errors/exceptions.dart';
export '../../../../core/networking/network_info.dart';
export 'package:game_test/modules/authentication/data/datasources/auth_remote_datasource.dart';
export 'package:game_test/modules/authentication/data/models/user_model.dart';

// Games domain (puzzle brick entities)
export 'package:game_test/modules/home/games/domain/entities/letter_puzzle.dart';
export 'package:game_test/modules/home/games/domain/entities/puzzle_brick.dart';
export 'package:game_test/modules/home/games/domain/entities/block_position.dart';
export 'package:game_test/modules/home/games/domain/entities/game_result.dart';
export 'package:game_test/modules/home/games/domain/entities/letter_form.dart';

// Profile cubits & states
export 'package:game_test/modules/profile/presentation/cubit/profile_cubit.dart';
export 'package:game_test/modules/profile/presentation/cubit/settings_cubit.dart';
export 'package:game_test/modules/profile/presentation/cubit/feedback_cubit.dart';
export 'package:game_test/modules/profile/presentation/cubit/help_center_cubit.dart';

// Profile domain entities
export 'package:game_test/modules/profile/domain/entities/user_profile.dart';
export 'package:game_test/modules/profile/domain/entities/user_stat.dart';
export 'package:game_test/modules/profile/domain/entities/app_settings.dart';
export 'package:game_test/modules/profile/domain/entities/feedback_draft.dart';
export 'package:game_test/modules/profile/domain/entities/help_topic.dart';
export 'package:game_test/modules/profile/domain/entities/profile_link.dart';
