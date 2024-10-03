import 'package:flutter/material.dart';
import 'admin.dart';
import 'constants.dart';

class EditNews extends StatefulWidget {
  final String name;
  final String desc;
  final int id;
  const EditNews({
    super.key,
    required this.name,
    required this.desc,
    required this.id,
  });

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final Crud crud = Crud();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.name;
    description.text = widget.desc;
  }

  Future<void> editnews(int id) async {
    if (formState.currentState!.validate()) {
      var response = await crud.postRequest(
          'http://192.168.13.1:8080/newsapi/editnews.php', {
        'news_name': name.text,
        'news_desc': description.text,
        'news_id': '$id'
      });

      if (response['status'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The news has been successfully edit'),
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
        title: const Text("Edit News"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
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
                      icon: const Icon(Icons.newspaper)),
                ),
                const SizedBox(
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
                      icon: const Icon(Icons.bookmark)),
                ),
                GestureDetector(
                  onTap: () {
                    editnews(widget.id);
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
                        "Edit News",
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
