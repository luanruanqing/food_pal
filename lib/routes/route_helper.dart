import 'package:food_pal/models/order_model.dart';
import 'package:food_pal/pages/address/add_address_page.dart';
import 'package:food_pal/pages/address/pick_address_map.dart';
import 'package:food_pal/pages/auth/sign_in_page.dart';
import 'package:food_pal/pages/cart/cart_page.dart';
import 'package:food_pal/pages/food/popular_food_detail.dart';
import 'package:food_pal/pages/food/recommended_food_detail.dart';
import 'package:food_pal/pages/home/home_page.dart';
import 'package:food_pal/pages/home/main_food_page.dart';
import 'package:food_pal/pages/payment/order_success_page.dart';
import 'package:food_pal/pages/payment/payment_page.dart';
import 'package:food_pal/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id,int userID) => '$payment?id=$id&userID=$userID';
  static String getOrderSuccessRoute(String orderID, String status) => '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(
      name: initial,
      page: () {
        return HomePage();
      },
      transition: Transition.fade,
    ),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddress = Get.arguments;
        return _pickAddress;
      },
    ),
    GetPage(
      name: signIn,
      page: () {
        return SignInPage();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: payment,
      page: () => PaymentPage(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ),
      ),
    ),
    GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
      orderID: Get.parameters['id']!,
      status: Get.parameters['status'].toString().contains("success")?1:0,
    )),
  ];
}
