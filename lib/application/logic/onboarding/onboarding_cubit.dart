import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../domain/entity/activity_level_entity.dart';
import '../../../domain/entity/gender_enum.dart';
import '../../../domain/entity/health_habits_entity.dart';
import '../../../domain/entity/meal_planning_entity.dart';
import '../../../domain/entity/onboarding_entity.dart';
import '../../../domain/repository/onboarding_repository.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  OnboardingCubit({required this.repository})
    : super(const OnboardingLoadingState());

  /// Health Habits
  Set<HealthHabits> healthHabits = {};

  /// Meal planning
  MealPlanning? mealPlan;

  /// Gender
  Gender? gender;

  /// Activity Level
  ActivityLevelEntity? activityLevel;
  final List<ActivityLevelEntity> activityLevels = [
    const ActivityLevelEntity(
      id: 1,
      title: ActivityLevelTitle.notVeryActive,
      subtitle: ActivityLevelSubtitle.notVeryActive,
    ),
    const ActivityLevelEntity(
      id: 2,
      title: ActivityLevelTitle.lightlyActive,
      subtitle: ActivityLevelSubtitle.lightlyActive,
    ),
    const ActivityLevelEntity(
      id: 3,
      title: ActivityLevelTitle.active,
      subtitle: ActivityLevelSubtitle.active,
    ),
    const ActivityLevelEntity(
      id: 4,
      title: ActivityLevelTitle.veryActive,
      subtitle: ActivityLevelSubtitle.veryActive,
    ),
  ];

  /// A stream subscriber that subscribes a stream of AI response.
  StreamSubscription<Map<String, dynamic>>? promptSubscriber;

  Map<String, dynamic> json = {};

  Future<void> saveOnboardingDetails(OnboardingEntity onboard) async {
    try {
      final OnboardingEntity onboardingEntity = await repository
          .saveOnboardingDetails(onboard);
      emit(OnboardingLoadedState(onboardingEntity));
    } catch (e) {
      emit(OnboardingErrorState(e));
    }
  }

  Future<void> sendPrompt(OnboardingEntity onboard) async {
    emit(const OnboardingPromptState(true));
    promptSubscriber = repository.sendPrompt(onboard).listen(null);
    promptSubscriber?.onData((Map<String, dynamic> j) {
      json.addAll(j);
      emit(OnboardingLoadedState(onboard));
    });
  }
}
