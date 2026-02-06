class ProfileController extends GetxController {
  var response = Rxn<XResponse<Map>>();
  Future<void> fetch() async {
    response.value = await XApi.get("/users/1");
  }
}

// UI
Obx(() {
  final res = controller.response.value;
  if (res == null) return const XLoader();
  return res.when(
    success: (data) => XText("Name: ${data['name']}"),
    error: (msg) => XErrorView(message: msg, onRetry: controller.fetch),
  );
})