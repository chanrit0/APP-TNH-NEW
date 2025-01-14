import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HeallthArticlesDetailScreen extends StatefulWidget {
  String image = ''; //รูป
  String title = ''; //ชื่อหัวข้อ
  String detail = ''; //รายละเอียด

  HeallthArticlesDetailScreen(this.image, this.title, this.detail, {super.key});

  @override
  State<HeallthArticlesDetailScreen> createState() =>
      _HeallthArticlesScreenState();
}

class _HeallthArticlesScreenState extends State<HeallthArticlesDetailScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateScreenDetails(
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
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: font20, color: ColorDefaultApp0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ))),
              const Flexible(
                  flex: 0,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    width: 33,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                      child: Container(
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: HtmlWidget(
                      widget.detail,
                      textStyle: const TextStyle(
                        fontFamily: 'RSU_BOLD',
                        fontSize: 18,
                        color: ColorDefaultApp0,
                      ),
                      customStylesBuilder: (element) {
                        return {
                          'font-size': '18px',
                        };
                      },
                    ),
                  )
                      //   Html(
                      //       data: widget.detail,
                      //       shrinkWrap: true,
                      //       customRenders: {
                      //         tableMatcher():
                      //             CustomRender.widget(widget: (context, child) {
                      //           return tableRender
                      //               .call()
                      //               .widget!
                      //               .call(context, child);
                      //         }),
                      //       },
                      //       style: {
                      //         "p": Style(
                      //             // backgroundColor: Colors.blue,
                      //             fontSize: FontSize(18),
                      //             fontFamily: 'RSU_BOLD'),
                      //         "table": Style(
                      //             // backgroundColor: Colors.blue,
                      //             width: Width(
                      //                 MediaQuery.of(context).size.width - 75)),
                      //         "tr": Style(
                      //             padding: HtmlPaddings.all(0),
                      //             border: Border.all(color: Colors.black)),
                      //         // "td": Style(
                      //         //   width: Width(200),
                      //         // ),
                      //       }),
                      // ),
                      )))
        ],
      ),
    );
  }
}
