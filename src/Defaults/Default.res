let user: Types.user = {
  username: "",
  merchantId: None,
  email: None,
  context: #INTERNAL,
}

let userContextArray: array<Types.userContext> = [#INTERNAL, #EMPLOYEE, #MERCHANT]

let merchantDetails: Types.merchantDetails = {
  merchantId: "",
  merchantStatus: false,
  activeGuards: [],
  activeGunMans: [],
  activeBouncers: [],
}

let emptyString = ""
