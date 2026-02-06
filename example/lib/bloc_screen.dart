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