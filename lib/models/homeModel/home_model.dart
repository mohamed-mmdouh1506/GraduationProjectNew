
class HomeModel{

  List<AttributesHome> data=[];

   HomeModel.fromJson(Map<String ,dynamic> json){

     json['data'].forEach((element){

       data.add(AttributesHome.fromJson(element));

     });

   }


}

class AttributesHome{

  HomePost ?attributes;

  AttributesHome.fromJson(Map<String,dynamic> json){

    attributes=json['attributes']!=null?HomePost.fromJson(json['attributes']):null;

  }

}


class HomePost{

  String ?describtion;
  HomeImage ?image;

  HomePost.fromJson(Map <String,dynamic> json){

    describtion=json['describtion'];
    image=json['image']!=null?HomeImage.fromJson(json['image']):null;

  }

}

class HomeImage{

  List <AttributesImage>images=[];

  HomeImage.fromJson(Map<String,dynamic> json){

    json['data'].forEach((element){

      images.add(AttributesImage.fromJson(element));

    });


  }


}

class AttributesImage{

  UrlImage ?attributes;


  AttributesImage.fromJson(Map<String,dynamic> json){

    attributes=json['attributes']!=null?UrlImage.fromJson(json['attributes']):null;


  }




}

class UrlImage{

  String ?url;


  UrlImage.fromJson(Map<String,dynamic> json){

    url=json['url'];


  }




}

