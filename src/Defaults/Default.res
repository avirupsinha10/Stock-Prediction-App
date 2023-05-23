let user: Types.user = {
  username: "",
  name: "",
  email: "",
  password: "",
}

let userContextArray: array<Types.userContext> = [#INTERNAL, #EMPLOYEE, #MERCHANT]

let merchantDetails: Types.merchantDetails = {
  merchantId: "",
  merchantStatus: false,
  activeGuards: [],
  activeGunMans: [],
  activeBouncers: [],
}
let predictResponse: Types.predict = {
  message: "",
}

let emptyString = ""

let stockData: Types.stockData = {
  name: "",
  price: "",
  volume: "",
  timestamp: "",
}

let stockUI: Types.stockUI = {
  stockName: "",
  stockAmount: 0,
}
