import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:fianl_app/admin.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Crud crud = Crud();
  late Future<List> _getNews;

  @override
  void initState() {
    super.initState();
    _getNews = getnews();
  }

  Future<List> getnews({String searchText = ''}) async {
    List data =
        await crud.getRequest('http://192.168.13.1:8080/newsapi/getnews.php');
    if (searchText.isNotEmpty) {
      data = data
          .where((item) => item['news_name'].toString().contains(searchText))
          .toList();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "News Day",
              style: TextStyle(
                color: Constants.liteColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              ),
              child: Icon(
                Icons.admin_panel_settings,
                color: Constants.secondaryColor,
                size: 30.0,
              ),
            )
          ],
        ),
        backgroundColor: Constants.primaryColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: size.height * .3,
                  width: double.infinity,
                  child: AnotherCarousel(
                    images: [
                      Image.asset(
                        "images/image1.jpg",
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        "images/image3.jpg",
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        "images/image2.jpg",
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        "images/image3.jpg",
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        "images/image2.jpg",
                        fit: BoxFit.cover,
                      ),
                    ],
                    indicatorBgPadding: 5.5,
                    dotSize: 6,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _getNews = getnews(searchText: value);
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.mic,
                      textDirection: TextDirection.rtl,
                      size: 30,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      textDirection: TextDirection.rtl,
                      size: 30,
                    ),
                    hintText: "Search for news",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Constants.primaryColor),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                child: const Text(
                  'The News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: size.height * .5,
                child: FutureBuilder<List>(
                  future: _getNews,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        newsimage: newsListimage[index],
                                        newslist: snapshot.data![index],
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 80.0,
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            width: size.width,
                            child: ListTile(
                              title: Text(snapshot.data![index]["news_name"]),
                              subtitle: Text(
                                snapshot.data![index]["news_desc"],
                                style: TextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading:
                                  Text("${snapshot.data![index]["news_id"]}"),
                              trailing: CircleAvatar(
                                child: Image.asset(
                                  "images/${newsListimage[index]["image"]}",
                                  fit: BoxFit.cover,
                                ),
                                radius: 25,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
