import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../application/formatters/phone_formatter.dart';
import '../../../application/logic/profile/profile_cubit.dart';
import '../../../application/validator/email_validator.dart';
import '../../../application/validator/name_validator.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../infrastructure/app_injector.dart';
import '../../config/app_spacing.dart';
import 'widgets/user_avatar.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late final ProfileCubit profileCubit;
  late final TextEditingController fullNameController,
      emailController,
      mobileNumController,
      ageController,
      genderController,
      heightController,
      weightController;
  final ProfileEntity profile = locator.get<ProfileEntity>();

  @override
  void initState() {
    super.initState();
    profileCubit = locator.get<ProfileCubit>()..createProfile(profile: profile);
    fullNameController = TextEditingController(text: profile.fullName);
    emailController = TextEditingController(text: profile.email);
    mobileNumController = TextEditingController(text: profile.mobileNumber);
    ageController = TextEditingController();
    genderController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileNumController.dispose();
    ageController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            // User Avatar
            UserAvatar(profileCubit: profileCubit, profileEntity: profile),
            AppSpacing.h16,

            // Full Name Text Field
            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Full Name'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: fullNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => nameValidator(value),
              decoration: const InputDecoration(
                hintText: 'Enter your full name',
              ),
            ),
            AppSpacing.h16,

            // Email Text Field
            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Email'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => emailValidator(value),
              decoration: const InputDecoration(hintText: 'Enter your email'),
              keyboardType: TextInputType.emailAddress,
            ),
            AppSpacing.h16,

            // Mobile Number Text Field
            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Mobile number'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: mobileNumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Mobile Number'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PhoneInputFormatter(),
              ],
            ),
            AppSpacing.h16,

            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Age'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(hintText: 'Enter your age'),
              keyboardType: TextInputType.number,
            ),
            AppSpacing.h16,

            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Gender'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: genderController,
              decoration: const InputDecoration(hintText: 'Enter your gender'),
            ),
            AppSpacing.h16,

            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Height'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: heightController,
              decoration: const InputDecoration(hintText: 'Enter your height'),
            ),
            AppSpacing.h16,

            const Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text('Weight'),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: weightController,
              decoration: const InputDecoration(hintText: 'Enter your weight'),
            ),
            AppSpacing.h16,
          ],
        ),
      ),
    );
  }
}
