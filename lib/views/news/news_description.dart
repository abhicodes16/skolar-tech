import 'package:flutter/material.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDescription extends StatefulWidget {
  final String? details;
  final String? title;
  final String? subTitle;
  final String? fImageUrl;
  final String? bImageUrl;
  NewsDescription({
    Key? key,
    this.details,
    this.title,
    this.subTitle,
    this.fImageUrl,
    this.bImageUrl,
  }) : super(key: key);

  @override
  State<NewsDescription> createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _sliverAppBar(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              _title(),
              // const SizedBox(height: 20),
              _subTitle(),
              _description(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: kStandardMargin * 2,
      child: Text(
        widget.title ?? '',
        style: Palette.headerS,
      ),
    );
  }

  Widget _subTitle() {
    return Container(
      margin: kStandardMargin * 2,
      child: Text(
        widget.subTitle ?? '',
        style: Palette.title,
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Html(
        data: widget.details ?? '',
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      backgroundColor: kThemeColor,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.width - 328,
            maxWidth: MediaQuery.of(context).size.width - 140,
          ),
        ),
        background: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.bImageUrl ?? '',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: Palette.imageShadow,
          ),
        ),
      ),
    );
  }
}
