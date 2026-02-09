import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:xecosystem/core/api.dart';
import 'package:xecosystem/utils/extensions.dart';
import 'package:xecosystem/widgets/x_error_view.dart';
import 'package:xecosystem/widgets/x_loader.dart';
import 'package:xecosystem/widgets/x_text.dart';

class GetXScreen extends StatefulWidget {
  const GetXScreen({super.key});

  @override
  State<GetXScreen> createState() => _GetXScreenState();
}

class _GetXScreenState extends State<GetXScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Obx(() {
      final res = controller.response.value;
      if (res == null) return const XLoader();
      return res.when(
        success: (data) => XText("Name: ${data['name']}"),
        error: (msg) => XErrorView(message: msg, onRetry: controller.fetch),
      );
    });
  }
}

class ProfileController extends GetxController {
  var response = Rxn<XResponse<Map>>();
  Future<void> fetch() async {
    response.value = await XApi.get("/users/1");
  }
}
