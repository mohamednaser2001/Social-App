
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class SettingsScreen extends  StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = AppCubit.get(context).userModel;
        AppCubit cubit = AppCubit.get(context);
        return Padding(
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
                            '${model!.coverImage}',
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
                          '${model.image}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Text(
                  '${model.name}',
                  style:const TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(
                  '${model.bio}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30.0,),
                userInfo(number: 100,),
                const SizedBox(height: 30.0,),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
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
        );
      },
    );
  }
}
