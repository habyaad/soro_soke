import 'package:soro_soke/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:soro_soke/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:soro_soke/ui/views/home/home_view.dart';
import 'package:soro_soke/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:soro_soke/ui/views/login/login_view.dart';
import 'package:soro_soke/ui/views/sign_up/sign_up_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
