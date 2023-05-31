import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_pal/base/custom_loader.dart';
import 'package:food_pal/base/show_custom_snackbar.dart';
import 'package:food_pal/controller/auth_controller.dart';
import 'package:food_pal/models/signup_body_model.dart';
import 'package:food_pal/pages/auth/sign_up_page.dart';
import 'package:food_pal/pages/home/home_page.dart';
import 'package:food_pal/pages/home/main_food_page.dart';
import 'package:food_pal/routes/route_helper.dart';
import 'package:food_pal/utils/AppColors.dart';
import 'package:food_pal/utils/dimensions.dart';
import 'package:food_pal/widgets/app_text_field.dart';
import 'package:food_pal/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = emailController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        ShowCustomSnackBar("Type in your phone number",
            title: "Phone");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not be less than 6 characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Container(
                height: Dimensions.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20 * Dimensions.font20 / 3,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                  textController: emailController,
                  hintText: "Phone",
                  icon: Icons.phone_outlined),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.lock_open_outlined,
                isObscure: true,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Row(
                children: [
                  Expanded(child: Container(

                  )),
                  RichText(
                    text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20),
                    ),
                  ),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20 + Dimensions.font20 / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              RichText(
                text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                      text: "Create",
                      style: TextStyle(
                        color: AppColors.mainBlackColor,
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}
