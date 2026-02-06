final profileProvider = FutureProvider<XResponse<Map>>((ref) => XApi.get("/users/1"));

// UI
Consumer(builder: (context, ref, _) {
  final res = ref.watch(profileProvider);
  return res.when(
    loading: () => const XLoader(),
    error: (_, __) => XErrorView(onRetry: () => ref.refresh(profileProvider)),
    data: (response) => response.when(
      success: (data) => XText("Name: ${data['name']}"),
      error: (msg) => XErrorView(message: msg),
    ),
  );
})