import 'package:dio/dio.dart';

class DioHelper
{
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData (
  {
  required String url,
  dynamic query,
    String lang = 'en',
    String? token,
})async
  {
    dio!.options.headers=
      {
        'Content-Type':'application/json',
        'lang':lang,
        'Authorization':token,
      };
    return await dio!.get(url,queryParameters: query,);
  }



}