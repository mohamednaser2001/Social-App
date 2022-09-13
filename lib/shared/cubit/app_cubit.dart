

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_screen/chat_screen.dart';
import 'package:social_app/modules/home_sceen/home_screen.dart';
import 'package:social_app/modules/setting_screen/setting_screen.dart';
import 'package:social_app/modules/user_screen/user_screen.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../modules/create_post_screen/post_screen.dart';
import '../components/components.dart';
import '../components/constants.dart';

class AppCubit  extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

 static AppCubit get(context)=>BlocProvider.of(context);

  List<Widget>layoutScreens=[
    HomeScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles=[
    'Home',
    'Chat',
    'Users',
    'Settings',
  ];



  int currentIndex=0;
  void changeBottomNavBarIndex(int index){
    if(index==3) {
      collectUserPosts(userModel!.uId!);
    }
  currentIndex=index;
  emit(AppChangeBottomNavBarState());
  }


  UserModel? userModel;
  void getUserDate(){
    emit(AppGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){
      userModel=UserModel.fromJson(value.data()!);
      emit(AppGetUserDataSuccessState());
    }).catchError((error){
      emit(AppGetUserDataErrorState());
    });
  }





  File? profileImage;
  var picker = ImagePicker();
  void pickProfileImage(context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(ProfileImagePickedSuccess());
      showAlertDialog(
        context: context,
        text: 'Change profile image ?',
        function: (){
          uploadProfileImage();
          Navigator.of(context).pop();
        },
      );
    } else {
      debugPrint('No image selected.');
      emit(ProfileImagePickedError());


    }
  }


  File? coverImage;
  void pickCoverImage(context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage  = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(CoverImagePickedSuccess());
      showAlertDialog(
        context: context,
        text: 'Change cover image ?',
        function: (){
          uploadCoverImage();
          Navigator.of(context).pop();
        },
      );
    } else {
      debugPrint('No image selected.');
      emit(CoverImagePickedError());
    }
  }



  void uploadProfileImage(){
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            updateUser(
              name: userModel!.name!,
              phone: userModel!.phone!,
              bio: userModel!.bio!,
              image: value,
            );
            emit(ProfileImageUploadSuccess());
          }).catchError((error){
            emit(ProfileImageUploadError());
          });
    }).catchError((error){
      emit(ProfileImageUploadError());
    });
  }

  void uploadCoverImage(){
    emit(UploadCoverImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref().child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: userModel!.name!,
          phone: userModel!.phone!,
          bio: userModel!.bio!,
          coverImage: value,
        );
        emit(CoverImageUploadSuccess());
      }).catchError((error){
        emit(CoverImageUploadError());
      });
    }).catchError((error){
      emit(CoverImageUploadError());
    });
  }

  void updateUser({
  required String name,
  required String phone,
  required String bio,
    String? image,
    String? coverImage,
}){
    emit(UpdateUserDataLoadingState());

      UserModel model = UserModel(
          name: name,
          email: userModel!.email,
          phone: phone,
          uId: userModel!.uId,
          bio: bio,
          image:image?? userModel!.image,
          coverImage:coverImage?? userModel!.coverImage,
      );

  FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(model.toMap()).then((value) {
    getUserDate();
  }).catchError((error){
    emit(UpdateUserDataErrorState());
  });

  }



  // pick post image from gallery
  File? postImage;
  void pickPostImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage  = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(PostImagePickedSuccess());
    } else {
      debugPrint('No image selected.');
      emit(PostImagePickedError());
    }
  }

  // upload post image in firebase storage.
  void uploadPostImage({
  required String dateTime,
  required String text,
}){
    emit(UploadPostImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        //call create post method to store post in firebase.
        createPost(
          postImage: value,
            text: text,
            dateTime: dateTime,
        );

        emit(UploadPostImageSuccessState());
      }).catchError((error){
        emit(UploadPostImageErrorState());
      });
    }).catchError((error){
      emit(UploadPostImageErrorState());
    });
  }


  // create post method
  void createPost({
     String? postImage,
    required String text,
    required String dateTime,
  }){
    emit(AppCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      profileImage: userModel!.image,
      postImage: postImage??'',
    );

    FirebaseFirestore.instance.collection('posts').add(model.toMap())
        .then((value) {
       emit(AppCreatePostSuccessState());
    }).catchError((error){
      emit(AppCreatePostErrorState());
    });
  }

  // method to remove post photo
   void removePostImage(){
    postImage=null;
    emit(RemovePostImageState());
   }

   //method to collect specific user posts
  List<PostModel> userPosts=[];
  void collectUserPosts(String id){
    userPosts=[];
    posts.forEach((element) {
      if(element.uId==id){
        userPosts.add(element);
      }
    });

    emit(AppCollectUserPostsSuccessState());
  }

   //method to get all posts
  List<PostModel> posts=[];
  List<String> postsId=[];
  List<int> postsComments=[];
  List<int> postsLikes=[];
   void getPosts(){
     emit(AppGetPostsLoadingState());
     FirebaseFirestore.instance.collection('posts').get()
         .then((value){
           value.docs.forEach((element) {
             element.reference.collection('likes').get()
                 .then((value) {
                   postsLikes.add(value.docs.length);
                   posts.add(PostModel.fromJson(element.data()));
                   postsId.add(element.id);
             }).then((value) {
               emit(AppGetPostsSuccessState());
             }).catchError((error){});
             element.reference.collection('comments').get()
                 .then((value) {
               postsComments.add(value.docs.length);
             }).then((value) {
               emit(AppGetPostsSuccessState());
             }).catchError((error){});
           });
       emit(AppGetPostsSuccessState());
     }).catchError((error){
       emit(AppGetPostsErrorState());
     });
   }

   //method to add like to post.
   void likePost(String postId){
     FirebaseFirestore.instance.collection('posts')
         .doc(postId).collection('likes').doc(userModel!.uId)
         .set({'like':true})
         .then((value) {
           emit(AppLikePostsSuccessState());
     }).catchError((error){
           emit(AppLikePostsErrorState(error.toString()));
     });
   }



  //method to add comment to post.
  void commentAtPost(String postId,String comment){
    FirebaseFirestore.instance.collection('posts')
        .doc(postId).collection('comments').doc(userModel!.uId)
        .set({'comment':comment})
        .then((value) {
      emit(AppCommentToPostsSuccessState());
    }).catchError((error){
      emit(AppCommentToPostsErrorState(error.toString()));
    });
  }


  //get all users from firebase
  List<UserModel> users=[];
   void getAllUsers(){
     users=[];
     emit(AppGetAllUsersLoadingState());
     FirebaseFirestore.instance.collection('users').get().then((value) {
       value.docs.forEach((element) {
         if(element.data()['uId'] !=userModel!.uId)
           users.add(UserModel.fromJson(element.data()));
       });
     });/*.catchError((error){
       print(error.toString()+'555555555555');
       emit(AppGetAllUsersErrorState(error.toString()));
     });
*/
   }


   //method to send message
  void sendMessage({
  required String text,
  required String dateTime,
  required String receiverId,
}){

     MessageModel model = MessageModel(text: text, dateTime: dateTime, senderId: userModel!.uId, receiverId: receiverId);

     //send my chat
     FirebaseFirestore.instance.collection('users')
         .doc(userModel!.uId)
         .collection('chats')
         .doc(receiverId)
         .collection('messages')
         .add(model
         .toMap())
         .then((value) {
           emit(AppSendMessageSuccessState());
     }).catchError((error){
       emit(AppSendMessageErrorState(error.toString()));
     });

     //send to receiver chat
     FirebaseFirestore.instance.collection('users')
         .doc(receiverId)
         .collection('chats')
         .doc(userModel!.uId)
         .collection('messages')
         .add(model.toMap())
         .then((value) {
       emit(AppSendMessageSuccessState());
     }).catchError((error){
       emit(AppSendMessageErrorState(error.toString()));
     });
  }


  //get all messages
  List<MessageModel> messages=[];
void getAllMessages({required String receiverId}){
  messages=[];
     FirebaseFirestore.instance.collection('users')
         .doc(userModel!.uId)
         .collection('chats')
         .doc(receiverId)
         .collection('messages')
         .orderBy('dateTime')
         .snapshots()
         .listen((event) {
           messages=[];
           event.docs.forEach((element) {
             messages.add(MessageModel.fromJson(element.data()));
           });
            emit(AppGetAllMessagesSuccessState());
     });
}

}