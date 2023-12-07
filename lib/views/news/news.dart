import 'package:flutter/material.dart';
import '../../bloc/News/news_bloc.dart';
import '../../model/News/news_model.dart';
import '../../style/palette.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'custom_list_items.dart';
import 'news_description.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsBloc? newsBloc;

  @override
  void initState() {
    newsBloc = NewsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: newsBloc!.dataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
              case Status.COMPLETED:
                return _listWidget(snapshot.data.data);
              case Status.ERROR:
                return ErrorMessage(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () =>
                      newsBloc!.fetchdata(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(NewsModel newsModel) {
    if (newsModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: newsModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          var dateTime = newsModel.data![index].tCNPSTDT;
          var fomattedDate = dateTime != null
              ? DateFormatterWD.convertDateFormat(dateTime)
              : '';
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDescription(
                    title: newsModel.data?[index].title,
                    subTitle: newsModel.data?[index].subTitle,
                    fImageUrl: newsModel.data?[index].fImageUrl,
                    bImageUrl: newsModel.data?[index].bImageUrl,
                    details: newsModel.data?[index].details,
                  ),
                ),
              );
            },
            child: Column(
              children: <Widget>[
                CustomListItemTwo(
                  thumbnail: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              '${newsModel.data![index].fImageUrl}'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  title: '${newsModel.data![index].title}',
                  subtitle: '${newsModel.data![index].subTitle}',
                  author: '${newsModel.data![index].tCNRFLUR}',
                  publishDate: fomattedDate,
                ),
                const Divider()
              ],
            ),
          );
        },
      );
    }
  }
}
