import 'package:dartz/dartz.dart';
import 'package:flutter_tutorial/core/network/api_helper.dart';
import 'package:flutter_tutorial/core/network/api_response.dart';
import 'package:flutter_tutorial/core/network/end_points.dart';
import 'package:flutter_tutorial/features/news/data/models/article_response_model.dart';

class NewsRepo
{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, ArticlesResponseModel>> getEveryThing(String q)async
  {
    try
    {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.everything,
          queryParameters: {
            'q': q.isEmpty ? 'all' : q,
            'apiKey': '836086f05b344448a16dd41ee51c6320',
          }
        );
      if(response.status)
      {
        ArticlesResponseModel model = ArticlesResponseModel.fromJson(response.data as Map<String, dynamic>);
        return Right(model);
      }
      else
      {
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}