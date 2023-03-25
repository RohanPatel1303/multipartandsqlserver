import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multipartandsqlserver/Modal/detailsmodal.dart';
import 'package:multipartandsqlserver/Screens/details.dart';
import 'package:multipartandsqlserver/Screens/uploadimage.dart';

import '../Widgets/dropdownwidget.dart';
String? emailstring;
String? passstring;
String? purpose;
String? food;
class UserFormScreen extends StatefulWidget {
  const UserFormScreen({Key? key}) : super(key: key);

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {

  @override
  Widget build(BuildContext context) {

    const List<String> itemList = <String>["Tea", "Snacks", "Lunch", "Dinner"];
    const List<String> purposelist = <String>[
      "Education",
      "Commercial",
      "Testing",
      "Other"
    ];

    void purposecallback(value) {
      purpose = value;
      setState(() {});
      print(purpose);
    }

    void setfood(value) {
      food = value;
      setState(() {});
      print(food);
    }
    DetailsModal data;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"), fit: BoxFit.fill)),
          ),
          Container(
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 32),
            ),
          ),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter Your Email Address:"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty)
                        { return 'Please Enter The Details';}
                        return null;
                      },
                      onChanged: (text) {
                        emailstring = text;
                        print(emailstring);
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "Email",
                          label: Text("Email"),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Enter Password:"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (text2) {
                        passstring = text2;
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "Password",
                          label: Text("Password"),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Dropdownwidget(
                        itemList: itemList,
                        hint: "What Food You Like The Most",
                        onselect: setfood),
                    const SizedBox(
                      height: 20,
                    ),
                    Dropdownwidget(
                        itemList: purposelist,
                        hint: "What's Your Purpose?",
                        onselect: purposecallback),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => {
                              print(emailstring),
                              data=DetailsModal(email: emailstring,password: passstring,typeOfFood: food,purpose: purpose),
                            print(data.toJson()),
                              Get.off(DetailsScreen(),arguments: data.toJson()),
                            },
                            child: const Text("Submit")),
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    )   ;
  }
}
