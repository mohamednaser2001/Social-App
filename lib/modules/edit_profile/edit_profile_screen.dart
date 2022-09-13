


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';

class EditProfileScreen extends  StatelessWidget {

  var nameController= TextEditingController();
  var phoneController= TextEditingController();
  var bioController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = AppCubit.get(context).userModel;
        AppCubit cubit = AppCubit.get(context);
        nameController.text=model!.name!;
        phoneController.text=model.phone!;
        bioController.text=model.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.arrow_back_ios,size: 20.0,color: Colors.black,),

            ),
            title:const Text(
              'Edit Screen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                cubit.updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
              },
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
              ),
              const SizedBox(width: 8.0,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is UpdateUserDataLoadingState || state is AppGetUserDataLoadingState || state is UploadCoverImageLoadingState || state is UploadProfileImageLoadingState)
                    const SizedBox(height: 5.0,),
                  if(state is UpdateUserDataLoadingState || state is AppGetUserDataLoadingState || state is UploadCoverImageLoadingState || state is UploadProfileImageLoadingState)
                    const LinearProgressIndicator(),
                  if(state is UpdateUserDataLoadingState || state is AppGetUserDataLoadingState || state is UploadCoverImageLoadingState || state is UploadProfileImageLoadingState)
                    const SizedBox(height: 5.0,),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 150.0,
                                width: double.infinity,
                                decoration:const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                //cover photo
                                child:cubit.coverImage!=null ?Image.file(cubit.coverImage!) : Image.network(
                                  '${model.coverImage}',
                                  height: 150.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: CircleAvatar(
                                  radius: 17.0,
                                  child: IconButton(
                                    onPressed: (){
                                      cubit.pickCoverImage(context);
                                    },
                                    icon:Icon(Icons.camera_alt_outlined,color: Colors.white,size: 18.0,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0,),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [

                          Container(
                            width: 120.0,
                            height: 120.0,
                            padding:const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child:cubit.profileImage==null ? Image.network(
                                '${model.image}',
                                fit: BoxFit.cover,
                              ) : Image.file(cubit.profileImage!),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 17.0,
                              child: IconButton(
                                  onPressed: ()async{
                                    AppCubit.get(context).pickProfileImage(context);
                                  },
                                  icon:Icon(Icons.camera_alt_outlined,color: Colors.white,size: 18.0,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  defaultTextFormField(
                    validator: (value){
                      if(value!.isEmpty){return 'Enter your name';}
                      else return null;
                    },
                    controller:nameController,
                    withBorder: true,
                    text: 'Name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 10.0,),
                  defaultTextFormField(
                    validator: (value){
                      if(value!.isEmpty){return 'Enter your phone';}
                      else return null;
                    },
                    controller:phoneController,
                    withBorder: true,
                    text: 'Phone',
                    icon: Icons.local_phone_outlined,
                  ),
                  const SizedBox(height: 10.0,),
                  defaultTextFormField(
                    validator: (value){
                      if(value!.isEmpty){return 'Enter your bio';}
                      else return null;
                    },
                    controller:bioController,
                    withBorder: true,
                    text: 'Bio',
                   // icon: Icons.person_outline,
                    isDescription: true,
                  ),
                ],
              ),
            ),
          ),
        );

      },
    );
  }
}
