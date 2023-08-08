import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_client/message/sing_detail_screen.dart';
import 'package:najot_shop/ui/tab_client/widget/global_shimmer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/local/db/local_database.dart';
import '../../../data/models/news_model.dart';
import '../../../utils/app_colors.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> news = [];
  List<NewsModel> news1 = [];

  _updateNews() async {
    news = await LocalDatabase.getAllNews();
    setState(() {});
  }

  @override
  void initState() {
    _updateNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          news.isNotEmpty
              ? Expanded(
                  child: ListView(
                  children: [
                    ...List.generate(news.length, (index) {
                      NewsModel newsModel = news[index];

                      return ZoomTapAnimation(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SingleDetailScreen(newsModel: newsModel),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.globalPassive.withOpacity(0.5),
                                  blurRadius: 10,
                                )
                              ]),
                          child: Column(
                            children: [
                              Hero(
                                tag: "news",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: newsModel.image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Loading(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Text(
                                newsModel.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ))
              : _updateNews()
        ],
      ),
    );
  }
}
