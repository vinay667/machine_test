import 'dart:io';
import 'dart:math';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp32/chat_model.dart';
import 'package:flutter_mvp32/db_controller.dart';
import 'package:flutter_mvp32/db_helper.dart';
import 'package:flutter_mvp32/video_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  ChatState createState() => ChatState();
}

class ChatState extends State<ChatScreen> {
  var msgController = TextEditingController();
  List<ChatModel> messageList = [];
  var controller = Get.put(DBController());
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 35),

          Container(
            height: 55,
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(width: 12),

                Icon(Icons.arrow_back_ios_new),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "Gagan Singh",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Text(
                      "Online",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Spacer(),

                GestureDetector(
                  onTap: () {
                    controller.deleteAllMessage();
                  },

                  child: Icon(Icons.delete),
                ),

                SizedBox(width: 12),
              ],
            ),
          ),


             Expanded(
                  child:


    Obx(
                    () =>

                    controller.messageList.length == 0?Center(child: Text("No data found!")):

                        ListView.builder(
                      itemCount: controller.messageList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int pos) {
                        return Column(
                          children: [
                            controller.messageList[pos].messageType == "image"
                                ? Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 150,
                                        height: 150,
                                        padding: EdgeInsets.all(12),
                                        color: Colors.green,
                                        child: Image.file(
                                          File(
                                            controller
                                                .messageList[pos]
                                                .filePath,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 12),
                                    ],
                                  )
                                : controller.messageList[pos].messageType ==
                                      "doc"
                                ? Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 62,
                                        width: 200,
                                        color: Colors.green,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10),

                                            Container(
                                              width: 50,
                                              height: 50,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text(
                                                  controller
                                                      .messageList[pos]
                                                      .filePath
                                                      .split('.')
                                                      .last,
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 5),

                                            Expanded(
                                              child: Text(
                                                controller
                                                    .messageList[pos]
                                                    .filePath
                                                    .split('/')
                                                    .last,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),

                                            SizedBox(width: 12),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 12),
                                    ],
                                  )
                                : controller.messageList[pos].messageType ==
                                      "video"
                                ?
                                  /*  VideoThumbnail(controller.messageList[pos].filePath.toString())*/
                                  Row(
                                    children: [
                                      Spacer(),
                                      Stack(
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 150,
                                            padding: EdgeInsets.all(12),
                                            color: Colors.green,
                                          ),

                                          Container(
                                            width: 150,
                                            height: 150,
                                            padding: EdgeInsets.all(12),
                                            child: Center(
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 32,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(width: 12),
                                    ],
                                  )
                                : BubbleSpecialThree(
                                    text: controller.messageList[pos].message,
                                    color: Color(0xFF016F2B),
                                    tail: true,
                                    isSender: true,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),

                            SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ),

          Container(
            height: 50,
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: [
                            'xls',
                            'pdf',
                            'doc',
                            'docx',
                            'xlsx',
                          ],
                        );

                    if (result != null) {
                      ChatModel model = ChatModel(
                        id: Random().nextInt(1000),
                        message: "NA",
                        msgTime: DateTime.now().toString(),
                        filePath: result.files.single.path!,
                        messageType: "doc",
                      );

                      controller.insertMessage(model);
                    }
                  },
                  child: Icon(Icons.attach_file_outlined),
                ),

                Expanded(
                  child: TextFormField(
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: "Enter message",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          modalBottomSheetFiles();
                        },

                        child: Icon(Icons.camera_alt),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                GestureDetector(
                  onTap: () {
                    if (msgController.text != "") {
                      ChatModel model = ChatModel(
                        id: Random().nextInt(1000),
                        message: msgController.text,
                        msgTime: DateTime.now().toString(),
                        filePath: "NA",
                        messageType: "text",
                      );

                      controller.insertMessage(model);

                      msgController.clear();
                    }
                  },

                  child: Icon(Icons.send, size: 34, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  modalBottomSheetFiles() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Icon(Icons.clear),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () async {
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (image != null) {
                    ChatModel model = ChatModel(
                      id: Random().nextInt(1000),
                      message: "NA",
                      msgTime: DateTime.now().toString(),
                      filePath: image.path.toString(),
                      messageType: "image",
                    );

                    controller.insertMessage(model);
                  }
                },
                child: Text("Select Image"),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () async {
                  final XFile? galleryVideo = await picker.pickVideo(
                    source: ImageSource.gallery,
                  );

                  if (galleryVideo != null) {
                    ChatModel model = ChatModel(
                      id: Random().nextInt(1000),
                      message: "NA",
                      msgTime: DateTime.now().toString(),
                      filePath: galleryVideo.path.toString(),
                      messageType: "video",
                    );

                    controller.insertMessage(model);
                  }
                },
                child: Text("Select Video"),
              ),
            ],
          ),
        );
      },
    );
  }
}
