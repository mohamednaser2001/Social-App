import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/register_states.dart';


class SocialAppRegisterCubit extends Cubit <SocialAppRegisterStates>{
  SocialAppRegisterCubit():super(SocialAppRegisterInitialState());


  static SocialAppRegisterCubit get(context)=> BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(SocialAppRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {

      createUser(name: name, email: email, phone: phone, uId: value.user!.uid,);
     // emit(SocialAppRegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialAppRegisterErrorState(error: error.toString()));
    });
  }

  void  createUser({
  required String name,
  required String email,
  required String phone,
  required String uId,
   String? image,
   String ?coverImage,
   String ?bio,
}){
    UserModel userModel=UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image:'https://img.freepik.com/free-photo/smiling-happy-boy-pointing-fingers-up-copyspace_171337-16394.jpg?w=1060&t=st=1661802434~exp=1661803034~hmac=ec60de30635901a4f6759f932444b667ef20369a6c2cea8abc2d15e1ad44774e',
        bio: 'Write your bio here ...',
        coverImage: 'https://img.freepik.com/premium-photo/fireworks-sky-new-year-night_23-2148339720.jpg?size=626&ext=jpg');

    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {
      emit(SocialAppCreateUserSuccessState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(SocialAppCreateUserErrorState(error.toString()));
    });

  }


  bool isShown = false;
  void changePassword(){
    isShown=!isShown;
    emit(SocialAppRegisterChangeState());
  }

}