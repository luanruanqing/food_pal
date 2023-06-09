import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_pal/base/custom_button.dart';
import 'package:food_pal/controller/location_controller.dart';
import 'package:food_pal/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:food_pal/routes/route_helper.dart';
import 'package:food_pal/utils/AppColors.dart';
import 'package:food_pal/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(15.975034, 108.252638);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 17,
                    ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraposition) {
                      _cameraPosition = cameraposition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController = mapController;
                      if(!widget.fromAddress){
                        print("Pick from web");
                      }
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/images/pick_marker.png",
                            height: Dimensions.height60 - Dimensions.height10,
                            width: Dimensions.width30 + Dimensions.width20,
                          )
                        : CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: ()=>Get.dialog(LocationDialogue(mapController: _mapController)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimensions.width10),
                        height: Dimensions.height60 - Dimensions.height10,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20 / 2),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: Dimensions.iconSize24,
                              color: AppColors.yellowColor,
                            ),
                            Expanded(
                              child: Text(
                                '${locationController.pickPlacemark.name ?? ''}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: Dimensions.width10,),
                            Icon(Icons.search,size: Dimensions.iconSize24,color: AppColors.yellowColor,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 200,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonText: locationController.inZone?widget.fromAddress?'Pick address':'Pick location':'Service is not available in your area',
                            onPressed: (locationController.buttonDisabled || locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.pickPlacemark.name !=
                                            null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          print("Now you can clickerd");
                                          widget.googleMapController!
                                              .moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(
                                                  locationController
                                                      .pickPosition.latitude,
                                                  locationController
                                                      .pickPosition.longitude,
                                                ),
                                              ),
                                            ),
                                          );
                                          locationController.setAddressData();
                                        }
                                        Get.toNamed(
                                            RouteHelper.getAddressPage());
                                      }
                                    }
                                  },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
