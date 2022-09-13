
abstract class AppStates {}
class AppInitialState extends AppStates{}
class AppChangeBottomNavBarState extends AppStates{}
class AppGetUserDataLoadingState extends AppStates{}
class AppGetUserDataSuccessState extends AppStates{}
class AppGetUserDataErrorState extends AppStates{}
class ProfileImagePickedSuccess extends AppStates{}
class ProfileImagePickedError extends AppStates{}
class CoverImagePickedSuccess extends AppStates{}
class CoverImagePickedError extends AppStates{}

class ProfileImageUploadSuccess extends AppStates{}
class ProfileImageUploadError extends AppStates{}
class CoverImageUploadSuccess extends AppStates{}
class CoverImageUploadError extends AppStates{}

class UpdateUserDataErrorState extends AppStates{}
class UpdateUserDataLoadingState extends AppStates{}

class UploadProfileImageLoadingState extends AppStates{}
class UploadCoverImageLoadingState extends AppStates{}

//posts
class UploadPostImageLoadingState extends AppStates{}
class UploadPostImageSuccessState extends AppStates{}
class UploadPostImageErrorState extends AppStates{}
class PostImagePickedSuccess extends AppStates{}
class PostImagePickedError extends AppStates{}
class RemovePostImageState extends AppStates{}

class AppCreatePostLoadingState extends AppStates{}
class AppCreatePostSuccessState extends AppStates{}
class AppCreatePostErrorState extends AppStates{}

class AppGetPostsLoadingState extends AppStates{}
class AppGetPostsSuccessState extends AppStates{}
class AppGetPostsErrorState extends AppStates{}

//like post
class AppLikePostsSuccessState extends AppStates{}
class AppLikePostsErrorState extends AppStates{
  String error;
  AppLikePostsErrorState(this.error);
}


//comment post
class AppCommentToPostsSuccessState extends AppStates{}
class AppCommentToPostsErrorState extends AppStates{
  String error;
  AppCommentToPostsErrorState(this.error);
}

// users
class AppGetAllUsersLoadingState extends AppStates{}
class AppGetAllUsersSuccessState extends AppStates{}
class AppGetAllUsersErrorState extends AppStates{
  String error;
  AppGetAllUsersErrorState(this.error);
}

//messages
class AppGetAllMessagesSuccessState extends AppStates{}


class AppSendMessageSuccessState extends AppStates{}
class AppSendMessageErrorState extends AppStates{
  String error;
  AppSendMessageErrorState(this.error);
}

class AppCollectUserPostsSuccessState extends AppStates{}
