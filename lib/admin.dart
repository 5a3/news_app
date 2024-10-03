import 'package:flutter/material.dart';
import '../constants.dart';
import 'add_news.dart';
import 'edit_news.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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

  Future<void> deletenews(int id) async {
    var response =
        await crud.postRequest('http://192.168.13.1/newsapi/deletenews.php', {
      "news_id": '$id',
    });
    if (response['status'] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The news has been successfully deleted'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _getNews = getnews(); // Refresh data after deletion
      });
    }
  }

  void _navigateToAddNewsPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddNews()),
    );
  }

  void _navigateToEditNewsPage(int id, String name, String desc) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => EditNews(
                id: id,
                name: name,
                desc: desc,
              )),
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this news?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deletenews(id);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Control",
        ),
        elevation: 4, // Add elevation for depth
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "home",
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder<List>(
        future: _getNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(), // Add divider between items
            itemBuilder: (context, index) {
              return Card(
                elevation: 2, // Add elevation for depth
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Container(
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/${newsListimage[index]['image']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(snapshot.data![index]["news_name"]),
                  subtitle: Text(
                    snapshot.data![index]["news_desc"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _navigateToEditNewsPage(
                              snapshot.data![index]['news_id'],
                              snapshot.data![index]['news_name'],
                              snapshot.data![index]['news_desc']);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _showDeleteConfirmationDialog(
                              snapshot.data![index]['news_id']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: _navigateToAddNewsPage,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
