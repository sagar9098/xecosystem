import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xecosystem/core/api.dart';
import 'package:flutter/material.dart';
import 'package:xecosystem/utils/extensions.dart';
import 'package:xecosystem/widgets/x_error_view.dart';
import 'package:xecosystem/widgets/x_loader.dart';
import 'package:xecosystem/widgets/x_text.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({super.key});

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, AsyncValue<XResponse<Map>>>(
      builder: (_, state) => state.when(
        loading: () => const XLoader(),
        error: (_, __) =>
            XErrorView(onRetry: context.read<ProfileCubit>().fetch),
        data: (res) => res.when(
          success: (data) => XText("Name: ${data['name']}"),
          error: (msg) => XErrorView(message: msg),
        ),
      ),
    );
  }
}

class ProfileCubit extends Cubit<AsyncValue<XResponse<Map>>> {
  ProfileCubit() : super(const AsyncValue.loading());
  Future<void> fetch() async {
    emit(const AsyncValue.loading());
    emit(AsyncValue.data(await XApi.get("/users/1")));
  }
}
