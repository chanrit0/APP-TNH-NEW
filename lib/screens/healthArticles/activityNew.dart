import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/article/modelArticle.dart';
import 'package:app_tnh2/screens/home/widget/widgetNew.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ActivityNewScreen extends StatefulWidget {
  final String id;
  final String title;
  const ActivityNewScreen(this.id, this.title, {super.key});

  @override
  State<ActivityNewScreen> createState() => _ActivityNewScreenState();
}

class _ActivityNewScreenState extends State<ActivityNewScreen> {
  int activityNewTab = 0; //ค่าเวลาเลือกแต่ละ tab
  bool textSearch = false;

  dynamic funGetArticle = '';
  dynamic funGetCate = '';
  dynamic funGetSubcate = '';

  TextEditingController controllerArticle = TextEditingController(text: "");
  late AutoScrollController controller;

  Future _nextCounter(counter) {
    searchArticle(controllerArticle.text, counter);
    setState(() => counter = counter);
    return _scrollToCounter();
  }

  late Service postService;
  final scrollDirection = Axis.horizontal;
  int counter = 0;

  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(counter);
  }

  void searchArticle(value, tab) {
    funGetArticle = postService.funGetArticle(widget.id, tab, value);
  }

  @override
  initState() {
    super.initState();
    postService = Service(context: context);
    controller = AutoScrollController(axis: scrollDirection);
    funGetSubcate = postService.funGetSubcategory(widget.id);
    funGetArticle = postService.funGetArticle(
        widget.id, activityNewTab, controllerArticle.text);
  }

  @override
  Widget build(BuildContext context) {
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
                                    controllerArticle.text = '';
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
                                        controller: controllerArticle,
                                        onChanged: (value) {
                                          searchArticle(value, activityNewTab);
                                        },
                                        onSubmitted: (value) {
                                          searchArticle(value, activityNewTab);
                                        },
                                        autocorrect: true,
                                        autofocus: true),
                                  ),
                                ),
                              )
                            : Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: font20, color: ColorDefaultApp0),
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
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: _getRow(),
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: buildFutureArticle(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                            New(
                              result[index].img,
                              result[index].title,
                              result[index].detail,
                              result[index].url,
                            ),
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
                padding: EdgeInsets.only(bottom: 50),
                child: SpinKitRing(color: ColorDefaultApp1)));
      },
    );
  }

  //render buttom tab
  FutureBuilder _getRow() {
    return FutureBuilder(
      future: funGetSubcate,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;
          if (result == null) {
            return const SizedBox();
          }

          return ListView.builder(
              scrollDirection: scrollDirection,
              controller: controller,
              itemCount: result!.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    _wrapScrollTag(
                        index: result[index].tagId,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _nextCounter(counter = result[index].tagId);
                                  setState(() {
                                    activityNewTab = result[index].tagId;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      activityNewTab == result[index].tagId
                                          ? ColorBtRegister
                                          : Colors.white,
                                  shadowColor: ColorDefaultApp1,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  minimumSize: const Size(140, 44),
                                ),
                                child: Text(
                                  result[index].tagName,
                                  style: TextStyle(
                                      fontSize: font18,
                                      color:
                                          activityNewTab == result[index].tagId
                                              ? Colors.white
                                              : ColorBtRegister),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                );
              });
        }
        return const Center();
      },
    );
  }

  //fuc srcoll auto
  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
      );
}
