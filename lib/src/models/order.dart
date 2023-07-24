import 'package:markets/src/repository/settings_repository.dart';

import '../models/address.dart';
import '../models/order_status.dart';
import '../models/payment.dart';
import '../models/product_order.dart';
import '../models/user.dart';
import 'package:intl/intl.dart';

class Order {
  String id;
  List<ProductOrder> productOrders;
  OrderStatus orderStatus;
  double tax;
  double deliveryFee;
  double delivery_price;
  String hint;
  bool active;
  DateTime dateTime;
  User user;
  Payment payment;
  Address delivery_address;
  String comment;
  String sms_after_delivery;
  String receiver_name;
  String receiver_phone;
  DateTime delivery_timestamp;
  Order();

  Order.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      tax = jsonMap['tax'] != null ? jsonMap['tax'].toDouble() : 0.0;
      deliveryFee = jsonMap['delivery_fee'] != null
          ? jsonMap['delivery_fee'].toDouble()
          : 0.0;
      delivery_price = jsonMap['delivery_price'] != null
          ? jsonMap['delivery_price'].toDouble()
          : 0.0;
      hint = jsonMap['hint'] != null ? jsonMap['hint'].toString() : '';
      active = jsonMap['active'] ?? false;
      orderStatus = jsonMap['order_status'] != null
          ? OrderStatus.fromJSON(jsonMap['order_status'])
          : OrderStatus.fromJSON({});
      dateTime = DateTime.parse(jsonMap['updated_at']);
      user = jsonMap['user'] != null
          ? User.fromJSON(jsonMap['user'])
          : User.fromJSON({});
      delivery_address = jsonMap['delivery_address'] != null
          ? Address.fromJSON(jsonMap['delivery_address'])
          : Address.fromJSON({});
      payment = jsonMap['payment'] != null
          ? Payment.fromJSON(jsonMap['payment'])
          : Payment.fromJSON({});
      productOrders = jsonMap['product_orders'] != null
          ? List.from(jsonMap['product_orders'])
              .map((element) => ProductOrder.fromJSON(element))
              .toList()
          : [];
      sms_after_delivery = jsonMap['sms_after_delivery'] != null
          ? jsonMap['sms_after_delivery'].toString()
          : "";
      comment = jsonMap['comment'] != null ? jsonMap['comment'].toString() : "";
      receiver_name = jsonMap['receiver_name'] != null
          ? jsonMap['receiver_name'].toString()
          : "";
      receiver_phone = jsonMap['receiver_phone'] != null
          ? jsonMap['receiver_phone'].toString()
          : "";
      delivery_timestamp = jsonMap['delivery_timestamp'] != null
          ? DateTime.parse(jsonMap['delivery_timestamp']).toLocal()
          : DateTime.parse(
              DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
    } catch (e) {
      id = '';
      tax = 0.0;
      deliveryFee = 0.0;
      delivery_price = 0.0;
      hint = '';
      active = false;
      orderStatus = OrderStatus.fromJSON({});
      dateTime = DateTime(0);
      user = User.fromJSON({});
      payment = Payment.fromJSON({});
      delivery_address = Address.fromJSON({});
      productOrders = [];
      sms_after_delivery = "";
      comment = "";
      receiver_name = "";
      receiver_phone = "";
      delivery_timestamp =
          DateTime.parse(DateFormat("yyyy-MM-dd Hms").format(DateTime.now()));
      print(jsonMap);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["user_id"] = user?.id;
    map["order_status_id"] = orderStatus?.id;
    map["tax"] = tax;
    map['hint'] = hint;
    map["delivery_fee"] = deliveryFee;
    map["delivery_price"] = delivery_price;
    map["products"] =
        productOrders?.map((element) => element.toMap())?.toList();
    map["payment"] = payment?.toMap();
    map["sms_after_delivery"] = sms_after_delivery ?? "";
    map["receiver_name"] = receiver_name ?? "";
    map["receiver_phone"] = receiver_phone ?? "";
    map["delivery_timestamp"] =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(delivery_timestamp) ??
            DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    map["comment"] = comment ?? "";
    map["delivery_address"] = delivery_address?.toMap();
    // if (deliveryAddress != null)
    // if (!deliveryAddress.isUnknown()) {
    // {
    //   map["delivery_address_id"] = deliveryAddress?.id;
    // }
    // }
    return map;
  }

  Map deliveredMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["order_status_id"] = 5;
    if (delivery_address?.id != null && delivery_address?.id != 'null')
      map["delivery_address_id"] = delivery_address.id;
    return map;
  }

  Map cancelMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    if (orderStatus?.id != null && orderStatus?.id == '1')
      map["active"] = false;
    return map;
  }

  bool canCancelOrder() {
    return this.active == true &&
        this.orderStatus.id == '1'; // 1 for order received status
  }
}
