

import 'package:flutter/material.dart';

import '../../models/post_model.dart';
import '../cubit/app_cubit.dart';

Widget line()=>Container(
  height: 1.0,color: Colors.grey.withOpacity(0.3),
);

Future<dynamic> navigateWithoutBack(context,Widget widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>widget),
    (route) => false
);


Future<dynamic> navigateTo(context,Widget widget)=>Navigator.push(context,
    MaterialPageRoute(builder: (context)=>widget),
);


// text form field builder
Widget defaultTextFormField({
  required TextEditingController controller,
  required String ?validator(String ? str),
  IconData ? icon,
  String ? text,
  bool withBorder =true,
  bool isDescription =false,
})=>TextFormField(
  controller: controller,
  validator: validator,
  maxLines:isDescription ? 5:1,
  decoration: InputDecoration(
    border: withBorder ? OutlineInputBorder() : InputBorder.none,
    prefixIcon: Icon(icon),
    labelText: text,
  ),
);


Future<dynamic> showAlertDialog({context,required String text,required Function function})=> showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: (){
              function();
            },
            child: Text('SAVE'),
          ),
        ],
      );
    },
);


Widget postItem(context, PostModel postModel,int index){
  var formKey=GlobalKey<FormState>();
  var commentController=TextEditingController();
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                // postModel.uId
                // AppCubit.get(context).users[]
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27.0,
                    backgroundImage: NetworkImage('${postModel.profileImage}'),
                  ),
                  const SizedBox(width: 10.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${postModel.name}',
                            style:const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(width: 8.0,),
                          Icon(Icons.check_circle,color: Colors.blue,size: 16,),
                        ],
                      ),
                      Text(
                        '${postModel.dateTime}',
                        style:const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),
            line(),
            const SizedBox(height: 10.0,),
            Text(
              '${postModel.text}',
              style:const TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 10.0,),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Text(
                    '#software',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),
            if(postModel.postImage!='')
              Card(
                elevation: 3.0,
                margin: EdgeInsets.zero,
                child: Image.network(
                  '${postModel.postImage}',
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if(postModel.postImage!='')
              const SizedBox(height: 8.0,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Image.asset('assets/images/heart.png',color: Colors.red,height: 20.0,width: 20.0,),
                        const SizedBox(width: 8.0,),
                        Text('${AppCubit.get(context).postsLikes[index]}'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/images/comment.png',color: Colors.amber,height: 20.0,width: 20.0,),
                        const SizedBox(width: 8.0,),
                        Text('${AppCubit.get(context).postsComments[index]} comment'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0,),
            line(),
            const SizedBox(height: 6.0,),

            Row(
              children: [
                CircleAvatar(
                  radius: 17.0,
                  backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty) return 'Enter comment';
                      return null;
                    },
                    onFieldSubmitted: (value){
                      if(formKey.currentState!.validate()){
                        AppCubit.get(context).commentAtPost(AppCubit.get(context).postsId[index], value.toString());
                      }
                      commentController.text='';
                    },
                    decoration:const InputDecoration(
                      hintText: 'Write a comment ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/heart.png',color: Colors.red,height: 20.0,width: 20.0,),
                      const SizedBox(width: 8.0,),
                      Text('Like'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}



Widget userInfo({
  required int number,
})=>Row(
  children: [
    userItemInfo(number: number, title: 'Posts'),
    userItemInfo(number: 100, title: 'Flowers'),
    userItemInfo(number: 50, title: 'flowing'),
    userItemInfo(number: 150, title: 'Photos'),
  ],
);

Widget userItemInfo({required int number, required String title})=>Expanded(
  child: InkWell(
    child: Column(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0,),
        Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6) ,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
    onTap: (){},
  ),
);

