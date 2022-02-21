
class LoginModel{

 String ?jwt;
 UserData ?data;

 LoginModel.formJson( Map<String,dynamic> json ){

   jwt=json['jwt'];
   data=json['user']!=null? UserData.formJson(json['user']):null;

 }
 
}

class UserData{
  
  int ?id;
  String ?username;
  String ?email;
  String ?start_at;
  String ?grade;
  String ?depertment;
  String ?bio;
  String ?fullname;
  String ?image;


  UserData.formJson(Map<String,dynamic> json){
   
    id=json['id'];
    username=json['username'];
    email=json['email'];
    start_at=json['start_at'];
    grade=json['grade'];
    depertment=json['depertment'];
    bio=json['bio'];
    image=json['image'];

  }

}