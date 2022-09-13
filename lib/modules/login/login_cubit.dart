


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'login_states.dart';

class SocialAppLoginCubit extends Cubit <SocialAppLoginStates>{
  SocialAppLoginCubit():super(SocialAppLoginInitialState());


  static SocialAppLoginCubit get(context)=> BlocProvider.of(context);


  void userLogin({
  required String email,
  required String password,
  }){
    emit(SocialAppLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
     print(value.user!.email);
     print(value.user!.uid);
     emit(SocialAppLoginSuccessState(value.user!.uid));
   }).catchError((error){
     emit(SocialAppLoginErrorState(error: error.toString()));
   });

  }


  bool isShown = false;
  void changePassword(){
    isShown=!isShown;
    emit(SocialAppLoginChangeState());
  }

}