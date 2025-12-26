import 'package:flutter_mvp32/chat_model.dart';
import 'package:flutter_mvp32/db_helper.dart';
import 'package:get/get.dart';

class DBController extends GetxController {
  var messageList = <ChatModel>[].obs;

  Future<void> getMessages() async {
    final db = await DBHelper.instance.database;

    final result = await db.query("chat_table2");
    messageList.value = result.map((e) => ChatModel.fromMap(e)).toList();
    print(messageList.length.toString());
  }

  Future<void> insertMessage(ChatModel message) async {
    final db = await DBHelper.instance.database;
    await db.insert("chat_table2", message.toMap());
    getMessages();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getMessages();
    super.onInit();
  }

  Future<void> deleteAllMessage() async {
    final db = await DBHelper.instance.database;
    db.delete("chat_table2");
    getMessages();
  }
}
