import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sql_lite/listView.dart';
import 'ListProvider.dart';

class ListViewChild extends StatelessWidget {

  Animation animation;
 // ListViewChild({this.animation});
  String text;
  ListViewChild({this.text,this.animation});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context,myList,child) => Card(
        child: Container(
        //  color: Colors.amberAccent,
          height: ScreenUtil.screenHeightDp/13,
          padding: EdgeInsets.only(left: ScreenUtil.screenWidthDp/15),
          margin: EdgeInsets.only(top: ScreenUtil.screenHeightDp/150),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(ScreenUtil.screenWidthDp/500),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: IconButton(
                    onPressed: (){
                     int index= myList.text.indexOf(this.text);
                     myList.remove(index);
                     AnimatedListRemovedItemBuilder builder = (context,animation){
                       return ListViewChild(animation: animation,text: this.text,);
                     };
                     ListViewWidget.globalKey.currentState.removeItem(index, builder);
                    },
                    icon: Icon(Icons.delete),
                  color: Colors.white,
                ),
              ),
              SizedBox(width: ScreenUtil.screenWidthDp/25,),
              Expanded(
                flex: 1,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: (text.length<12) ? ScreenUtil.screenWidthDp/15 : ScreenUtil.screenWidthDp/20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
