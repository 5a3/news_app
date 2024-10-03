import 'home.dart';
import 'package:flutter/material.dart';
import 'admin.dart';
import 'constants.dart';
import 'rigster.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final Crud crud = Crud();
  final form_key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    if (form_key.currentState!.validate()) {
      var url = "http://172.28.160.1/newsapi/login.php";
      var response = await crud.postRequest(url, {
        "email": email.text,
        "password": pass.text,
      });
      if (response['status'] == "success") {
        if (email.text == "admin@gmail.com") {
          setState(() {});
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AdminPage()));
        } else {
          setState(() {});
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Home()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The Username Or Password is incorrct"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 340,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  blurRadius: 80,
                                  offset: Offset(1, 2))
                            ],
                          ),
                          child: Image.asset(
                            "images/login.png",
                            fit: BoxFit.cover,
                          )),
                      Container(
                        // margin: EdgeInsets.only(top: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 37, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              " Now",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 37,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        // margin: EdgeInsets.only(top: 1),
                        child: const Text(
                          "Please Enter Your Detiles below to continue",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Form(
                          key: form_key,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: TextFormField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff1f1f1),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      labelText: ' E-mail',
                                      errorStyle: TextStyle(fontSize: 13)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'invalide input';
                                    }
                                    final emailRegex =
                                        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
                                    if (!RegExp(emailRegex).hasMatch(value)) {
                                      return " Enter Valid E-mail";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: TextFormField(
                                  controller: pass,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff1f1f1),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      labelText: 'Password',
                                      errorStyle: TextStyle(fontSize: 13)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'invalide input';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                            minWidth: 200,
                            height: 55,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                            color: Colors.blueAccent,
                            onPressed: () {
                              login();
                            }),
                      ),
                      // Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do not have an account?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => rigster()));
                                },
                                child: Text(
                                  " Register",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
