import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/common/logout_button.dart';
import 'package:moscore/presentation/resources/assets/assets.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';
import 'package:moscore/presentation/resources/fonts/fonts_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../resources/components/components.dart';
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
              : AdaptiveCircleIndicator();
        },
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      actions: [
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.edit),
          ),
        )
      ],
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
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileCubit.usersModel!.image),
              onBackgroundImageError: (exception, stackTrace) => const Image(
                image: AssetImage(AssetsResources.logo),
              ),
              radius: AppSize.s60,
            ),
            CircleAvatar(
              backgroundColor: ColorManager.darkPrimary,
              child: InkWell(
                onTap: () {
                  profileCubit.pickImage();
                },
                child:
                    Icon(Icons.camera_alt_outlined, color: ColorManager.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Text(
          profileCubit.usersModel!.name,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: FontsSize.s22),
        ),
        if (profileCubit.state is ImagePickedSuccess)
          Column(
            children: [
              const SizedBox(height: AppSize.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profileCubit.state is UpdateUserDataLoading
                      ? AdaptiveCircleIndicator()
                      : MaterialButton(
                          onPressed: () {
                            profileCubit.uploadImage(context);
                          },
                          textColor: ColorManager.white,
                          color: ColorManager.lightPrimary,
                          height: AppSize.s40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: const Text(StringManager.updateImage),
                        ),
                  Icon(
                    Icons.image,
                    color: ColorManager.white,
                  )
                ],
              ),
            ],
          )
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
