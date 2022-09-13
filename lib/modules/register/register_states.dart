
import 'package:social_app/models/user_model.dart';

abstract class SocialAppRegisterStates{}
class SocialAppRegisterInitialState extends SocialAppRegisterStates{}
class SocialAppRegisterSuccessState extends SocialAppRegisterStates{}
class SocialAppRegisterErrorState extends SocialAppRegisterStates{
  String error;
  SocialAppRegisterErrorState({required this.error});
}
class SocialAppRegisterLoadingState extends SocialAppRegisterStates{}
class SocialAppRegisterChangeState extends SocialAppRegisterStates{}


class SocialAppCreateUserSuccessState extends SocialAppRegisterStates{
  UserModel model;
  SocialAppCreateUserSuccessState(this.model);
}
class SocialAppCreateUserErrorState extends SocialAppRegisterStates{
  String error;
  SocialAppCreateUserErrorState(this.error);
}
