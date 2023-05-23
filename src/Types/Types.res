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
  name: string,
  email: string,
  password: string,
}

type userResponse = Belt.Result.t<user, string>

type appState = {
  mutable user: user,
  mutable appContext: appContext,
  mutable isLightTheme: bool,
  mutable isToastOpen: bool,
  mutable toastMessage: string,
}

type predict = {message: string}

type predictResponse = Belt.Result.t<predict, string>

type stockData = {
  name: string,
  price: string,
  volume: string,
  timestamp: string,
}

type stockResponse = Belt.Result.t<stockData, string>

type stockUI = {
  stockName: string,
  stockAmount: int,
}
