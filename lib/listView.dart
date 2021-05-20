import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sql_lite/ListViewChild.dart';
import 'package:sql_lite/main.dart';
import 'ListProvider.dart';

class ListViewWidget extends StatelessWidget {

 static final  GlobalKey<AnimatedListState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('height'+(MediaQuery.of(context).size.height).toString());
    print('width'+(MediaQuery.of(context).size.width).toString());
    return Consumer<ListProvider>(
      builder: (context,myList,child) => Container(
      //  color: Colors.grey,
        width: ScreenUtil.screenWidthDp/1.3,
        height: (MediaQuery.of(context).size.height>700 && MediaQuery.of(context).size.width<500)
            ? ScreenUtil.screenHeightDp/1.6 : ScreenUtil.screenHeightDp/2,
        margin: EdgeInsets.only(top: ScreenUtil.screenWidthDp/2,left: ScreenUtil.screenWidthDp/9),
        child:  AnimatedList(
          key: globalKey,
              itemBuilder: (context,index,animation){
                return ListViewChild( text: myList.text[index],animation: animation,);
              },
            initialItemCount: myList.length,
          ),
        ),
      );
  }
}
