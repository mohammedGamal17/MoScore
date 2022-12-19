import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/profile_cubit/profile_cubit.dart';
import '../../view_model/cubit/profile_cubit/profile_state.dart';

class ProfileUpdate extends StatelessWidget {
  ProfileUpdate({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUserData(context),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit profileCubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: profileCubit.usersModel != null
                ? SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              ImageSection(profileCubit: profileCubit),
                              separator(horizontalPadding: AppPadding.p0),
                              DataSection(
                                profileCubit: profileCubit,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (state is ImagePickedSuccess) {
                                      profileCubit.uploadImage(context);
                                    }
                                    profileCubit.userUpdateData(context);
                                  }
                                },
                                child: const Text(StringManager.update),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                )
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
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
                height: AppSize.s140,
                width: AppSize.s140,
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorManager.darkPrimary,
              child: InkWell(
                onTap: () {
                  profileCubit.pickImage();
                },
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: ColorManager.white,
                ),
              ),
            ),
          ],
        ),
        if (profileCubit.state is ImagePickedSuccess)
          Column(
            children: [
              const SizedBox(height: AppSize.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringManager.imageUploaded,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: AppSize.s6),
                  const Icon(Icons.image)
                ],
              ),
            ],
          )
      ],
    );
  }
}

class DataSection extends StatelessWidget {
  DataSection({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  final _nameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameEditController.text = profileCubit.usersModel!.name;
    return Column(
      children: [
        TextFormField(
          controller: _nameEditController,
          decoration: const InputDecoration(
            labelText: StringManager.name,
            hintText: StringManager.name,
          ),
          validator: (value) {
            /// regular expression to check if string
            RegExp nameValid = RegExp('[a-zA-Z]');

            /// A function that validate user entered email
            bool validateFullName(String user) {
              String name = user.trim();
              if (nameValid.hasMatch(name)) {
                return true;
              } else {
                return false;
              }
            }

            if (value!.isEmpty || value.length < 4) {
              return StringManager.pleaseEnterYourFullName;
            } else {
              bool result = validateFullName(value);
              if (result) {
                return null;
              } else {
                return StringManager.pleaseWriteValidName;
              }
            }
          },
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    );
  }
}
