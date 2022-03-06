class MaterialModel {
  String? title;
  String? url;

  MaterialModel({
   required this.title ,
   required this.url ,
   });


  MaterialModel.fromFire(Map <String , dynamic> fire){
    title = fire['title'];
    url = fire['url'];
  }

  Map <String , dynamic> toMap ()
  {
    return{
      'title' : title,
      'url' : url,
    };
  }



}