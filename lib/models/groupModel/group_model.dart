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
    userImage = fire['userimage'];
    userId = fire['userid'];
    postDate = fire['postdate'];
    postText = fire['posttext'];
    postImage = fire['postimage'];
  }

  Map <String , dynamic> toMap ()
  {
    return{
      'username' : username,
      'userimage' : userImage,
      'userid' : userId,
      'postdate' : postDate,
      'posttext' : postText,
      'postimage' : postImage,
    };
  }

}