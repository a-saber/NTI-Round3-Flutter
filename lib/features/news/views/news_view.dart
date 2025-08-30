import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/core/helper/my_navigator.dart';
import 'package:flutter_tutorial/features/news/cubit/news_cubit/news_cubit.dart';
import 'package:flutter_tutorial/features/news/cubit/news_cubit/news_state.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> NewsCubit()..getNews(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
                child: Icon(Icons.filter_alt),
                onPressed: ()
                {
                  // show dialog has search field
                  showDialog(
                      context: context,
                      builder: (_)
                      {
                        return AlertDialog(
                          title: Text('Filter'),
                          content: TextField(
                            onSubmitted: (value)
                            {
                              Navigator.pop(context, value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Search',
                            ),
                            // controller: NewsCubit.get(context).searchController,
                          ),
                        );
                      })
                  .then((value)
                  {
                    print(value);
                    if(value!=null && value != NewsCubit.get(context).searchController.text) {
                      NewsCubit.get(context).searchController.text = value.toString();
                      NewsCubit.get(context).getNews();
                    }
                  });
                }
            );
          }
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state)
            {
              return RefreshIndicator(
                onRefresh: ()async
                {
                  NewsCubit.get(context).getNews();
                },
                child: Builder(
                    builder: (context)
                    {
                      if(state is NewsLoading)
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else if(state is NewsError)
                      {
                        return Center(child: Text(state.error),);
                      }
                      else if(state is NewsSuccess)
                      {
                        if(state.model.articles?.isEmpty??true) {
                          return Center(child: Text('No Data'),);
                        }
                        return ListView.builder(
                            itemCount: state.model.articles!.length,
                            itemBuilder: (context, index)
                            {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children:
                                    [
                                      // image
                                      CachedNetworkImage(
                                        height: 100,
                                        imageUrl: state.model.articles![index].urlToImage??'',
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                colorFilter:
                                                ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                          ),
                                        ),
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      // Image.network(state.model.articles![index].urlToImage??''),
                                      Text(state.model.articles![index].title??''),
                                      Text(state.model.articles![index].description??''),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      else
                      {
                        return SizedBox();
                      }
                    }),
              );

            }
        ),
      )
    );
  }
}
