import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sql_lite/ListViewChild.dart';
import 'package:sql_lite/db/DataBaseHelper.dart';
import 'ListProvider.dart';
import 'listView.dart';

void main() {
  runApp(
    DevicePreview(builder: (context) => MyApp())
  );
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 550, height: 1334)..init(context);
    return ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: "TODO",
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(ScreenUtil.screenWidthDp/10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil.screenWidthDp/20),
                    color: Colors.white,
                  ),
                ),
            Container(
             // color: Colors.blue,
             margin: EdgeInsets.only(top: ScreenUtil.screenWidthDp/8,left: ScreenUtil.screenWidthDp/5),
            child: Text(
             'TODO LIST',
              style: TextStyle(
              fontSize: ScreenUtil.screenWidthDp/8,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
              Shadow(offset: Offset(3,3), color: Colors.grey.shade500),
            ],
          ),
        ),
            ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil.screenWidthDp/4.5,
                  margin: EdgeInsets.only(top: ScreenUtil.screenWidthDp/3.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenUtil.screenWidthDp/2,
                        height: ScreenUtil.screenWidth/23,
                        child: TextField(
                          controller: myController,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil.screenWidthDp/20
                          ),
                          decoration: InputDecoration(
                              hintText: 'Add a Items',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: ScreenUtil.screenWidthDp/25,),
                      Consumer<ListProvider>(
                        builder: (context,myList,child) =>Container(
                          width: ScreenUtil.screenWidthDp/7,
                          height: ScreenUtil.screenWidthDp/7,
                          child: ElevatedButton(
                            onPressed: ()async{

                              if(myController.text!='')
                              int i = await DataBaseHelper.instance.insert({DataBaseHelper.columnName:myController.text});

                            /*  if(myController.text!='') {
                                myList.adding(myController.text);
                                ListViewWidget.globalKey.currentState
                                    .insertItem(myList.length);
                                myList.length += 1;
                              }*/
                            },
                            child: Icon(Icons.add),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent,
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                ),
                              fixedSize: Size.fromHeight(ScreenUtil.screenWidthDp/7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListViewWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

