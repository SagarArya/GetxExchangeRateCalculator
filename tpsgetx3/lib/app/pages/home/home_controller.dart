import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpsgetx3/app/controllers/xrate_controller.dart';
import 'package:tpsgetx3/app/data/model/model.dart';
import 'package:tpsgetx3/app/data/repository/repository.dart';
import 'package:tpsgetx3/app/controllers/user_controller.dart';
import 'package:tpsgetx3/app/routes/app_routes.dart';

class HomeController extends GetxController {
  //Initialised properties  --------------------------------------
  final Repository repository;

  HomeController({required this.repository}) : assert(repository != null);

  //Static --------------------------------------------------------NONE

  //Public  -------------------------------------------------------NONE
  Rate? rate;
  var dropdownValue = "USD".obs;
  var ratevalue = "".obs;
  var result = "0".obs;
  //Private -------------------------------------------------------

  var _isLoading = false.obs;
  var _searchMode = false.obs;
  final _userController = Get.find<UserController>();

  //Getters
  get isLoading => _isLoading.value;
  get searchMode => _searchMode.value;

  //Setters -------------------------------------------------------
  set isLoading(value) => _isLoading.value = value;
  set searchMode(value) => _searchMode.value = value;
  XRateController rateCtrl = Get.put(XRateController());
  onInit() {
    super.onInit();
    isLoading = true;
    //Controller Initialization
    _fetchRate();
  }

  showRate() {
    rate?.rates.forEach((k, v) {
      if (dropdownValue.value == k) {
        var value = v.replaceAll(",", "");
        ratevalue.value = value.toString();
      }
    });
    update();
  }

  //Public Methods ( Functions) -----------------------------------
  changeSearchMode() {
    searchMode = !searchMode;
  }

  //Private Methods ( used internally ) ---------------------------
  _fetchRate() async {
    var rate = await rateCtrl.getRates();
    if (rate != null) {
      print("Got the rate");
      print(rate);
      this.rate = rate;
    } else {
      print("Sorry no the rate");
    }
    isLoading = false;
  }
  //Public Methods  ( Routing : start with to) --------------------

  toDetails({Function()? then}) {
    //may pass value to used in arguments
    Get.toNamed(Routes.DETAILS, arguments: null)?.then((value) {});
  }

  toOthers() {
    Get.toNamed(Routes.OTHERS);
  }
}
