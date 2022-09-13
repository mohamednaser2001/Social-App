
class UserModel{
  String ? name;
  String ? email;
  String ? phone;
  String ? uId;
  String ? bio;
  String ? image;
  String ? coverImage;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.bio,
    required this.image,
    required this.coverImage});

  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    bio=json['bio'];
    image=json['image'];
    coverImage=json['cover'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover':coverImage,
    };
  }
}