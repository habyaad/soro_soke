import 'package:soro_soke/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:soro_soke/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:soro_soke/ui/views/home/home_view.dart';
import 'package:soro_soke/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:soro_soke/ui/views/login/login_view.dart';
import 'package:soro_soke/ui/views/sign_up/sign_up_view.dart';
import 'package:soro_soke/services/authentication_service.dart';
import 'package:soro_soke/services/logger_service.dart';
import 'package:soro_soke/services/toast_service.dart';
import 'package:soro_soke/services/user_service.dart';
import 'package:soro_soke/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:soro_soke/ui/views/profile/profile_view.dart';
import 'package:soro_soke/ui/views/search/search_view.dart';
import 'package:soro_soke/ui/views/friends/friends_view.dart';
import 'package:soro_soke/ui/views/settings/settings_view.dart';
import 'package:soro_soke/services/database_service.dart';
import 'package:soro_soke/services/storage_service.dart';
import 'package:soro_soke/ui/views/user_profile/user_profile_view.dart';
import 'package:soro_soke/services/friend_service.dart';
import 'package:soro_soke/ui/views/friend_requests/friend_requests_view.dart';
import 'package:soro_soke/services/message_service.dart';
import 'package:soro_soke/ui/views/chat/chat_view.dart';
import 'package:soro_soke/ui/views/onboarding/onboarding_view.dart';
import 'package:soro_soke/ui/dialogs/loading/loading_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: BottomNavView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: FriendsView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: FriendRequestsView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: OnboardingView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: LoggerService),
    LazySingleton(classType: ToastService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: FriendService),
    LazySingleton(classType: MessageService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: LoadingDialog),
// @stacked-dialog
  ],
)
class App {}
