import 'package:flutter/material.dart';
import '../../../domain/entity/dialog_entity.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../domain/entity/gender_enum.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../../infrastructure/model/profile_model.dart';
import '../../config/app_spacing.dart';
import '../home/home_page.dart';
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
  late final PageController _pageController;
  late final TextEditingController userNameController,
      ageController,
      locationController,
      heightController,
      weightController;

  int mealPlanSelected = -1;
  int activityLevelSelected = -1;
  int currentPage = 0;
  int? selectedGender;

  // TODO: how to register the updated entity.
  late ProfileEntity entity = locator.get<ProfileEntity>();
  late ProfileEntity updatedEntity = ProfileModel.fromEntityToUpdate(
    entity: entity,
    age: ageController.text,
    height: heightController.text,
    weight: weightController.text,
    gender: (selectedGender == 1)
        ? Gender.male.toString()
        : Gender.female.toString(),
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    ageController = TextEditingController();
    locationController = TextEditingController();
    userNameController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    userNameController.dispose();
    ageController.dispose();
    locationController.dispose();
    heightController.dispose();
    weightController.dispose();
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
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            PageviewIndicator(count: 6, currentPage: currentPage),
            AppSpacing.h16,
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: [
                  UsernameSection(controller: userNameController),
                  const HealthHabitsSection(),
                  MealPlanningSection(
                    selectId: (int i) {
                      mealPlanSelected = i;
                    },
                  ),
                  ActivityLevelSection(
                    selectId: (int i) {
                      activityLevelSelected = i;
                    },
                  ),
                  UserDetailSection(
                    ageController: ageController,
                    locationController: locationController,
                    selectedId: (int? id) {
                      selectedGender = id;
                    },
                  ),
                  MoreAboutUserSection(
                    heightController: heightController,
                    weightController: weightController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This lifts up the bottom nav bar.
      // insets - part of the screen completely
      // obscured by system UI(like keyboard).
      // viewInsetsOf.bottom pushes the content
      // up by the exact height of keyboard
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: BottomActionBar(
          onPrevious: _goBack,
          onNext: () {
            if ((userNameController.text.isEmpty && currentPage == 0) ||
                (mealPlanSelected == -1 && currentPage == 2) ||
                (activityLevelSelected == -1 && currentPage == 3)) {
              dialogBuilder(context, currentPage);
            } else {
              currentPage == 5
                  ? context.push(const HomePage())
                  : _goToNextPage();
            }
          },
        ),
      ),
    );
  }
}
