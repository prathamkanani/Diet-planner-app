import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/profile/profile_cubit.dart';
import '../../../../application/logic/profile/profile_state.dart';
import '../../../../domain/entity/profile_entity.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.profileCubit,
    required this.profileEntity,
  });

  final ProfileCubit profileCubit;
  final ProfileEntity profileEntity;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Stack(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          bloc: profileCubit,
          buildWhen: (previous, current) {
            return current is ProfileEditState;
          },
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileEditState) {
              String avatarSeed = state.profile.avatarUrl!;
              return AvatarPlus(avatarSeed, height: 100, width: 100);
            }
            return const SizedBox.shrink();
          },
        ),
        Positioned(
          top: 75,
          left: 75,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
            ),
            child: IconButton(
              onPressed: () =>
                  profileCubit.changeAvatar(profile: profileEntity),
              icon: const Icon(Icons.change_circle_rounded),
              iconSize: 25,
              padding: EdgeInsets.zero,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}