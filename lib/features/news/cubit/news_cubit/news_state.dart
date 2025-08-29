import 'package:flutter_tutorial/features/news/data/models/article_response_model.dart';

abstract class NewsState{}

class NewsInitial extends NewsState{}
class NewsLoading extends NewsState{}
class NewsSuccess extends NewsState
{
  ArticlesResponseModel model;
  NewsSuccess(this.model);
}
class NewsError extends NewsState
{
  String error;
  NewsError(this.error);
}