import 'package:fashion_shop/models/category.dart';
import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/models/transaction.dart';
import 'package:fashion_shop/models/user.dart';

List<CategoryModel> favoriteCat = [];

List<ProductModel> favouriteProduct = [];

List<ProductModel> cartProduct = [];

UserModel user = UserModel(
    firstname: "Emmy", lastname: "Sixtus", email: "gxaviprank@gmail.com");

List<TransactionModel> tempTransaction = [
  TransactionModel(
      amount: 232,
      date: "10 Aug 2022",
      status: "completed",
      title: "shopping purchase"),
  TransactionModel(
      amount: 120,
      date: "7 Aug 2022",
      status: "pending",
      title: "shopping purchase"),
  TransactionModel(
      amount: 350,
      date: "2 Aug 2022",
      status: "cancelled",
      title: "shopping purchase"),
  TransactionModel(
      amount: 400,
      date: "21 Jul 2022",
      status: "completed",
      title: "shopping purchase"),
  TransactionModel(
      amount: 232,
      date: "18 Jul 2022",
      status: "pending",
      title: "shopping purchase"),
  TransactionModel(
      amount: 520,
      date: "10 Aug 2022",
      status: "completed",
      title: "shopping purchase"),
  TransactionModel(
      amount: 400,
      date: "21 Jul 2022",
      status: "completed",
      title: "shopping purchase"),
  TransactionModel(
      amount: 232,
      date: "18 Jul 2022",
      status: "pending",
      title: "shopping purchase"),
  TransactionModel(
      amount: 520,
      date: "10 Aug 2022",
      status: "completed",
      title: "shopping purchase"),
];
