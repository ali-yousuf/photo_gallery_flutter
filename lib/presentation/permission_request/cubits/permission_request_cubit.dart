import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_request_state.dart';

class PermissionRequestCubit extends Cubit<PermissionRequestState> {
  PermissionRequestCubit() : super(PermissionRequestInitial());

  Future<void> checkPermission() async {
    final permissionStatus = await Permission.photos.request();

    if (permissionStatus.isGranted) {
      emit(PermissionRequestGranted());
    } else {
      emit(PermissionRequestDenied());
    }
  }
}
