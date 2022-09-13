


import '../../models/user_model.dart';

abstract class SocialAppLoginStates{}
 class SocialAppLoginInitialState extends SocialAppLoginStates{}
 class SocialAppLoginSuccessState extends SocialAppLoginStates{
  String userId;
  SocialAppLoginSuccessState(this.userId);
 }
 class SocialAppLoginErrorState extends SocialAppLoginStates{
  String error;
  SocialAppLoginErrorState({required this.error});
}
 class SocialAppLoginLoadingState extends SocialAppLoginStates{}
 class SocialAppLoginChangeState extends SocialAppLoginStates{}