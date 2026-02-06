# xecosystem 1.0.0

Opinionated Flutter UI + API ecosystem.  
**Zero boilerplate. Full freedom.**

- Strict design tokens (no random colors/padding)  
- Beginner-proof: XScaffold, XButton, XInput  
- XApi (Dio wrapper) – clean responses  
- XFutureBuilder – no state management needed  
- Works with Riverpod, Bloc, GetX, Provider, setState  

## Installation
```yaml
dependencies:
  xecosystem: ^1.0.0





## 🔥 State Management Freedom

xecosystem **kisi state management pe lock nahi karta** — tum choose kar sakte ho:

### 1. Zero State Management (Beginners – XFutureBuilder)
```dart
XScaffold(
  title: "Profile",
  body: XFutureBuilder<Map>(
    future: XApi.get("/users/1"),
    builder: (data) => XText("Name: ${data['name']}"),
  ),
)  


# Riverpod
// providers.dart
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


#  bloc / cubit
class ProfileCubit extends Cubit<AsyncValue<XResponse<Map>>> {
  ProfileCubit() : super(const AsyncValue.loading());
  Future<void> fetch() async {
    emit(const AsyncValue.loading());
    emit(AsyncValue.data(await XApi.get("/users/1")));
  }
}

// UI
BlocBuilder<ProfileCubit, AsyncValue<XResponse<Map>>>(
  builder: (_, state) => state.when(
    loading: () => const XLoader(),
    error: (_, __) => XErrorView(onRetry: context.read<ProfileCubit>().fetch),
    data: (res) => res.when(
      success: (data) => XText("Name: ${data['name']}"),
      error: (msg) => XErrorView(message: msg),
    ),
  ),
)



#  Getx

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



