import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class DetailPage extends StatelessWidget {
  final newslist;
  final newsimage;
  const DetailPage({super.key, this.newsimage, this.newslist});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              newslist['news_name'],
              style: TextStyle(
                color: Constants.liteColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.newspaper,
              color: Constants.secondaryColor,
              size: 30.0,
            )
          ],
        ),
        backgroundColor: Constants.primaryColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .3,
                width: double.infinity,
                child: Image.asset(
                  "images/${newsimage['image']}",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
                child: Row(
                  children: [
                    Icon(Icons.bookmark_add_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12,
                thickness: 1.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, right: 20, left: 20),
                child: Text(
                  newslist['news_desc'],
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
