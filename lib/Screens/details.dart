import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multipartandsqlserver/Modal/detailsmodal.dart';
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
            Expanded(
              child:ListView.builder(
                itemCount: listmodal.length,
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email"),
                              Text("Password"),
                              Text("Purpose")
                            ],
                          ),
                        ),
                        Column(
                          children: [Expanded(
                            child:ListView.builder(
                              itemCount: listmodal.length,
                              itemBuilder: (context,index){
                                return Column(
                                  children: [
                                    Text(listmodal[index].email.toString()),
                                    Text(listmodal[index].password.toString()),
                                    Text(listmodal[index].purpose.toString()),
                                    Text(listmodal[index].typeOfFood.toString()),
                                    Text(listmodal[index].email.toString()),
                                  ],
                                );
                              },
                            )
                          )],
                        )
                      ],
                    );
                  }
              )
            ),
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
