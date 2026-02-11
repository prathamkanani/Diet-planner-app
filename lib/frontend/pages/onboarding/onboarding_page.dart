import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../application/logic/onboarding/onboarding_state.dart';
import '../../../application/service/app_data_service.dart';
import '../../../domain/eum/activity_level_entity.dart';
import '../../../domain/entity/dialog_entity.dart';
import '../../../domain/entity/health_habits_entity.dart';
import '../../../domain/entity/meal_planning.dart';
import '../../../domain/entity/onboarding_entity.dart';
import '../../../domain/eum/gender_enum.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../../infrastructure/model/profile_model.dart';
import '../../config/app_spacing.dart';
import '../home/home_page.dart';
import '../setup/setup_page.dart';
import 'widgets/bottom_action_bar.dart';
import 'widgets/pageview_indicator.dart';
import 'widgets/onboarding_sections/activity_level/activity_level_section.dart';
import 'widgets/onboarding_sections/health_habits/health_habits_section.dart';
import 'widgets/onboarding_sections/meal_planning/meal_planning_section.dart';
import 'widgets/onboarding_sections/more_about/more_about_user_section.dart';
import 'widgets/onboarding_sections/user_detail/user_detail_section.dart';
import 'widgets/onboarding_sections/username_section/username_section.dart';
import 'widgets/onboarding_sections/widgets/alert_dialog.dart';

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

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
    userNameController.dispose();
    ageController.dispose();
    locationController.dispose();
    heightController.dispose();
    weightController.dispose();
    cubit.close();
    super.dispose();
  }

  void _goBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextPage() {
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
      country: locationController.text,
      profileEntity: profile,
      healthHabits: cubit.healthHabits,
      mealPlanning: cubit.mealPlan!,
      activityLevel: cubit.activityLevel!,
    );

    appDataService.profile = profile;
    appDataService.isNewUser = true;
    await cubit.saveOnboardingDetails(onboard);
    cubit.generateMealPlan(onboard);
  }

  void _next(BuildContext context) {
    if ((userNameController.text.isEmpty && _currentPage == 0) ||
        (cubit.mealPlan == null && _currentPage == 2) ||
        (cubit.activityLevel == null && _currentPage == 3) ||
        (ageController.text.isEmpty &&
            locationController.text.isEmpty &&
            cubit.gender == null &&
            _currentPage == 4) ||
        (heightController.text.isEmpty &&
            weightController.text.isEmpty &&
            _currentPage == 5)) {
      dialogBuilder(context, _currentPage);
    } else {
      _currentPage == 5 ? _storeOnboardingEntity() : _goToNextPage();
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

  /// To update page and its current index.
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    FocusManager.instance.primaryFocus?.unfocus();
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
            PageviewIndicator(count: 6, currentPage: _currentPage),
            AppSpacing.h16,
            Expanded(
              child: BlocProvider.value(
                value: cubit,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: _onPageChanged,
                  children:
                      <Widget>[
                        UsernameSection(controller: userNameController),
                        HealthHabitsSection(
                          selectedHabit: (List<HealthHabits> h) {
                            cubit.healthHabits = h;
                          },
                        ),
                        MealPlanningSection(
                          advanceMealPlanning: (MealPlanning m) {
                            cubit.mealPlan = m;
                          },
                        ),
                        ActivityLevelSection(
                          selectedActivity: (ActivityLevel a) {
                            cubit.activityLevel = a;
                          },
                        ),
                        UserDetailSection(
                          ageController: ageController,
                          locationController: locationController,
                          selectedGender: (Gender g) {
                            cubit.gender = g;
                          },
                        ),
                        MoreAboutUserSection(
                          heightController: heightController,
                          weightController: weightController,
                        ),
                      ].map((widget) {
                        return Padding(padding: const .all(16), child: widget);
                      }).toList(),
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
