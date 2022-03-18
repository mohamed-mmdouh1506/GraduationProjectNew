import 'package:final_project/models/chatModel/model/chat_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chat_message = <Message>[].obs;
}

class RoomController extends GetxController {
  var room = <Room>[].obs;
}
