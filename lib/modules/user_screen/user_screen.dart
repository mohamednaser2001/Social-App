

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/user_profile_screen/user_profile_screen.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';

class UsersScreen extends  StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.isEmpty,
          builder: (context)=>const Center(child: CircularProgressIndicator()),
          fallback: (context)=> ListView.separated(
            itemCount: cubit.users.length,
            itemBuilder: (context, index)=>userItemBuilder(context, cubit.users[index]),
            separatorBuilder: (context, index)=>const SizedBox(height: 10.0,),
          ),
        );
      },
    );
  }

  Widget userItemBuilder(context, UserModel model)=>Card(
    elevation: 2.0,
    color: Colors.white,
    child: InkWell(
      onTap: (){
        AppCubit.get(context).collectUserPosts(model.uId!);
        navigateTo(context, UsersProfileScreen(model));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(width: 10.0,),
            Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
