// Mocks generated by Mockito 5.4.2 from annotations
// in soro_soke/test/helpers/test_helpers.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:io' as _i18;
import 'dart:ui' as _i10;

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i2;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:flutter/material.dart' as _i8;
import 'package:logger/logger.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:soro_soke/models/api_response_model.dart' as _i3;
import 'package:soro_soke/models/user_model.dart' as _i15;
import 'package:soro_soke/services/authentication_service.dart' as _i11;
import 'package:soro_soke/services/database_service.dart' as _i16;
import 'package:soro_soke/services/friend_service.dart' as _i19;
import 'package:soro_soke/services/logger_service.dart' as _i12;
import 'package:soro_soke/services/message_service.dart' as _i20;
import 'package:soro_soke/services/storage_service.dart' as _i17;
import 'package:soro_soke/services/toast_service.dart' as _i13;
import 'package:soro_soke/services/user_service.dart' as _i14;
import 'package:stacked_services/stacked_services.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFirebaseAuth_0 extends _i1.SmartFake implements _i2.FirebaseAuth {
  _FakeFirebaseAuth_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeApiResponse_1 extends _i1.SmartFake implements _i3.ApiResponse {
  _FakeApiResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLogger_2 extends _i1.SmartFake implements _i4.Logger {
  _FakeLogger_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFirebaseFirestore_3 extends _i1.SmartFake
    implements _i5.FirebaseFirestore {
  _FakeFirebaseFirestore_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFirebaseStorage_4 extends _i1.SmartFake
    implements _i6.FirebaseStorage {
  _FakeFirebaseStorage_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i7.NavigationService {
  @override
  String get previousRoute => (super.noSuchMethod(
        Invocation.getter(#previousRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get currentRoute => (super.noSuchMethod(
        Invocation.getter(#currentRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i8.GlobalKey<_i8.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(
        Invocation.method(
          #nestedNavigationKey,
          [index],
        ),
        returnValueForMissingStub: null,
      ) as _i8.GlobalKey<_i8.NavigatorState>?);
  @override
  void config({
    bool? enableLog,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    _i7.Transition? defaultTransitionStyle,
    String? defaultTransition,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #config,
          [],
          {
            #enableLog: enableLog,
            #defaultPopGesture: defaultPopGesture,
            #defaultOpaqueRoute: defaultOpaqueRoute,
            #defaultDurationTransition: defaultDurationTransition,
            #defaultGlobalState: defaultGlobalState,
            #defaultTransitionStyle: defaultTransitionStyle,
            #defaultTransition: defaultTransition,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i9.Future<T?>? navigateWithTransition<T>(
    _i8.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i8.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i7.Transition? transitionClass,
    _i7.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateWithTransition,
          [page],
          {
            #opaque: opaque,
            #transition: transition,
            #duration: duration,
            #popGesture: popGesture,
            #id: id,
            #curve: curve,
            #fullscreenDialog: fullscreenDialog,
            #preventDuplicates: preventDuplicates,
            #transitionClass: transitionClass,
            #transitionStyle: transitionStyle,
            #routeName: routeName,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? replaceWithTransition<T>(
    _i8.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i8.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i7.Transition? transitionClass,
    _i7.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #replaceWithTransition,
          [page],
          {
            #opaque: opaque,
            #transition: transition,
            #duration: duration,
            #popGesture: popGesture,
            #id: id,
            #curve: curve,
            #fullscreenDialog: fullscreenDialog,
            #preventDuplicates: preventDuplicates,
            #transitionClass: transitionClass,
            #transitionStyle: transitionStyle,
            #routeName: routeName,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  bool back<T>({
    dynamic result,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #back,
          [],
          {
            #result: result,
            #id: id,
          },
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void popUntil(
    _i8.RoutePredicate? predicate, {
    int? id,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #popUntil,
          [predicate],
          {#id: id},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void popRepeated(int? popTimes) => super.noSuchMethod(
        Invocation.method(
          #popRepeated,
          [popTimes],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i9.Future<T?>? navigateTo<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i8.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateTo,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
            #transition: transition,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? navigateToView<T>(
    _i8.Widget? view, {
    dynamic arguments,
    int? id,
    bool? opaque,
    _i8.Curve? curve,
    Duration? duration,
    bool? fullscreenDialog = false,
    bool? popGesture,
    bool? preventDuplicates = true,
    _i7.Transition? transition,
    _i7.Transition? transitionStyle,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateToView,
          [view],
          {
            #arguments: arguments,
            #id: id,
            #opaque: opaque,
            #curve: curve,
            #duration: duration,
            #fullscreenDialog: fullscreenDialog,
            #popGesture: popGesture,
            #preventDuplicates: preventDuplicates,
            #transition: transition,
            #transitionStyle: transitionStyle,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? replaceWith<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i8.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #replaceWith,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
            #transition: transition,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? clearStackAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearStackAndShow,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #parameters: parameters,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? clearStackAndShowView<T>(
    _i8.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearStackAndShowView,
          [view],
          {
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? clearTillFirstAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearTillFirstAndShow,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? clearTillFirstAndShowView<T>(
    _i8.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearTillFirstAndShowView,
          [view],
          {
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
  @override
  _i9.Future<T?>? pushNamedAndRemoveUntil<T>(
    String? routeName, {
    _i8.RoutePredicate? predicate,
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushNamedAndRemoveUntil,
          [routeName],
          {
            #predicate: predicate,
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i9.Future<T?>?);
}

/// A class which mocks [BottomSheetService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBottomSheetService extends _i1.Mock
    implements _i7.BottomSheetService {
  @override
  void setCustomSheetBuilders(Map<dynamic, _i7.SheetBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #setCustomSheetBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i9.Future<_i7.SheetResponse<dynamic>?> showBottomSheet({
    required String? title,
    String? description,
    String? confirmButtonTitle = r'Ok',
    String? cancelButtonTitle,
    bool? enableDrag = true,
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showBottomSheet,
          [],
          {
            #title: title,
            #description: description,
            #confirmButtonTitle: confirmButtonTitle,
            #cancelButtonTitle: cancelButtonTitle,
            #enableDrag: enableDrag,
            #barrierDismissible: barrierDismissible,
            #isScrollControlled: isScrollControlled,
            #exitBottomSheetDuration: exitBottomSheetDuration,
            #enterBottomSheetDuration: enterBottomSheetDuration,
            #ignoreSafeArea: ignoreSafeArea,
            #useRootNavigator: useRootNavigator,
          },
        ),
        returnValue: _i9.Future<_i7.SheetResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i9.Future<_i7.SheetResponse<dynamic>?>.value(),
      ) as _i9.Future<_i7.SheetResponse<dynamic>?>);
  @override
  _i9.Future<_i7.SheetResponse<T>?> showCustomSheet<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i10.Color? barrierColor = const _i10.Color(2315255808),
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    String? barrierLabel = r'',
    dynamic customData,
    R? data,
    bool? enableDrag = true,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomSheet,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #barrierDismissible: barrierDismissible,
            #isScrollControlled: isScrollControlled,
            #barrierLabel: barrierLabel,
            #customData: customData,
            #data: data,
            #enableDrag: enableDrag,
            #exitBottomSheetDuration: exitBottomSheetDuration,
            #enterBottomSheetDuration: enterBottomSheetDuration,
            #ignoreSafeArea: ignoreSafeArea,
            #useRootNavigator: useRootNavigator,
          },
        ),
        returnValue: _i9.Future<_i7.SheetResponse<T>?>.value(),
        returnValueForMissingStub: _i9.Future<_i7.SheetResponse<T>?>.value(),
      ) as _i9.Future<_i7.SheetResponse<T>?>);
  @override
  void completeSheet(_i7.SheetResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeSheet,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [DialogService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDialogService extends _i1.Mock implements _i7.DialogService {
  @override
  void registerCustomDialogBuilders(
          Map<dynamic, _i7.DialogBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void registerCustomDialogBuilder({
    required dynamic variant,
    required _i8.Widget Function(
      _i8.BuildContext,
      _i7.DialogRequest<dynamic>,
      dynamic Function(_i7.DialogResponse<dynamic>),
    )? builder,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilder,
          [],
          {
            #variant: variant,
            #builder: builder,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i9.Future<_i7.DialogResponse<dynamic>?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    _i10.Color? cancelTitleColor,
    String? buttonTitle = r'Ok',
    _i10.Color? buttonTitleColor,
    bool? barrierDismissible = false,
    _i7.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #buttonTitle: buttonTitle,
            #buttonTitleColor: buttonTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i9.Future<_i7.DialogResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i9.Future<_i7.DialogResponse<dynamic>?>.value(),
      ) as _i9.Future<_i7.DialogResponse<dynamic>?>);
  @override
  _i9.Future<_i7.DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i10.Color? barrierColor = const _i10.Color(2315255808),
    bool? barrierDismissible = false,
    String? barrierLabel = r'',
    dynamic customData,
    R? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomDialog,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #barrierDismissible: barrierDismissible,
            #barrierLabel: barrierLabel,
            #customData: customData,
            #data: data,
          },
        ),
        returnValue: _i9.Future<_i7.DialogResponse<T>?>.value(),
        returnValueForMissingStub: _i9.Future<_i7.DialogResponse<T>?>.value(),
      ) as _i9.Future<_i7.DialogResponse<T>?>);
  @override
  _i9.Future<_i7.DialogResponse<dynamic>?> showConfirmationDialog({
    String? title,
    String? description,
    String? cancelTitle = r'Cancel',
    _i10.Color? cancelTitleColor,
    String? confirmationTitle = r'Ok',
    _i10.Color? confirmationTitleColor,
    bool? barrierDismissible = false,
    _i7.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showConfirmationDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #confirmationTitle: confirmationTitle,
            #confirmationTitleColor: confirmationTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i9.Future<_i7.DialogResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i9.Future<_i7.DialogResponse<dynamic>?>.value(),
      ) as _i9.Future<_i7.DialogResponse<dynamic>?>);
  @override
  void completeDialog(_i7.DialogResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeDialog,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AuthenticationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationService extends _i1.Mock
    implements _i11.AuthenticationService {
  @override
  _i2.FirebaseAuth get auth => (super.noSuchMethod(
        Invocation.getter(#auth),
        returnValue: _FakeFirebaseAuth_0(
          this,
          Invocation.getter(#auth),
        ),
        returnValueForMissingStub: _FakeFirebaseAuth_0(
          this,
          Invocation.getter(#auth),
        ),
      ) as _i2.FirebaseAuth);
  @override
  _i9.Stream<_i2.User?> get onAuthStateChanged => (super.noSuchMethod(
        Invocation.getter(#onAuthStateChanged),
        returnValue: _i9.Stream<_i2.User?>.empty(),
        returnValueForMissingStub: _i9.Stream<_i2.User?>.empty(),
      ) as _i9.Stream<_i2.User?>);
  @override
  _i9.Future<_i3.ApiResponse> signUp(
    String? name,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [
            name,
            email,
            password,
          ],
        ),
        returnValue: _i9.Future<_i3.ApiResponse>.value(_FakeApiResponse_1(
          this,
          Invocation.method(
            #signUp,
            [
              name,
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i9.Future<_i3.ApiResponse>.value(_FakeApiResponse_1(
          this,
          Invocation.method(
            #signUp,
            [
              name,
              email,
              password,
            ],
          ),
        )),
      ) as _i9.Future<_i3.ApiResponse>);
  @override
  _i9.Future<_i3.ApiResponse> signIn(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signIn,
          [
            email,
            password,
          ],
        ),
        returnValue: _i9.Future<_i3.ApiResponse>.value(_FakeApiResponse_1(
          this,
          Invocation.method(
            #signIn,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i9.Future<_i3.ApiResponse>.value(_FakeApiResponse_1(
          this,
          Invocation.method(
            #signIn,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i9.Future<_i3.ApiResponse>);
  @override
  _i9.Future<void> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}

/// A class which mocks [LoggerService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoggerService extends _i1.Mock implements _i12.LoggerService {
  @override
  _i4.Logger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeLogger_2(
          this,
          Invocation.getter(#logger),
        ),
        returnValueForMissingStub: _FakeLogger_2(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i4.Logger);
  @override
  set logger(_i4.Logger? _logger) => super.noSuchMethod(
        Invocation.setter(
          #logger,
          _logger,
        ),
        returnValueForMissingStub: null,
      );
  @override
  void error(String? msg) => super.noSuchMethod(
        Invocation.method(
          #error,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void info(String? msg) => super.noSuchMethod(
        Invocation.method(
          #info,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void warning(String? msg) => super.noSuchMethod(
        Invocation.method(
          #warning,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void message(String? msg) => super.noSuchMethod(
        Invocation.method(
          #message,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ToastService].
///
/// See the documentation for Mockito's code generation for more information.
class MockToastService extends _i1.Mock implements _i13.ToastService {
  @override
  void error(String? msg) => super.noSuchMethod(
        Invocation.method(
          #error,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void info(String? msg) => super.noSuchMethod(
        Invocation.method(
          #info,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void success(String? msg) => super.noSuchMethod(
        Invocation.method(
          #success,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void warning(String? msg) => super.noSuchMethod(
        Invocation.method(
          #warning,
          [msg],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UserService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserService extends _i1.Mock implements _i14.UserService {
  @override
  _i9.Stream<_i2.User?> get authStream => (super.noSuchMethod(
        Invocation.getter(#authStream),
        returnValue: _i9.Stream<_i2.User?>.empty(),
        returnValueForMissingStub: _i9.Stream<_i2.User?>.empty(),
      ) as _i9.Stream<_i2.User?>);
  @override
  _i9.Future<void> createUser(_i15.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [user],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  _i9.Future<void> changeProfilePhoto() => (super.noSuchMethod(
        Invocation.method(
          #changeProfilePhoto,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
  @override
  _i9.Future<_i15.UserModel?> getUserFromID(dynamic uid) => (super.noSuchMethod(
        Invocation.method(
          #getUserFromID,
          [uid],
        ),
        returnValue: _i9.Future<_i15.UserModel?>.value(),
        returnValueForMissingStub: _i9.Future<_i15.UserModel?>.value(),
      ) as _i9.Future<_i15.UserModel?>);
}

/// A class which mocks [DatabaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseService extends _i1.Mock implements _i16.DatabaseService {
  @override
  _i5.FirebaseFirestore get store => (super.noSuchMethod(
        Invocation.getter(#store),
        returnValue: _FakeFirebaseFirestore_3(
          this,
          Invocation.getter(#store),
        ),
        returnValueForMissingStub: _FakeFirebaseFirestore_3(
          this,
          Invocation.getter(#store),
        ),
      ) as _i5.FirebaseFirestore);
  @override
  _i9.Future<void> addUser(_i15.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [user],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i17.StorageService {
  @override
  _i6.FirebaseStorage get storage => (super.noSuchMethod(
        Invocation.getter(#storage),
        returnValue: _FakeFirebaseStorage_4(
          this,
          Invocation.getter(#storage),
        ),
        returnValueForMissingStub: _FakeFirebaseStorage_4(
          this,
          Invocation.getter(#storage),
        ),
      ) as _i6.FirebaseStorage);
  @override
  _i9.Future<String> uploadImageToFirebase(_i18.File? imageFile) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadImageToFirebase,
          [imageFile],
        ),
        returnValue: _i9.Future<String>.value(''),
        returnValueForMissingStub: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<String?> getDefaultImage() => (super.noSuchMethod(
        Invocation.method(
          #getDefaultImage,
          [],
        ),
        returnValue: _i9.Future<String?>.value(),
        returnValueForMissingStub: _i9.Future<String?>.value(),
      ) as _i9.Future<String?>);
}

/// A class which mocks [FriendService].
///
/// See the documentation for Mockito's code generation for more information.
class MockFriendService extends _i1.Mock implements _i19.FriendService {
  @override
  _i9.Future<_i5.QuerySnapshot<Object?>?> acceptRequest(dynamic friendID) =>
      (super.noSuchMethod(
        Invocation.method(
          #acceptRequest,
          [friendID],
        ),
        returnValue: _i9.Future<_i5.QuerySnapshot<Object?>?>.value(),
        returnValueForMissingStub:
            _i9.Future<_i5.QuerySnapshot<Object?>?>.value(),
      ) as _i9.Future<_i5.QuerySnapshot<Object?>?>);
  @override
  _i9.Future<_i5.QuerySnapshot<Object?>?> removeFriend(dynamic friendID) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFriend,
          [friendID],
        ),
        returnValue: _i9.Future<_i5.QuerySnapshot<Object?>?>.value(),
        returnValueForMissingStub:
            _i9.Future<_i5.QuerySnapshot<Object?>?>.value(),
      ) as _i9.Future<_i5.QuerySnapshot<Object?>?>);
  @override
  _i9.Future<_i5.QuerySnapshot<Object?>?> rejectRequest(dynamic friendID) =>
      (super.noSuchMethod(
        Invocation.method(
          #rejectRequest,
          [friendID],
        ),
        returnValue: _i9.Future<_i5.QuerySnapshot<Object?>?>.value(),
        returnValueForMissingStub:
            _i9.Future<_i5.QuerySnapshot<Object?>?>.value(),
      ) as _i9.Future<_i5.QuerySnapshot<Object?>?>);
  @override
  _i9.Future<bool> sendFriendRequest(dynamic friendID) => (super.noSuchMethod(
        Invocation.method(
          #sendFriendRequest,
          [friendID],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
  @override
  _i9.Future<bool> hasSentRequest(dynamic friendID) => (super.noSuchMethod(
        Invocation.method(
          #hasSentRequest,
          [friendID],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
  @override
  _i9.Future<bool> hasReceivedRequest(dynamic friendID) => (super.noSuchMethod(
        Invocation.method(
          #hasReceivedRequest,
          [friendID],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
  @override
  _i9.Future<bool> cancelRequest(dynamic friendID) => (super.noSuchMethod(
        Invocation.method(
          #cancelRequest,
          [friendID],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
  @override
  _i9.Future<bool> isFriend(dynamic friendID) => (super.noSuchMethod(
        Invocation.method(
          #isFriend,
          [friendID],
        ),
        returnValue: _i9.Future<bool>.value(false),
        returnValueForMissingStub: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
}

/// A class which mocks [MessageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageService extends _i1.Mock implements _i20.MessageService {}
