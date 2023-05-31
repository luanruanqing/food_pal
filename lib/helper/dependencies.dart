import 'package:food_pal/controller/auth_controller.dart';
import 'package:food_pal/controller/cart_controller.dart';
import 'package:food_pal/controller/location_controller.dart';
import 'package:food_pal/controller/order_controller.dart';
import 'package:food_pal/controller/popular_product_controller.dart';
import 'package:food_pal/controller/recommended_product_controller.dart';
import 'package:food_pal/controller/user_controller.dart';
import 'package:food_pal/data/api/api_client.dart';
import 'package:food_pal/data/repository/auth_repo.dart';
import 'package:food_pal/data/repository/cart_repo.dart';
import 'package:food_pal/data/repository/location_repo.dart';
import 'package:food_pal/data/repository/order_repo.dart';
import 'package:food_pal/data/repository/popular_product_repo.dart';
import 'package:food_pal/data/repository/recommended_product_repo.dart';
import 'package:food_pal/data/repository/user_repo.dart';
import 'package:food_pal/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()),);
  Get.lazyPut(() => LocationController(locationRepo: Get.find()),);
  Get.lazyPut(() => OrderController(orderRepo: Get.find()),);

}