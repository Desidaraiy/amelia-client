import '../models/media.dart';

class CartPresentModel {
  String id;
  String name;
  String imageurl;

  CartPresentModel();

  CartPresentModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      imageurl = jsonMap['imageurl'];
    } catch (e) {
      id = '';
      name = '';
      imageurl = '';
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["imageurl"] = imageurl;
    return map;
  }
}
