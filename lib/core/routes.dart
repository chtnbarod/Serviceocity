

import 'package:get/get.dart';
import 'package:serviceocity/view/address/binding.dart';
import 'package:serviceocity/view/booking/binding.dart';
import 'package:serviceocity/view/category/view.dart';
import 'package:serviceocity/view/checkout/binding.dart';
import 'package:serviceocity/view/login/binding.dart';
import 'package:serviceocity/view/refer/binding.dart';
import 'package:serviceocity/view/service_detail/binding.dart';
import 'package:serviceocity/view/signup/binding.dart';
import 'package:serviceocity/view/time_slots/binding.dart';
import 'package:serviceocity/view/verify_otp/view.dart';

import '../view/account/view.dart';
import '../view/address/view.dart';
import '../view/base/view.dart';
import '../view/booking/view.dart';
import '../view/cart/view.dart';
import '../view/checkout/view.dart';
import '../view/home/view.dart';
import '../view/login/view.dart';
import '../view/profile/binding.dart';
import '../view/profile/view.dart';
import '../view/refer/view.dart';
import '../view/search/binding.dart';
import '../view/search/view.dart';
import '../view/service/binding.dart';
import '../view/service/view.dart';
import '../view/service_detail/view.dart';
import '../view/signup/view.dart';
import '../view/splash/binding.dart';
import '../view/splash/view.dart';
import '../view/time_slots/view.dart';
import '../view/wallet/view.dart';

/// application routes name
const String rsDefaultPage = "/";
const String rsBasePage = "/Base";
const String rsHomePage = "/Home";
const String rsLoginPage = "/Login";
const String rsSignupPage = "/Signup";
const String rsVerifyOtpPage = "/VerifyOtp";
const String rsService = "/Service";
const String rsServiceDetailPage = "/ServiceDetailPage";
const String rsProfilePage = "/ProfilePage";
const String rsCartPage = "/CartPage";
const String rsAddressPage = "/AddressPage";
// const String rsMyMap = "/MyMap";
const String rsAccountPage = "/AccountPage";
const String rsCheckoutPage = "/CheckoutPage";
const String rsTimeSlotsPage = "/TimeSlotsPage";
const String rsReferPage = "/ReferPage";
const String rsWalletPage = "/WalletPage";
const String rsCategoryPage = "/CategoryPage";
const String rsBookingPage = "/BookingPage";
const String rsSearchPage = "/SearchPage";
// const String rsOfferPage = "/OfferPage";

class Routes{

  static final routes = [

    GetPage(name: rsBasePage, page: () => const BasePage()),
    GetPage(name: rsHomePage, page: () => const HomePage()),
    GetPage(name: rsAccountPage, page: () => const AccountPage()),
    GetPage(name: rsCartPage, page: () => const CartPage()),
    GetPage(name: rsVerifyOtpPage, page: () =>  const VerifyOtpPage()),
    GetPage(name: rsCategoryPage, page: () =>  const CategoryPage()),
    GetPage(name: rsWalletPage, page: () => const WalletPage()),

    GetPage(name: rsDefaultPage, page: () => const SplashPage(),binding: SplashBinding()),
    GetPage(name: rsLoginPage, page: () => const LoginPage(),binding: LoginBinding()),

    GetPage(name: rsSignupPage, page: () => const SignupPage(),binding: SignupBinding()),
    GetPage(name: rsService, page: () => const ServicePage(),binding: ServiceBinding()),
    GetPage(name: rsServiceDetailPage, page: () => const ServiceDetailPage(),binding: ServiceDetailBinding()),
    GetPage(name: rsProfilePage, page: () => const ProfilePage(),binding: ProfileBinding()),

    GetPage(name: rsAddressPage, page: () => const AddressPage(),binding: AddressBinding()),
    GetPage(name: rsAddressPage, page: () => const CheckoutPage(),binding: AddressBinding()),
    GetPage(name: rsReferPage, page: () => const ReferPage(),binding: ReferBinding()),

    GetPage(name: rsCheckoutPage, page: () => const CheckoutPage(),binding: CheckoutBinding()),
    GetPage(name: rsTimeSlotsPage, page: () => const TimeSlotsPage(),binding: TimeSlotsBinding()),
    GetPage(name: rsBookingPage, page: () => const BookingPage(),binding: BookingBinding()),
    GetPage(name: rsSearchPage, page: () => const SearchPage(),binding: SearchBinding()),
  ];

}