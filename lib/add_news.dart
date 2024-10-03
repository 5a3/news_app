import 'package:fianl_app/admin.dart';
import 'package:fianl_app/constants.dart';
import 'package:flutter/material.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final Crud crud = Crud();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  Future<void> addnews() async {
    if (formState.currentState!.validate()) {
      var response = await crud
          .postRequest('http://192.168.13.1:8080/newsapi/addnews.php', {
        'news_name': name.text,
        'news_desc': description.text,
      });

      if (response['status'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The news has been successfully Added'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add News"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "enter News Name",
                      icon: Icon(Icons.newspaper)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 5000,
                  maxLines: 15,
                  controller: description,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "enter News description",
                      icon: Icon(Icons.bookmark)),
                ),
                GestureDetector(
                  onTap: () {
                    addnews();
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Add News",
                        style: TextStyle(
                            color: Constants.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
