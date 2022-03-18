class CommentModel{
  String? username;
  String? userId;
  String? userImage;
  String? comment;


  CommentModel({
    this.username,
    this.userId,
    this.userImage,
    this.comment,

  });

  CommentModel.fromFire(Map <String , dynamic> fire ){
    username = fire['username'];
    userId = fire['userId'];
    userImage = fire['userImage'];
    comment = fire['comment'];

  }


  Map <String , dynamic> toMap (){
    return {
      'username' : username ,
      'userId' : userId ,
      'userImage': userImage ,
      'comment': comment ,
    };
  }

}