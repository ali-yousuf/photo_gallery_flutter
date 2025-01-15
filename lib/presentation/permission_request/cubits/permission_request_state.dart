part of 'permission_request_cubit.dart';

sealed class PermissionRequestState extends Equatable {
  const PermissionRequestState();
}

final class PermissionRequestInitial extends PermissionRequestState {
  @override
  List<Object> get props => [];
}

final class PermissionRequestGranted extends PermissionRequestState {
  @override
  List<Object?> get props => [];
}

final class PermissionRequestDenied extends PermissionRequestState {
  @override
  List<Object?> get props => [];
}
