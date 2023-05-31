import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_pal/base/custom_loader.dart';
import 'package:food_pal/base/show_custom_snackbar.dart';
import 'package:food_pal/controller/auth_controller.dart';
import 'package:food_pal/models/signup_body_model.dart';
import 'package:food_pal/pages/auth/sign_in_page.dart';
import 'package:food_pal/routes/route_helper.dart';
import 'package:food_pal/utils/AppColors.dart';
import 'package:food_pal/utils/dimensions.dart';
import 'package:food_pal/widgets/app_text_field.dart';
import 'package:food_pal/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = ["g.png", "f.png", "t.png"];

    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if (email.isEmpty) {
        ShowCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Type in a valid email",
            title: "Valid email addresss");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not be less than 6 characters",
            title: "Password");
      } else if (name.isEmpty) {
        ShowCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        ShowCustomSnackBar("Type in your phone number", title: "Phone number");
      } else {
        SignUpBody signUpBody = SignUpBody(
          email: email,
          password: password,
          name: name,
          phone: phone,
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.toNamed(RouteHelper.getInitial());
          }else{
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email_outlined),
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
              AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person_2_outlined),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone_outlined),
              SizedBox(
                height: Dimensions.height20,
              ),
              GestureDetector(
                onTap: () {
                  _registration(_authController);
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
                      text: "Sign up",
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
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Get.to(() => SignInPage(), transition: Transition.fade),
                  text: "Have an account already?",
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimensions.font20),
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              RichText(
                text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimensions.font16),
                ),
              ),
              Wrap(
                children: List.generate(
                    3,
                        (index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: Dimensions.radius30,
                        backgroundImage:
                        AssetImage("assets/images/" + signUpImage[index]),
                      ),
                    )),
              ),
            ],
          ),
        ):const CustomLoader();
      }),
    );
  }
}
