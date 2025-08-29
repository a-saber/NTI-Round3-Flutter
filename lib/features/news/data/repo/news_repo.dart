import 'package:dartz/dartz.dart';
import 'package:flutter_tutorial/features/news/data/models/article_response_model.dart';
import 'package:dio/dio.dart';

class NewsRepo
{
  Future<Either<String, ArticlesResponseModel>> getEveryThing()async
  {
    try
    {
      var dio = Dio();
      var response = await dio.get(
          'https://newsapi.org/v2/everything?q=sport&apiKey=836086f05b344448a16dd41ee51c6320'
      );

      ArticlesResponseModel model = ArticlesResponseModel.fromJson(response.data as Map<String, dynamic>);
      return Right(model);
    }
    on DioException catch(e)
    {
      var errorResponse = e.response?.data as Map<String, dynamic>;

      print(errorResponse['message']);
      return Left(errorResponse['message']);
    }
    catch(e)
    {
      print(e.toString());
      return Left(e.toString());
    }
  }
}