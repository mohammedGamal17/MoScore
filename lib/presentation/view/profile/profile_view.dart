import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/common/logout_button.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';
import 'package:moscore/presentation/resources/fonts/fonts_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../app/shared_preferences/shared_preferences.dart';
import '../../resources/components/components.dart';
import '../../resources/components/sign_in_anonymously_component.dart';
import '../../resources/routes/routes_manager.dart';
import '../../view_model/cubit/profile_cubit/profile_cubit.dart';
import '../../view_model/cubit/profile_cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUserData(context),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccess) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        },
        builder: (context, state) {
          ProfileCubit profileCubit = ProfileCubit.get(context);
          return profileCubit.usersModel != null
              ? ProfileData(profileCubit: profileCubit)
              : Scaffold(body: AdaptiveCircleIndicator());
        },
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  ProfileData({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;
  final _nameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameEditController.text = profileCubit.usersModel!.name;
    return getIt<AppPreferences>().getIsAnonymously()
        ? const SignInAnonymously()
        : DraggableHome(
            title: Text(
              profileCubit.usersModel!.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            headerWidget: ProfileHeader(profileCubit: profileCubit),
            body: [
              Text(
                StringManager.favourites,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              separator(),
              ProfileBody(profileCubit: profileCubit),
              const LogOutButton(),
            ],
          );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s70),
          child: CachedNetworkImage(
            imageUrl: profileCubit.usersModel!.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer(
              gradient: LinearGradient(
                colors: [
                  ColorManager.primary,
                  ColorManager.lightPrimary,
                  ColorManager.white,
                ],
              ),
              child: const CircleAvatar(radius: AppSize.s30),
            ),
            height: AppSize.s144,
            width: AppSize.s144,
          ),
        ),
        const SizedBox(height: AppSize.s10),
        Text(
          profileCubit.usersModel!.name,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: FontsSize.s22),
        ),
      ],
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _favouriteSection(
          context,
          favType: StringManager.player,
          length: profileCubit.favPlayer.length,
        ),
        _favouriteSection(
          context,
          favType: StringManager.team,
          length: profileCubit.favTeam.length,
        ),
        _favouriteSection(
          context,
          favType: StringManager.league,
          length: profileCubit.favLeague.length,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: ElevatedButton(
            child: Text(StringManager.profileUpdate),
            onPressed: () {
              Navigator.pushNamed(context, Routes.profileUpdate);
            },
          ),
        )
      ],
    );
  }

  Widget _favouriteSection(
    context, {
    required String favType,
    required int length,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            favType,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            length.toString(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
