type merchantDetails = {
  merchantId: string,
  merchantStatus: bool,
  activeGuards: array<string>,
  activeGunMans: array<string>,
  activeBouncers: array<string>,
}
type appContext = MerchantView(string) | PSSView(array<merchantDetails>) | EmployeeView(string)

type environment = [#prod | #integ]

type userContext = [#INTERNAL | #MERCHANT | #EMPLOYEE]

type user = {
  username: string,
  merchantId: option<string>,
  email: option<string>,
  context: userContext,
}

type userResponse = Belt.Result.t<user, string>

type appState = {
  mutable user: user,
  mutable appContext: appContext,
  mutable isLightTheme: bool,
  mutable isToastOpen: bool,
  mutable toastMessage: string,
}
