import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../application/formatters/phone_formatter.dart';
import '../../../application/logic/auth/auth_cubit.dart';
import '../../../application/logic/profile/profile_cubit.dart';
import '../../../application/logic/profile/profile_state.dart';
import '../../../application/service/app_data_service.dart';
import '../../../application/validator/email_validator.dart';
import '../../../application/validator/name_validator.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../app/router/route_paths.dart';
import '../../config/app_spacing.dart';
import 'widgets/user_avatar.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final AppDataService appDataService = locator.get<AppDataService>();
  late final ProfileCubit profileCubit;
  late final TextEditingController fullNameController,
      emailController,
      mobileNumController,
      ageController,
      genderController,
      heightController,
      weightController;
  ProfileEntity? profile;

  @override
  void initState() {
    super.initState();
    profileCubit = locator.get<ProfileCubit>()
      ..getProfile(appDataService.userId!);
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumController = TextEditingController();
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
    final ColorScheme cs = context.cs;

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      appBar: AppBar(
        title: Text(S.of(context).userProfile),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              locator.get<AuthCubit>().signOut();
              context.go(RoutePaths.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            bloc: profileCubit,
            listener: (context, state) {
              initialProfile(state);
            },
            builder: (context, state) {
              Widget? saveButton;
              String? avatarUrl;

              if (state is ProfileSavedState) {
                profile = state.profile;
                avatarUrl = profile?.avatarUrl;
              }

              if (state is ProfileEditState) {
                avatarUrl = state.profile.avatarUrl;
                saveButton = FilledButton(
                  onPressed: () {
                    profileCubit.saveProfile(profile: state.profile);
                  },
                  child: Text(S.of(context).saveProfile),
                );
              }

              if (state is ProfileSavedState || state is ProfileEditState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      UserAvatar(
                        profileCubit: profileCubit,
                        profileEntity: profile!,
                      ),
                      AppSpacing.h16,

                      // Full Name Text Field
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).fullName),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: fullNameController,
                        onChanged: (_) => onChange(avatarUrl),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => nameValidator(value),
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourFullName,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                      ),
                      AppSpacing.h16,

                      // Email Text Field
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).email),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: emailController,
                        onChanged: (_) => onChange(avatarUrl),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => emailValidator(value),
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourEmail,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AppSpacing.h16,

                      // Mobile Number Text Field
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).mobileNumber),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: mobileNumController,
                        onChanged: (_) => onChange(avatarUrl),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourMobileNumber,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneInputFormatter(),
                        ],
                      ),
                      AppSpacing.h16,

                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).age),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: ageController,
                        onChanged: (_) => onChange(avatarUrl),
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourAge,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      AppSpacing.h16,

                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).gender),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: genderController,
                        onChanged: (_) => onChange(avatarUrl),
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourGender,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                      ),
                      AppSpacing.h16,

                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).height),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: heightController,
                        onChanged: (_) => onChange(avatarUrl),
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourHeight,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                      ),
                      AppSpacing.h16,

                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(S.of(context).weight),
                      ),
                      AppSpacing.h04,
                      TextFormField(
                        controller: weightController,
                        onChanged: (_) => onChange(avatarUrl),
                        decoration: InputDecoration(
                          hintText: S.of(context).enterYourWeight,
                          contentPadding: .zero,
                          fillColor: cs.secondaryContainer,
                          enabledBorder: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                        ),
                      ),
                      AppSpacing.h16,
                      ?saveButton,
                    ],
                  ),
                );
              }
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  //region Custom Methods
  void initialProfile(ProfileState state) {
    if (state is ProfileSavedState) {
      final profile = state.profile;

      fullNameController.text = profile.fullName ?? '';

      emailController.text = profile.email ?? '';

      mobileNumController.text = profile.mobileNumber ?? '';

      ageController.text = profile.age.toString();

      genderController.text = Intl.message(profile.gender?.name ?? '');

      heightController.text = profile.height.toString();
      weightController.text = profile.weight.toString();
    }
  }

  void onChange(String? avatarUrl) {
    final updatedProfile = ProfileEntity(
      userId: appDataService.userId!,
      avatarUrl: avatarUrl,
      fullName: fullNameController.text,
      email: emailController.text,
      mobileNumber: mobileNumController.text,
      age: int.tryParse(ageController.text),
      height: double.tryParse(heightController.text),
      weight: double.tryParse(weightController.text),
      gender: Gender.values.byName(genderController.text.toLowerCase()),
    );

    profileCubit.onProfileChanged(profile: updatedProfile);
  }

  //endregion
}
