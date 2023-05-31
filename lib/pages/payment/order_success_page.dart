import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_pal/base/custom_button.dart';
import 'package:food_pal/routes/route_helper.dart';
import 'package:food_pal/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage(
      {Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        // Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                status == 1
                    ? "assets/images/checked.png"
                    : "assets/images/warning.png",
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: Dimensions.height45,
              ),
              Text(
                status == 1
                    ? "You placed the order successfully"
                    : "You order failed",
                style: TextStyle(fontSize: Dimensions.font26),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height20),
                child: Text(
                  status == 1 ? "Successfully order" : "Failed order",
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: CustomButton(
                  buttonText: "Back to home",
                  onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
