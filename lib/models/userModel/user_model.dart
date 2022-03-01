

class UserModel{

     String? uId;
     String ?username;
     String ?email;
     String ?password;
     String ?start_at;
     String ?grade;
     String ?depertment;
     String ?image;
     String ?fullname;
     String ?bio;

     UserModel({
       this.uId,
       this.username,
       this.email,
       this.start_at,
       this.grade,
       this.depertment,
       this.image,
       this.fullname,
       this.bio
     });

  UserModel.formJson( Map<String,dynamic> json ){

    username=json['username'];
    email=json['email'];
    uId=json['uId'];
    start_at=json['start_at'];
    grade=json['grade'];
    depertment=json['depertment'];
    fullname=json['fullname'];
    bio=json['bio'];
    image=json['image'];

  }

  Map <String,dynamic> toMap(){
    return{
      'username':username,
      'email':email,
      'uId':uId,
      'start_at':start_at,
      'grade':grade,
      'depertment':depertment,
      'fullname':fullname,
      'bio':bio,
      'image':image
    };
  }

}


