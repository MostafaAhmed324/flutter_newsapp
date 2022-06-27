

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mos/modules/news_app/web_view/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback onPressed,
  required String text,
}) => Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      '${text.toUpperCase()}',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: background,
  ),
);

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType textType,
  Function(String)? onSubmit,
  VoidCallback? onTap,
  required String? Function(String?) validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool obscure=false,
  Function(String)? onChange,
  void Function()? suffixPressed


}) => TextFormField(
  controller: controller,
  keyboardType: textType,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix !=null? IconButton(onPressed: suffixPressed, icon: Icon(suffix,),):null,
  ),
  validator: validator,
  onFieldSubmitted: onSubmit,
  obscureText: obscure,
  onTap: onTap,
  onChanged: onChange,
);


Widget builedArticleItem(article,context) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebviewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Row(

      children: [

        Container(

          height: 120.0,

          width: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15.0),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(width: 10.0,),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children:  [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                SizedBox(height: 5.0,),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    fontSize: 17.0,

                    fontWeight: FontWeight.bold,

                    color: Colors.grey,

                  ),

                ),



              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

void navigateTo(context , widget) => Navigator.push(
    context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
    (route){return false;},
);

Widget defaultTextButton({required void Function()? onPressed,required String text}) => TextButton(onPressed: onPressed, child: Text('$text'),);

void showToast({
  required String msg,
  required Color? color,
}) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);