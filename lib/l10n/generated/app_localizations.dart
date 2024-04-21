import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @username.
  ///
  /// In vi, this message translates to:
  /// **'Tên tài khoản'**
  String get username;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu '**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgotPassword;

  /// No description provided for @orSigninWith.
  ///
  /// In vi, this message translates to:
  /// **'hoặc đăng nhập với'**
  String get orSigninWith;

  /// No description provided for @about.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin'**
  String get about;

  /// No description provided for @sessions.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get sessions;

  /// No description provided for @certificate.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại'**
  String get certificate;

  /// No description provided for @runtime.
  ///
  /// In vi, this message translates to:
  /// **'Thời lượng'**
  String get runtime;

  /// No description provided for @release.
  ///
  /// In vi, this message translates to:
  /// **'Ra mắt'**
  String get release;

  /// No description provided for @gerne.
  ///
  /// In vi, this message translates to:
  /// **'Thể loại'**
  String get gerne;

  /// No description provided for @director.
  ///
  /// In vi, this message translates to:
  /// **'Đạo diễn'**
  String get director;

  /// No description provided for @cast.
  ///
  /// In vi, this message translates to:
  /// **'Diễn viên'**
  String get cast;

  /// No description provided for @time.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get time;

  /// No description provided for @byCinema.
  ///
  /// In vi, this message translates to:
  /// **'Theo rạp'**
  String get byCinema;

  /// No description provided for @adult.
  ///
  /// In vi, this message translates to:
  /// **'Người lớn'**
  String get adult;

  /// No description provided for @child.
  ///
  /// In vi, this message translates to:
  /// **'Trẻ em'**
  String get child;

  /// No description provided for @student.
  ///
  /// In vi, this message translates to:
  /// **'Học sinh'**
  String get student;

  /// No description provided for @vip.
  ///
  /// In vi, this message translates to:
  /// **'VIP'**
  String get vip;

  /// No description provided for @payforticket.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán vé'**
  String get payforticket;

  /// No description provided for @cinema.
  ///
  /// In vi, this message translates to:
  /// **'Rạp phim'**
  String get cinema;

  /// No description provided for @date.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get date;

  /// No description provided for @seats.
  ///
  /// In vi, this message translates to:
  /// **'Hàng ghế'**
  String get seats;

  /// No description provided for @total.
  ///
  /// In vi, this message translates to:
  /// **'Tổng cộng'**
  String get total;

  /// No description provided for @phonenumber.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phonenumber;

  /// No description provided for @continueword.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get continueword;

  /// No description provided for @nowincinemas.
  ///
  /// In vi, this message translates to:
  /// **'Phim đang chiếu'**
  String get nowincinemas;

  /// No description provided for @upcoming.
  ///
  /// In vi, this message translates to:
  /// **'Phim sắp chiếu'**
  String get upcoming;

  /// No description provided for @profile.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản '**
  String get profile;

  /// No description provided for @fullname.
  ///
  /// In vi, this message translates to:
  /// **'Họ tên'**
  String get fullname;

  /// No description provided for @dateofbirth.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get dateofbirth;

  /// No description provided for @email.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @gender.
  ///
  /// In vi, this message translates to:
  /// **'Giới tính'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In vi, this message translates to:
  /// **'Nam'**
  String get male;

  /// No description provided for @female.
  ///
  /// In vi, this message translates to:
  /// **'Nữ'**
  String get female;

  /// No description provided for @other.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get other;

  /// No description provided for @city.
  ///
  /// In vi, this message translates to:
  /// **'Thành phố'**
  String get city;

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @receivenotifications.
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo'**
  String get receivenotifications;

  /// No description provided for @infomation.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin'**
  String get infomation;

  /// No description provided for @save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// No description provided for @settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// No description provided for @savedcards.
  ///
  /// In vi, this message translates to:
  /// **'Thẻ đã lưu'**
  String get savedcards;

  /// No description provided for @addnewcard.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thẻ mới'**
  String get addnewcard;

  /// No description provided for @paymentshistory.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử thanh toán'**
  String get paymentshistory;

  /// No description provided for @yourname.
  ///
  /// In vi, this message translates to:
  /// **'Tên của bạn'**
  String get yourname;

  /// No description provided for @youremail.
  ///
  /// In vi, this message translates to:
  /// **'Email của bạn'**
  String get youremail;

  /// No description provided for @hochiminhcity.
  ///
  /// In vi, this message translates to:
  /// **'TP Hồ Chí Minh'**
  String get hochiminhcity;

  /// No description provided for @danangcity.
  ///
  /// In vi, this message translates to:
  /// **'TP Đà Nẵng'**
  String get danangcity;

  /// No description provided for @hanoicity.
  ///
  /// In vi, this message translates to:
  /// **'TP Hà Nội'**
  String get hanoicity;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
