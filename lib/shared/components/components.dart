// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/colors.dart';

Widget BuilderItem(article, context) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('${article['urlToImage']}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    maxLines: 3,
                  ),
                  // Text(
                  //   '${article['description']}',
                  //   style: Theme.of(context).textTheme.bodyText2,
                  //   textDirection: TextDirection.rtl,
                  // ),
                  Text(
                    '${article['publishedAt']}',
                    style: Theme.of(context).textTheme.bodyText2,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget defultContainer(
  context, {
  Color color = grey,
  @required String text1,
  @required String text2,
  double radius = 15,
  double height,
  double width,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            text1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            text2,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );

Widget ArticleItemBuilder(list, {isSearch}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (BuildContext context) => ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            BuilderItem(list[index], context),
        separatorBuilder: (BuildContext context, int index) => MyDivider(),
        itemCount: list.length,
      ),
      fallback: (BuildContext context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.brown,
            )),
    );

Widget MyDivider() => Container(
      color: Colors.grey,
      width: double.infinity,
      height: 2.0,
    );

void NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

Widget defultTextFormFiled(
  context, {
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefixIcon,
  IconData suffixIcon,
  @required Function validate,
  Function onTap,
  bool isPassword = false,
  double radius = 0,
  int maxLength,
  int maxLines = 1,
  int minLines = 1,
  Function suffixPressed,
  Function onchange,
  Color cursorColor,
  TextDirection textdirection = TextDirection.rtl,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      cursorColor: cursorColor,
      onTap: onTap,
      onChanged: onchange,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        label: Text(
          label,
          textDirection: textdirection,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
      ),
      validator: validate,
      obscureText: isPassword,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
    );

Widget defultTextButton(
  context, {
  @required Function function,
  @required String text,
  Color color,
  Color backgroundColor,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          backgroundColor: backgroundColor,
        ),
      ),
    );

void NavigateAndRemove(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

// Widget defultMaterialButton(
//   context, {
//   @required Function function,
//   @required String text,
//   Color BackgroundColor,
//   Color color,
//   double radius = 15,
// }) =>
//     MaterialButton(
//       onPressed: function,
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(color: color, backgroundColor: BackgroundColor),
//         ),
//       ),
//     );

Widget defultAppBar() => AppBar(
      backgroundColor: grey,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: grey),
    );

Widget defultImage({
  double Containerheight = 300,
  double Containerwidth = 400,
  double radius = 20,
  @required ImageProvider Image,
  BoxFit fit = BoxFit.cover,
  Color color = Colors.white24,
  String text,
  Widget Widget,
}) =>
    Container(
      height: Containerheight,
      width: Containerwidth,
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(
          image: Image,
          fit: fit,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Widget,
    );

Widget defultMaterialButton({
  double radius = 0,
  double height = 50,
  double width = double.maxFinite,
  @required Function function,
  @required String text,
  Color TextColor = Colors.black,
  Color background = Colors.blueGrey,
  double fontSize = 23,
  FontWeight fontWeight = FontWeight.bold,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
              color: TextColor, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );

Widget defultProfileRow(
  context, {
  @required Function onPressed,
  @required String text1,
  @required String text2,
  double width = 50.2,
}) =>
    Row(
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          width: width,
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              text2,
              style: Theme.of(context).textTheme.bodyText2,
            ))
      ],
    );

//                Container(
//                   height: 50,
//                   width: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey.withOpacity(.5),
//                   ),
//                   child: MaterialButton(
//                     onPressed: () {
//                       NavigateTo(context, Covid19LoginScreen());
//                     },
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                           color: black,
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   String dropdownValue = 'One';
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String newValue) {
//         setState(() {
//           dropdownValue = newValue;
//         });
//       },
//       items: <String>['One', 'Two', 'Free', 'Four']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
