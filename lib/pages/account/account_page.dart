import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_pal/base/custom_loader.dart';
import 'package:food_pal/controller/auth_controller.dart';
import 'package:food_pal/controller/cart_controller.dart';
import 'package:food_pal/controller/location_controller.dart';
import 'package:food_pal/controller/user_controller.dart';
import 'package:food_pal/routes/route_helper.dart';
import 'package:food_pal/utils/AppColors.dart';
import 'package:food_pal/utils/dimensions.dart';
import 'package:food_pal/widgets/account_widget.dart';
import 'package:food_pal/widgets/app_icon.dart';
import 'package:food_pal/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",
            size: Dimensions.iconSize24,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconSize: Dimensions.iconSize24 * 3,
                            iconColor: Colors.white,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconColor: Colors.white,
                                      size: Dimensions.height15 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.name),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconColor: Colors.white,
                                      size: Dimensions.height15 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.phone),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconColor: Colors.white,
                                      size: Dimensions.height15 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.email),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  GetBuilder<LocationController>(
                                    builder: (locationController) {
                                      if(_userLoggedIn&&locationController.addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: (){
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              backgroundColor: AppColors
                                                  .yellowColor,
                                              iconSize: Dimensions.height10 * 5 /
                                                  2,
                                              iconColor: Colors.white,
                                              size: Dimensions.height15 * 5 / 2,
                                            ),
                                            bigText: BigText(
                                                text: "Fill in your address"),
                                          ),
                                        );
                                      }else{
                                        return GestureDetector(
                                          onTap: (){
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              backgroundColor: AppColors
                                                  .yellowColor,
                                              iconSize: Dimensions.height10 * 5 /
                                                  2,
                                              iconColor: Colors.white,
                                              size: Dimensions.height15 * 5 / 2,
                                            ),
                                            bigText: BigText(
                                                text: "Your address"),
                                          ),
                                        );
                                      }
                                    }
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message_outlined,
                                      backgroundColor: Colors.redAccent,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconColor: Colors.white,
                                      size: Dimensions.height15 * 5 / 2,
                                    ),
                                    bigText: BigText(text: "Messages"),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearShareData();
                                        Get.find<CartController>().Clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.find<LocationController>()
                                            .clearAddressList();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout_outlined,
                                        backgroundColor: AppColors.mainColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconColor: Colors.white,
                                        size: Dimensions.height15 * 5 / 2,
                                      ),
                                      bigText: BigText(text: "Logout"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : CustomLoader())
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.width20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/signintocontinue.png"))),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.width20 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                                child: BigText(
                              text: "Sign in",
                              color: Colors.white,
                                  size: Dimensions.font26,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
