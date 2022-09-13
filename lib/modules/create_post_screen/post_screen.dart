

  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class CreatePostScreen  extends StatelessWidget {

  var postController = TextEditingController();
  var formKey = GlobalKey<FormState>();
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){},
                icon:const Icon(Icons.arrow_back_ios_new),
              ),
              title:const Text('Create New Post',),
              actions: [
                TextButton(onPressed: (){
                  if(formKey.currentState!.validate()){
                    if(cubit.postImage==null){
                      cubit.createPost(text: postController.text, dateTime: DateTime.now().toString());
                    }else {
                      cubit.uploadPostImage(dateTime: DateTime.now().toString(), text: postController.text);
                    }
                    postController.text='';
                    cubit.removePostImage();
                  }
                },
                  child:const Text(
                    'POST',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 4.0,),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is UploadPostImageLoadingState || state is AppCreatePostLoadingState)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: LinearProgressIndicator(),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                        ),
                        const SizedBox(width: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.userModel!.name!,
                              style:const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                            const Text(
                              'Public Post',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0,),
                    Expanded(
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty) return 'Enter post';
                          else return null;
                        },
                        controller: postController,
                        decoration:const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What\'s on your mind ... ',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0,),
                    if(cubit.postImage!=null)
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
                            child:Image.file(cubit.postImage!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 17.0,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                onPressed: (){
                                  cubit.removePostImage();
                                },
                                icon:const Icon(Icons.close,color: Colors.white,size: 18.0,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 4.0,),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: (){
                              cubit.pickPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:const [
                                Icon(Icons.image),
                                SizedBox(width: 8.0,),
                                Text(
                                  'add photo',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: (){},
                            child: Text(
                              '# tags',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
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
