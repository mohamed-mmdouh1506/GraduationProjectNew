
import 'package:dio/dio.dart';

class DioHelper{


  static Dio ?dio;

  static init(){

    dio = Dio(
       BaseOptions(
         baseUrl: 'https://01ba-62-139-186-180.eu.ngrok.io/',
         receiveDataWhenStatusError: true,
         contentType: 'application/json',
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
  }) async{
    return await dio!.post(url,queryParameters: query,data: data) ;
  }

  static Future<Response> postComment({
    Map <String,dynamic> ?query,
    required Map<String,dynamic> data,
  }) async{
    return await dio!.post('',queryParameters: query,data: data);
  }





}