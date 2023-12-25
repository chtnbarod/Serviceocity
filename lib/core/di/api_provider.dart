class ApiProvider{

  static const String url = 'https://serviceocitynewadmin.serviceocity.com';
  // static const String url = 'https://liveadminapp.serviceocity.com';
  static const String baseUrl = '$url/api/';

  /// login api
  static const String login = 'login';
  static const String register = 'register';
  static const String user = 'profile';
  static const String updatePlayerId = 'update_player_id';
  static const String viewWallet = 'viewwallet';
  static const String updateProfile = 'updateprofile';
  static const String addAddress = 'address';
  static const String updateAddress = 'updateaddress';
  static const String setPrimaryAddress = 'addressprimry';
  static const String deleteAddress = 'deleteAddress';

  static const String globalSetting = 'globalsetting';


  static const String getCategories = 'categories';
  static const String getSubCategories = 'subcategories';
  static const String getChildCategories = 'subchildcategories';

  static const String getService = 'service';
  static const String getServiceDetails = 'servicedetails';
  static const String searchService = 'searchByName';

  static const String allBanners = 'allbanners';
  static const String getFeature = 'home';

  static const String orderPlace = 'placeorder';
  static const String userOrders = 'user_orders';
  static const String orderDetails = 'user_orders_details';
  static const String validateAddress = 'validateAddress';
  static const String reschedule = 'reschedule';
  static const String cancelBooking = 'cancelBooking';
  static const String getRecentOrders = 'getRecentOrders';

  // Cart APIs
  static const String addToCart = 'addtocart';
  static const String viewCart = 'viewcart';
  static const String updateCart = 'updatecart';
  static const String deleteCart = 'deletecart';

  // discount
  static const String getCouponDiscount = 'discount';
  static const String applyCoupon = 'applydiscount';
  // https://serviceocitynewadmin.serviceocity.com/api/apply-discount?id=1
  static const String getTimeslots = 'gettimeslots';

  /// Session
  static const String preferencesToken = 'USER_TOKEN';
}
