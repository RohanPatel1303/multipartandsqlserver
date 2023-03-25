import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multipartandsqlserver/Modal/detailsmodal.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final List<XFile> imglist=[];
  var data =Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(data);
    DetailsModal datamodal=DetailsModal.fromJson(data);
    List<DetailsModal> modal=[DetailsModal.fromJson(data)];
    // print(modal.email);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 2,
              child: GridView.builder(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
                  itemCount: imglist.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Stack(
                        children: [
                          Image.file(File(imglist[index].path),fit: BoxFit.fill,),
                          Positioned(
                            right: 30,
                            child: GestureDetector(

                              child: const Icon(Icons.cancel_rounded,color: Colors.red),
                              onTap: ()=>{
                                imglist.toList(growable: true),
                                imglist.removeAt(index),
                                // itemList.removeAt(0),
                                setState(() {
                                })
                              },
                            ),
                          )
                        ],
                      );
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: modal.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 20,
                        color: Colors.lightBlue,
                        child: Column(
                          children: [
                            Text(modal[index].email.toString()),
                            Text(modal[index].password.toString()),
                            Text(modal[index].purpose.toString()),
                            Text(modal[index].typeOfFood.toString()),
                            Text(modal[index].email.toString()),

                          ],
                        ),
                      ),
                    );

              }),
            ),
            Text("Select Images"),
            ElevatedButton(
                onPressed: () async {
                  final XFile? selected_img=await ImagePicker().pickImage(source: ImageSource.camera);
                  if(selected_img!=null)
                  {
                    imglist.add(selected_img);
                    setState(() {
                    });
                  }else{
                    Get.dialog(
                        AlertDialog(
                          title: const Text("No Image Selected"),
                          actions: [
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("Okay",style: TextStyle(fontWeight: FontWeight.bold)),
                                )
                            )
                          ],
                          alignment: Alignment.center,
                        )
                    );
                  }
                },
                child: Text("Click Image")
            ),
            ElevatedButton(
                onPressed: () async {
                  print("execution started");
                  var request=await http.MultipartRequest('POST',Uri.parse("http://192.168.43.243/ImageUpload/"));
                  imglist.forEach((element) {
                    request.files.add(http.MultipartFile('image[]',File(element.path).readAsBytes().asStream(),File(element.path).lengthSync(),filename:element.name, ));
                  });
                  data["time"]=DateTime.now().toIso8601String();
                  request.fields["data"]=jsonEncode(data);
                  var res =await request.send().then((value) => {
                    http.Response.fromStream(value).then((response) => {
                      if(response.statusCode==200){
                        Get.snackbar("The Query Was Successfull","",snackPosition: SnackPosition.BOTTOM)
                      }else{
                        Get.snackbar("The Query Was Unsuccessful","",snackPosition: SnackPosition.BOTTOM)
                      },
                      print(response.body),
                    })
                  });
                  
                },
                child: Text("Submit")
            )
          ],
        ),
      ),
    );
  }
}
