import 'package:flutter/material.dart';
import 'package:flutter_blog_app/mapping.dart';
import 'mapping.dart';
import 'authentication.dart';
void main()
{
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
     title: "News App",

     theme: new ThemeData(
       primarySwatch: Colors.deepOrange,
     ),
     home: MappingPage(auth: Auth(),),
   );
  }
}