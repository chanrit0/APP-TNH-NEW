// ignore_for_file: unnecessary_string_interpolations
import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/article/modelArticle.dart';
import 'package:app_tnh2/screens/home/widget/widgetNew.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/screens/home/widget/widgetArticle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HeallthArticlesScreen extends StatefulWidget {
  const HeallthArticlesScreen({super.key});

  @override
  State<HeallthArticlesScreen> createState() => _HeallthArticlesScreenState();
}

class _HeallthArticlesScreenState extends State<HeallthArticlesScreen> {
  late Service postService;
  bool textSearch = false;

  dynamic funGetArticle = '';
  dynamic funGetCate = '';

  TextEditingController controller = TextEditingController(text: "");

  void searchArticle(value) {
    funGetArticle = postService.funGetArticle("", 0, value);
  }

  @override
  initState() {
    super.initState();
    postService = Service(context: context);
    funGetArticle = postService.funGetArticle('', 0, controller.text);
    funGetCate = postService.funGetBanner(1);
  }

  toColor(hexColorItem) {
    var hexColor = hexColorItem.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "ff" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundSignUp@3x.png'),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
                left: false,
                right: false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            flex: 0,
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                IconButton(
                                  iconSize: 33,
                                  icon: const Icon(Icons.chevron_left),
                                  color: ColorDefaultApp0,
                                  onPressed: () {
                                    if (textSearch) {
                                      setState(() {
                                        textSearch = false;
                                        controller.text = '';
                                        searchArticle('');
                                      });
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ],
                            )),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: textSearch
                                ? CupertinoPageScaffold(
                                    backgroundColor: Colors.transparent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CupertinoSearchTextField(
                                            placeholder: 'ค้นหา',
                                            style: TextStyle(
                                                fontSize: font14,
                                                fontFamily: 'RSU_light',
                                                color: ColorDefaultApp0),
                                            controller: controller,
                                            onChanged: (value) {
                                              searchArticle(value);
                                            },
                                            onSubmitted: (value) {
                                              setState(() {
                                                textSearch = true;
                                              });
                                            },
                                            autocorrect: true,
                                            autofocus: true),
                                      ),
                                    ),
                                  )
                                : Text(
                                    'บทความสุขภาพ',
                                    style: TextStyle(
                                        fontSize: font20,
                                        color: ColorDefaultApp0),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  )),
                        Flexible(
                            flex: 0,
                            fit: FlexFit.tight,
                            child: textSearch
                                ? const SizedBox(
                                    width: 20,
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          textSearch = true;
                                        });
                                      },
                                      icon: const Icon(
                                        size: 25,
                                        Icons.search,
                                        color: ColorDefaultApp0,
                                      ),
                                    ))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: fullScreenWidth > 600
                            ? fullScreenWidth > 750 || fullScreenWidth < 800
                                ? 130.h
                                : 110.h
                            : 120,
                        child: buildFutureBuilder()),
                    SizedBox(height: fullScreenWidth > 600 ? 0 : 20),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: buildFutureArticle(),
                        ))
                  ],
                ))),
      ),
    );
  }

  // render item หัวข้อข้างบน
  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
      future: funGetCate,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;
          if (result == null) {
            return const SizedBox();
          }
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: result!.length,
              itemBuilder: (BuildContext context, int index) {
                final item = result[index];
                return Article(
                  urlImage: item.icon,
                  category: item.category,
                  cateId: item.cateId.toString(),
                );
              });
        }
        return const Center();
        // ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 1,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Article(
        //         urlImage: '',
        //         category: '',
        //         cateId: '',
        //       );
        //     });
      },
    );
  }

  // render item ข่าวล่าง
  FutureBuilder buildFutureArticle() {
    return FutureBuilder(
      future: funGetArticle,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ResDatum> result = snapshot.data;
          if (result.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ไม่มีรายการ',
                  style: TextStyle(color: Colors.grey, fontSize: font20),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          } else {
            return ListView.builder(
                itemCount: result.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            New(result[index].img, result[index].title,
                                '${result[index].detail}', result[index].url),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }
        }
        return const Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: 200),
                child: SpinKitRing(color: ColorDefaultApp1)));
      },
    );
  }
}
