import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class TabMenuScroll extends StatelessWidget {
  final AutoScrollController controller;
  final int id;
  final String? titel;
  final int tabSelect;
  final Function nextCounter;
  final int counter;
  const TabMenuScroll(
      {super.key,
      required this.controller,
      required this.id,
      required this.titel,
      required this.tabSelect,
      required this.nextCounter,
      required this.counter});

  @override
  Widget build(BuildContext context) {
    return _wrapScrollTag(
        index: id,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    nextCounter();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        tabSelect == id ? ColorBtRegister : Colors.white,
                    shadowColor: ColorDefaultApp1,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    minimumSize: const Size(140, 44),
                  ),
                  child: Text(
                    titel ?? '',
                    style: TextStyle(
                        fontSize: font18,
                        color:
                            tabSelect == id ? Colors.white : ColorBtRegister),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
      );
}
