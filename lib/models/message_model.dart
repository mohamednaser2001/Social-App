
class MessageModel{
  String ? text;
  String ? dateTime;
  String ? senderId;
  String ? receiverId;


  MessageModel({
    required this.text,
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
   });

  MessageModel.fromJson(Map<String,dynamic>json){
    text=json['text'];
    dateTime=json['dateTime'];
    senderId=json['senderId'];
    receiverId=json['receiverId'];
  }

  Map<String,dynamic> toMap(){
    return {
      'text':text,
      'dateTime':dateTime,
      'senderId':senderId,
      'receiverId':receiverId,
    };
  }
}