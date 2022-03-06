class GroupModel {
  String? username;
  String? userImage ;
  String? userId ;
  String? postDate;
  String? postText;
  String? postImage;

  GroupModel ({
    required this.username ,
    required this.userImage ,
    required this.userId,
    required this.postDate,
    required this.postText,
    this.postImage,
  });

  GroupModel.fromFire(Map <String , dynamic> fire){
    username = fire['username'];
    userImage = fire['userImage'];
    userId = fire['userId'];
    postDate = fire['postDate'];
    postText = fire['postText'];
    postImage = fire['postImage'];
  }

  Map <String , dynamic> toMap ()
  {
    return{
      'username' : username,
      'userImage' : userImage,
      'userId' : userId,
      'postDate' : postDate,
      'postText' : postText,
      'postImage' : postImage,
    };
  }

}