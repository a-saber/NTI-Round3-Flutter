import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/features/news/cubit/news_cubit/news_state.dart';
import 'package:flutter_tutorial/features/news/data/repo/news_repo.dart';

class NewsCubit extends Cubit<NewsState>
{
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);

  getNews()async
  {
    NewsRepo newsRepo = NewsRepo();
    emit(NewsLoading());
    var response = await newsRepo.getEveryThing();
    response.fold(
        (error)=> emit(NewsError(error)),
        (model)=> emit(NewsSuccess( model))
    );
  }
}