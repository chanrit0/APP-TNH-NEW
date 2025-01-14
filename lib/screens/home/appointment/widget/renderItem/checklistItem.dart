import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class ChecklistItem extends StatelessWidget {
  final String titel;
  final String building;
  final String statusCheck;
  const ChecklistItem(this.titel, this.building, this.statusCheck, {super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    titel,
                    style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: statusCheck == "Success"
                        ? ColorBtRegister
                        : Colors.grey,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: ColorDivider,
            thickness: 1,
            endIndent: 0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                Text('สถานที่นัดหมาย',
                    style:
                        TextStyle(color: ColorDefaultApp1, fontSize: font18)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10, bottom: 10),
            child: Row(
              children: [
                Image(
                  image: const AssetImage(
                      'assets/icons/environment-anticon@3x.png'),
                  height: 30,
                  width: 30,
                ),
                Expanded(
                    child: Text(
                  building,
                  style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
