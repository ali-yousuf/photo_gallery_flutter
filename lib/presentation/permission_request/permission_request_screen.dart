import 'package:flutter/material.dart';
import 'package:photo_gallery/app/button_styles.dart';
import 'package:photo_gallery/app/text_styles.dart';
import 'package:photo_gallery/core/utils/app_assets.dart';
import 'package:photo_gallery/l10n/l10n.dart';
import 'package:photo_gallery/presentation/permission_request/cubits/permission_request_cubit.dart';

class PermissionRequestScreen extends StatefulWidget {
  const PermissionRequestScreen({super.key});

  @override
  State<PermissionRequestScreen> createState() => _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  final PermissionRequestCubit _permissionRequestCubit = PermissionRequestCubit();

  @override
  void initState() {
    super.initState();
    _listenPermissionRequestCubit();
  }

  void _listenPermissionRequestCubit() {
    _permissionRequestCubit.stream.listen((state) {
      if (state is PermissionRequestGranted) {
        // TODO: navigate to albums screen
      } else if (state is PermissionRequestDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.permissionDeniedMessage)),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPermissionRequestBody(),
    );
  }

  Widget _buildPermissionRequestBody() {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.permissionImage),
          const SizedBox(height: 42),
          Text(
            l10n.permissionTitle,
            style: TextStyles.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.permissionDescription,
            textAlign: TextAlign.center,
            style: TextStyles.bodySmall,
          ),
          const SizedBox(height: 42),
          FilledButton(
            onPressed: () {
              _permissionRequestCubit.checkPermission();
            },
            style: ButtonStyles.filledButtonStyle,
            child: Text(l10n.grantAccess),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _permissionRequestCubit.close();
    super.dispose();
  }
}
