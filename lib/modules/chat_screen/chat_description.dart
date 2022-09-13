

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class ChatDescription  extends StatelessWidget {

  UserModel model;
  var messageController= TextEditingController();
  ChatDescription({required this.model});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        AppCubit.get(context).getAllMessages(receiverId: model.uId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){},
          builder: (context, state){
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon:const Icon(Icons.arrow_back_outlined),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    const SizedBox(width: 10.0,),
                    Text(
                      '${model.name}',
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(child: ListView.separated(
                      itemBuilder: (context, index){
                        var message = cubit.messages[index];
                        if(cubit.userModel!.uId==message.senderId) return myMessage(context,message);
                        else return receivedMessage(message);
                      },
                      separatorBuilder:(context, index)=>const SizedBox(height: 8.0,),
                      itemCount:cubit.messages.length ,
                    ),),
                    Container(
                      height: 45.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration:const InputDecoration(
                                hintText: 'type your message here ...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                if(messageController.text!=''&&messageController.text!=null){
                                  cubit.sendMessage(text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: model.uId!,
                                  );
                                  messageController.text='';
                                }
                              },
                              icon: Icon(Icons.send_rounded,color: Theme.of(context).primaryColor,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Widget receivedMessage(MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius:const BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Text(
        '${messageModel.text}',
      ),
    ),
  );
  Widget myMessage(context, MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius:const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Text(
        '${messageModel.text}',
      ),
    ),
  );
}
