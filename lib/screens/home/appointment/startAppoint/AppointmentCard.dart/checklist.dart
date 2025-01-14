import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/screens/home/appointment/widget/renderItem/checklistItem.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';

class CheckListScreen extends StatefulWidget {
  final dynamic apmbId;
  const CheckListScreen({super.key, required this.apmbId});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  late Service postService;

  @override
  void initState() {
    super.initState();
    postService = Service(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreenDetails(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'รายการตรวจ',
                        style: TextStyle(
                            fontSize: font20, color: ColorDefaultApp0),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  )),
            ],
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: buildItemCheckList(postService.funGetDuedate(widget.apmbId)),
          ),
        ],
      )),
    );
  }

  Widget buildItemCheckList(checkListData) => FutureBuilder(
        future: checkListData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            if (result == null) {
              return const SizedBox();
            }
            return ListView.builder(
                itemCount: result!.length,
                itemBuilder: (context, index) {
                  final item = result[index];

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ChecklistItem(
                          item.title, item.department, item.laststatus),
                    ),
                  );
                });
          }
          return const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: CircularProgressIndicator(
              color: ColorDefaultApp1,
            ),
          ));
        },
      );
}
