
import 'package:dio/dio.dart';

class DioHelper{


  static Dio ?dio;

  static init(){

    dio = Dio(
       BaseOptions(
         baseUrl: 'http://192.168.1.3:1337/api/',
         receiveDataWhenStatusError: true,
       ) ,
    );

  }

  static Future<Response> getDate({
   required String url,
   Map <String,dynamic> ?query
  })
  async{

   return await dio!.get(url,queryParameters: query) ;

  }

  static Future<Response> postDate({
    required String url,
    Map <String,dynamic> ?query,
    required Map<String,dynamic> data,
  })
  async{

    return await dio!.post(url,queryParameters: query,data: data) ;

  }



}