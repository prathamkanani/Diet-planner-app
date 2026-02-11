import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../application/logic/onboarding/onboarding_cubit.dart';
import '../../../../../../domain/eum/gender_enum.dart';
import '../../../../../config/app_spacing.dart';
import '../meal_planning/check_circle_container.dart';

class UserDetailSection extends StatefulWidget {
  final TextEditingController ageController;
  final TextEditingController locationController;
  final void Function(Gender) selectedGender;

  const UserDetailSection({
    super.key,
    required this.ageController,
    required this.locationController,
    required this.selectedGender
  });

  @override
  State<UserDetailSection> createState() => _UserDetailSectionState();
}

class _UserDetailSectionState extends State<UserDetailSection> {
  late final OnboardingCubit cubit = context.read<OnboardingCubit>();
  late Gender? gender = cubit.gender;

  void _handleTap(Gender selectGender) {
    setState(() {
      gender = (gender == selectGender) ? null : selectGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Tell us a little bit about yourself',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h24,
          Text('Please select a gender', style: textTheme.titleSmall),
          AppSpacing.h08,
          Row(
            children: Gender.values.map((final Gender g) {
              final bool isSelected = gender == g;
              isSelected? widget.selectedGender(g): null;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: (g.index == 0) ? 8.0 : 0.0),
                  child: CheckCircleContainer(
                    title: g.gender,
                    isSelected: isSelected,
                    onTap: _handleTap,
                    value: g,
                  ),
                ),
              );
            }).toList(),
          ),
          AppSpacing.h16,
          Text('How old are you?', style: textTheme.titleSmall),
          AppSpacing.h08,
          TextFormField(
            controller: widget.ageController,
            keyboardType: TextInputType.number,
          ),
          AppSpacing.h16,
          Text('Where do you live? (country)', style: textTheme.titleSmall),
          AppSpacing.h08,
          TextFormField(
            controller: widget.locationController,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
