
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

import '../../models/user_model.dart';

class UsersProfileScreen extends  StatelessWidget {
  UserModel userModel;
  UsersProfileScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration:const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            //cover photo
                            child: Image.network(
                              '${userModel.coverImage}',
                              height: 150.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 50.0,),
                        ],
                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,                    //profile photo
                          backgroundImage: NetworkImage(
                            '${userModel.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    '${userModel.name}',
                    style:const TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  userInfo(number: cubit.userPosts.length),
                  const SizedBox(height: 30.0,),
                  ConditionalBuilder(
                    condition: cubit.userPosts.isEmpty,
                    builder: (context)=>Center(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        'No post yet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                    fallback:(context)=> ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>postItem(context, AppCubit.get(context).userPosts[index],index),
                      separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                      itemCount: AppCubit.get(context).userPosts.length,
                    ),
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
