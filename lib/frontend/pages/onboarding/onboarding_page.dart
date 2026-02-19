import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../application/logic/onboarding/onboarding_state.dart';
import '../../../application/service/app_data_service.dart';
import '../../../domain/entity/dialog_entity.dart';
import '../../../domain/entity/health_habits_entity.dart';
import '../../../domain/entity/onboarding_entity.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../domain/entity/user_preferences.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../../infrastructure/model/profile_model.dart';
import '../../config/app_spacing.dart';
import '../home/home_page.dart';
import '../setup/setup_page.dart';
import 'widgets/bottom_action_bar.dart';
import 'widgets/onboarding_sections/meal_preference/meal_preference.dart';
import 'widgets/pageview_indicator.dart';
import 'widgets/onboarding_sections/activity_level/activity_level_section.dart';
import 'widgets/onboarding_sections/health_habits/health_habits_section.dart';
import 'widgets/onboarding_sections/meal_planning/meal_planning_section.dart';
import 'widgets/onboarding_sections/more_about/more_about_user_section.dart';
import 'widgets/onboarding_sections/user_detail/user_detail_section.dart';
import 'widgets/onboarding_sections/username_section/username_section.dart';
import 'widgets/onboarding_sections/widgets/alert_dialog.dart';

enum OnboardingSection {
  usernameSection,
  healthHabitsSection,
  mealPlanningSection,
  activityLevelSection,
  mealPreferenceSection,
  userDetailSection,
  moreAboutUserSection,
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final AppDataService appDataService = locator.get<AppDataService>();
  late final OnboardingCubit cubit;
  late final PageController _pageController;
  late final TextEditingController userNameController,
      ageController,
      locationController,
      heightController,
      weightController;
  late final ValueNotifier<int> _currentPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPage = ValueNotifier(0);
    _pageController.addListener(() {
      if (!_pageController.hasClients) return;

      final page = _pageController.page?.round() ?? 0;
      if (_currentPage.value != page) _currentPage.value = page;
    });
    ageController = TextEditingController();
    locationController = TextEditingController();
    userNameController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    cubit = locator.get<OnboardingCubit>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    userNameController.dispose();
    ageController.dispose();
    locationController.dispose();
    heightController.dispose();
    weightController.dispose();
    cubit.close();
    super.dispose();
  }

  void _goBack() {
    FocusManager.instance.primaryFocus?.unfocus();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _storeOnboardingEntity() async {
    final ProfileEntity profile = ProfileModel.fromUserDetails(
      userId: appDataService.userId!,
      name: userNameController.text,
      gender: cubit.gender!,
      age: ageController.text,
      height: heightController.text,
      weight: weightController.text,
    );
    final OnboardingEntity onboard = OnboardingEntity(
      profileEntity: profile,
      userPreferences: UserPreferences(
        healthHabits: cubit.healthHabits,
        mealPlanning: cubit.mealPlan!,
        activityLevel: cubit.activityLevel!,
        mealPref: cubit.mealPref!,
        country: locationController.text,
      ),
    );
    cubit.saveOnboardingDetails(onboard);
    cubit.generateMealPlan(onboard, DateTime.now());
    appDataService.planStartDate = DateTime.now();
  }

  void _next(BuildContext context) {
    final page = _currentPage.value;
    if ((userNameController.text.isEmpty && page == 0) ||
        (cubit.mealPlan == null && page == 2) ||
        (cubit.activityLevel == null && page == 3) ||
        (cubit.mealPref == null && page == 4) ||
        (ageController.text.isEmpty &&
            locationController.text.isEmpty &&
            cubit.gender == null &&
            page == 5) ||
        (heightController.text.isEmpty &&
            weightController.text.isEmpty &&
            page == 6)) {
      dialogBuilder(context, page);
    } else {
      page == 6 ? _storeOnboardingEntity() : _goToNextPage();
    }
  }

  Future<void> dialogBuilder(BuildContext context, int page) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogs.map((dialog) {
          return CustomAlertDialog(dialog: dialog);
        }).toList()[page];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return BlocListener(
      bloc: cubit,
      listenWhen: (prev, next) {
        return next is OnboardingPromptState;
      },
      listener: (context, state) {
        if (state is OnboardingPromptState && state.isLoading == true) {
          context.push(const SetupPage());
        } else {
          context.pushAndRemoveUntil(const HomePage());
        }
      },
      child: Scaffold(
        backgroundColor: cs.secondaryContainer,
        body: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder(
                valueListenable: _currentPage,
                builder: (_, page, _) {
                  return PageviewIndicator(
                    count: OnboardingSection.values.length,
                    currentPage: page,
                  );
                },
              ),
            ),
            AppSpacing.h16,
            Expanded(
              child: BlocProvider.value(
                value: cubit,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: OnboardingSection.values.length,
                  itemBuilder: (_, final int index) {
                    final OnboardingSection type = .values[index];
                    final Widget section = switch (type) {
                      OnboardingSection.usernameSection => UsernameSection(
                        controller: userNameController,
                      ),

                      OnboardingSection.healthHabitsSection =>
                        HealthHabitsSection(
                          selectedHabit: (List<HealthHabits> h) {
                            cubit.healthHabits = h;
                          },
                        ),

                      OnboardingSection.mealPlanningSection =>
                        MealPlanningSection(
                          advanceMealPlanning: (MealPlanning m) {
                            cubit.mealPlan = m;
                          },
                        ),

                      OnboardingSection.activityLevelSection =>
                        ActivityLevelSection(
                          selectedActivity: (ActivityLevel a) {
                            cubit.activityLevel = a;
                          },
                        ),

                      OnboardingSection.mealPreferenceSection =>
                        MealPreferenceView(
                          selectedMealPref: (MealPreferences m) {
                            cubit.mealPref = m;
                          },
                        ),

                      OnboardingSection.userDetailSection => UserDetailSection(
                        ageController: ageController,
                        locationController: locationController,
                        selectedGender: (Gender g) {
                          cubit.gender = g;
                        },
                      ),

                      OnboardingSection.moreAboutUserSection =>
                        MoreAboutUserSection(
                          heightController: heightController,
                          weightController: weightController,
                        ),
                    };

                    return Padding(padding: const .all(16), child: section);
                  },
                ),
              ),
            ),
          ],
        ),
        // This lifts up the bottom nav bar.
        // insets - part of the screen completely
        // obscured by system UI(like keyboard).
        // viewInsetsOf.bottom pushes the content
        // up by the exact height of keyboard.
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: BottomActionBar(
            onPrevious: _goBack,
            onNext: () => _next(context),
          ),
        ),
      ),
    );
  }
}
