import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/formatters/phone_formatter.dart';
import '../../../application/logic/profile/profile_cubit.dart';
import '../../../application/logic/profile/profile_state.dart';
import '../../../application/service/app_data_service.dart';
import '../../../application/validator/email_validator.dart';
import '../../../application/validator/name_validator.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
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

  void initialProfile(ProfileState state) {
    if (state is ProfileSavedState) {
      fullNameController.text = state.profile.fullName ?? '';

      emailController.text = state.profile.email ?? '';

      mobileNumController.text = state.profile.mobileNumber ?? '';

      ageController.text = state.profile.age.toString();

      genderController.text = state.profile.gender?.gender ?? '';

      heightController.text = state.profile.height.toString();
      weightController.text = state.profile.weight.toString();
    }
  }

  void onChange() {
    final updatedProfile = ProfileEntity(
      userId: appDataService.userId!,
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      appBar: AppBar(title: Text(S.of(context).userProfile), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            bloc: profileCubit,
            listener: (context, state) {
              initialProfile(state);
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    UserAvatar(
                      profileCubit: profileCubit,
                      profileEntity: state.profile,
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
                      onChanged: (_) => onChange(),
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
                      onChanged: (_) => onChange(),
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
                      onChanged: (_) => onChange(),
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
                      onChanged: (_) => onChange(),
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
                      onChanged: (_) => onChange(),
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
                      onChanged: (_) => onChange(),
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
                      onChanged: (_) => onChange(),
                      decoration: InputDecoration(
                        hintText: S.of(context).enterYourWeight,
                        contentPadding: .zero,
                        fillColor: cs.secondaryContainer,
                        enabledBorder: InputBorder.none,
                        focusedBorder: const UnderlineInputBorder(),
                      ),
                    ),
                    AppSpacing.h16,
                    BlocBuilder<ProfileCubit, ProfileState>(
                      bloc: profileCubit,
                      // buildWhen: (_, next) => next is ProfileEditState,
                      builder: (context, state) {
                        if(state is ProfileEditState){
                          return FilledButton(
                            onPressed: () {
                              profileCubit.saveProfile(profile: state.profile);
                            },
                            child: Text(S.of(context).saveProfile),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
