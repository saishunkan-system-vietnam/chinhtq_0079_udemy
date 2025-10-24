enum RouteRoot: Hashable {
  case splash, login, home
}

enum RouteLogin: Hashable {
  case loginAccount, loginQR
}

enum Route: Hashable {
  case registerGrantApp, 
       confirmGrantApp, 
       grantAppRegistered,
       grantAppStatus,
       cancelGrantApp,
       confirmCancellation,
       grantAppCancelled,
       grantAppHistory,
       couponScan,
       grantAppDetail,
       license,
       termsOfService
}
