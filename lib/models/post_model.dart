


class PostModel{
   String? name,uId,profileImage,dateTime,text;
   String ? postImage;

  PostModel({this.name,
      this.uId,
      this.profileImage,
      this.dateTime,
      this.text,
      this.postImage});

  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uId'];
    profileImage=json['profileImage'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
  }

  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'uId':uId,
      'profileImage':profileImage,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}