import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpsgetx3/app/controllers/theme_controller.dart';
import 'package:tpsgetx3/app/pages/sidemenu/sidemenu_page.dart';
import 'package:tpsgetx3/app/pages/widgets/loading_widget.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  List<Map<String, dynamic>> itemMap = [
    {"currency": "USD", "value": 2850.0},
    {"currency": "SGD", "value": 1980.0}
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _inputController = TextEditingController();

    //Get other depended controllers
    var themeCtrl = Get.find<ThemeController>();

    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                controller.searchMode ? Icons.search : Icons.search,
                color: controller.searchMode
                    ? Colors.white
                    : themeCtrl.activeTheme.iconTheme.color,
              ),
              onPressed: () {
                controller.changeSearchMode();
              },
            );
          })
        ],
      ),
      body: SafeArea(
        child: GetX<HomeController>(
          initState: (state) {},
          builder: (controller) {
            return controller.isLoading
                ? LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Column(children: [
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1, 1),
                                color: Colors.grey.shade400,
                                spreadRadius: 0.8,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _inputController,
                            decoration: const InputDecoration(
                                hintText: "Enter MMK",
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 50,
                            width: 300,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(1, 1),
                                      color: Colors.grey.shade400,
                                      spreadRadius: 0.8,
                                      blurRadius: 2)
                                ]),
                            child: Obx(
                              () => DropdownButton(
                                value: controller.dropdownValue.toString(),
                                isExpanded: true,
                                onTap: controller.showRate,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.rate?.rates.entries
                                    .map((MapEntry element) => DropdownMenuItem(
                                        onTap: controller.showRate,
                                        value: element.key,
                                        child: Text(element.key)))
                                    .toList(),
                                onChanged: (var newValue) {
                                  controller.showRate();
                                  controller.dropdownValue.value =
                                      newValue.toString();
                                },
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Result"),
                              Obx(
                                () => Text(controller.result.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              double mmk = double.parse(_inputController.text);
                              // double usd = itemMap[0]["value"] as double;
                              // double sgd = itemMap[1]["value"] as double;
                              // var calc = itemMap.map((item) {
                              //   if (dropdownValue == item["currency"]) {
                              //     setState(() {
                              //       double res = mmk / (item["value"] as double);
                              //       result = "$res USD";
                              //     });
                              //   }
                              // });
                              controller.rate?.rates.forEach((k, v) {
                                if (controller.dropdownValue.value == k) {
                                  var value = v.replaceAll(",", "");
                                  // controller.ratevalue.value = value.toString();
                                  var ratedata = double.parse(value ?? "0");
                                  controller.result.value =
                                      (mmk / ratedata).toString();
                                }
                              });
                              // controller.rate?.rates.forEach((k, v) {
                              //   double a = v as double;
                              //   if (controller.dropdownValue == k) {
                              //     double res = mmk / a;
                              //     result = "$res $k";
                              //   }
                              // });
                              // if (controller.dropdownValue == "USD") {
                              //   double res = mmk / usd;
                              //   result = "$res USD";
                              // }
                              // if (controller.dropdownValue == "SGD") {
                              //   double res = mmk / sgd;
                              //   result = "$res SGD";
                              // }
                            },
                            child: const Text("Convert"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Today Rate",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => Text(
                                    "1 ${controller.dropdownValue.value.toString()} = ${controller.ratevalue.value.toString()} MMK "),
                              ),
                              // (controller.dropdownValue.value == "USD")
                              //     ? const Text("2850 MMK x 1 USD")
                              //     : const Text("1980 MMK x 1 SGD"),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget appDrawer() {
    return SideMenuPage();
  }
}
