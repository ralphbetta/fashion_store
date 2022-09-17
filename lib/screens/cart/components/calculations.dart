/*----------------------------
      Get total product
    ------------------------------------*/
import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/storage/db.dart';

String getSubTotal() {
  double total = 0;
  for (ProductModel product in cartProduct) {
    double accumulatedPrice =
        double.parse(product.orderQty.toString()) * double.parse(product.price);
    total = total + accumulatedPrice;
  }
  return total.toString();
}

String getDiscount() {
  String discount = "0.0";
  double value = double.parse(getSubTotal()) * 0.01;
  discount = value.toString();
  //discount calculation impleted here

  return discount;
}

/*----------------------------
      Get shipping fee
    ------------------------------------*/
String getShipping() {
  double shipping = double.parse(getSubTotal()) * 0.15;
  return shipping.toString();
}

String getTotalPrice() {
  double total = double.parse(getSubTotal()) + double.parse(getShipping());
  return total.toString();
}
