
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

import 'chat_description.dart';

class ChatScreen extends  StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
         listener: (context, state){},
         builder: (context, state){
           AppCubit cubit =AppCubit.get(context);
           return ConditionalBuilder(
             condition: cubit.users.length>0,
             builder: (context)=> Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: ListView.separated(
                 physics:const BouncingScrollPhysics(),
                 itemBuilder: (context, index)=>chatUserItem(context, cubit.users[index]),
                 separatorBuilder:(context,index)=> line(),
                 itemCount:cubit.users.length,
               ),
             ),
             fallback:(context)=>const Center(child: CircularProgressIndicator()),
           );
         },
    );
  }

  Widget chatUserItem(context, UserModel model)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDescription(model: model,));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 27.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(width: 10.0,),
          Text(
            '${model.name}',
            style:const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}

