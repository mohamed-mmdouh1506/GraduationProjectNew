

class UserModel{

     String? uId;
     String ?username;
     String ?email;
     String ?password;
     String ?startAt;
     String ?grade;
     String ?department;
     String ?image;
     String ?fullName;
     String ?bio;

     UserModel({
       this.uId,
       this.username,
       this.email,
       this.startAt,
       this.grade,
       this.department,
       this.image,
       this.fullName,
       this.bio
     });

  UserModel.formJson( Map <String , dynamic> json ){

    username = json['username'];
    email=json['email'];
    uId=json['uId'];
    startAt=json['startAt'];
    grade=json['grade'];
    department=json['department'];
    fullName=json['fullName'];
    bio=json['bio'];
    image=json['image'];
  }

  Map <String,dynamic> toMap(){
    return{
      'username':username,
      'email':email,
      'uId':uId,
      'startAt':startAt,
      'grade':grade,
      'department':department,
      'fullName':fullName,
      'bio':bio,
      'image':image
    };
  }

}


