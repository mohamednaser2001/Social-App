
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/create_post_screen/post_screen.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';

class HomeScreen extends  StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit =AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.length > 0 && cubit.userModel !=null&& cubit.posts.length >0,
          builder: (context)=> SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, CreatePostScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                ),
                                const SizedBox(width: 10.0,),
                                Expanded(
                                  child: Text(
                                    'What is on your mind ...',
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){},
                                  icon:const Icon(Icons.more_horiz),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0,),
                            line(),
                            const SizedBox(height: 10.0,),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/image.png',color: Colors.blueAccent,height: 20.0,width: 20.0,),
                                      const SizedBox(width: 8.0,),
                                      Text('Image'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/tag.png',color: Colors.red,height: 20.0,width: 20.0,),
                                      const SizedBox(width: 8.0,),
                                      Text('Tags'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset('assets/images/google-docs.png',color: Colors.green,height: 20.0,width: 20.0,),
                                      const SizedBox(width: 8.0,),
                                      Text('Documents'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>postItem(context, cubit.posts[index],index),
                    separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                    itemCount: cubit.posts.length,
                  ),
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

}
