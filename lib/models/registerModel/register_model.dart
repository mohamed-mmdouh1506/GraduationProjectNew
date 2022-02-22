

class RegisterModel{

  String ?jwt;
  Data ?user;

  RegisterModel.fromJson(Map<String,dynamic> json){

    jwt=json['jwt'];
    user=json['user']!=null?Data.fromJson(json['user']):null;

  }

}

class Data{

  int ?id;
  String ?username;
  String ?email;
  String ?start_at;
  String ?depertment;
  String ?bio;
  String ?fullname;
  String ?image;

   Data.fromJson(Map <String,dynamic> json){

     id=json['id'];
     username=json['username'];
     email=json['email'];
     start_at=json['start_at'];
     depertment=json['depertment'];
     bio=json['bio'];
     fullname=json['fullname'];
     image=json['image'];

   }


}