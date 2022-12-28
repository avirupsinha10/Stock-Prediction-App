type merchantDetails = {
  merchantId: string,
  merchantStatus: bool,
  activeGuards: array<string>,
  activeGunMans: array<string>,
  activeBouncers: array<string>,
}
type appContext = MerchantView(string) | PSSView(array<merchantDetails>)

type environment = [#prod | #sandbox | #integ]

type user = {
  username: string,
  token: string,
  merchantId: string,
  email: string,
  context: string,
}

type appState = {
  mutable user: user,
  mutable appContext: appContext,
}
