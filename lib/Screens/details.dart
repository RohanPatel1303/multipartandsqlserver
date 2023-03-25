import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multipartandsqlserver/Modal/detailsmodal.dart';
import 'package:multipartandsqlserver/Screens/uploadimage.dart';
import 'package:multipartandsqlserver/Screens/userform.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var data=Get.arguments;
    DetailsModal detailsModal=DetailsModal.fromJson(data);
    List<DetailsModal> listmodal=[DetailsModal.fromJson(data)];
    // json1.map((key, value) => null)
    if(data!=null){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      Text("Email"),
                      Text("Password"),
                      Text("Purpose"),
                      Text("Type Of food")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(detailsModal.email.toString()),
                      Text(detailsModal.password.toString()),
                      Text(detailsModal.purpose.toString()),
                      Text(detailsModal.typeOfFood.toString()),
                    ],
                  ),
                )
              ],
            ),
            Expanded(child: SizedBox(),),
            ElevatedButton(
                onPressed: (){
                  Get.off(UploadImageScreen(),arguments: detailsModal.toJson());
                },
                child: Text("Proceed To Upload Images")
            )
          ],
        )
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(title: const Text("Your Entered Details"),),
        body:SingleChildScrollView(
          child: Column(
            children: const [
              Text("No Data"),
            ],

          ),
        ),
      );
    }

  }
}
