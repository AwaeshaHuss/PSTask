import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps_task/core/theme/app_colors.dart';

Size getScreenSize(BuildContext context){
  return MediaQuery.sizeOf(context);
}

class ProgressCircleDialog {
  static bool _isShow = false;

  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
        barrierColor: AppColors.transparent,
        barrierDismissible: false);
    _isShow = true;
  }

  static dissmed(BuildContext context) {
    if (_isShow) {
      Navigator.of(context).pop();
      _isShow = false;
    }
  }
}

bool isOpenKeyboard(context) =>
    MediaQuery.of(context).viewInsets.bottom >
    0.0; /*WidgetsBinding.instance.window.viewInsets.bottom > 0.0;*/
bool isArabicLangSelected(context) =>
    Directionality.of(context) == TextDirection.rtl;

class PSTaskBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(
        'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('onClose -- bloc: ${bloc.runtimeType}');
  }
}