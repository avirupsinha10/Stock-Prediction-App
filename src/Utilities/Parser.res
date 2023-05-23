external toUserContextData: string => Types.userContext = "%identity"
let stringToOptionalDict = string => string->Js.Json.parseExn->Js.Json.decodeObject
let stringToOptionalArray = string => string->Js.Json.parseExn->Js.Json.decodeArray
let jsonToString = val => val->Js.Json.decodeString->Belt.Option.getWithDefault("")
let jsonToArray = (val: Js.Json.t) => val->Js.Json.decodeArray->Belt.Option.getWithDefault([])

let getOptionalArrayFromJson = (dict, key, type_: Js.Json.t => option<'a>): option<array<'a>> =>
  dict
  ->Js.Dict.get(key)
  ->Belt.Option.flatMap(Js.Json.decodeArray)
  ->Belt.Option.map(Belt.Array.keepMap(_, type_))

let getArray = (dict, key, type_: Js.Json.t => option<'a>) =>
  getOptionalArrayFromJson(dict, key, type_)->Belt.Option.getWithDefault([])

let getOptionString = (dict, key) =>
  dict->Js.Dict.get(key)->Belt.Option.flatMap(Js.Json.decodeString)

let getOptionFloat = (dict, key) =>
  dict->Js.Dict.get(key)->Belt.Option.flatMap(Js.Json.decodeNumber)

let getString = (dict, key, default) =>
  getOptionString(dict, key)->Belt.Option.getWithDefault(default)

let getInt = (dict, key, default) =>
  getOptionFloat(dict, key)->Belt.Option.mapWithDefault(default, Belt.Float.toInt)

let getBool = (dict, key, default) =>
  dict
  ->Js.Dict.get(key)
  ->Belt.Option.flatMap(Js.Json.decodeBoolean)
  ->Belt.Option.getWithDefault(default)

let getStringFromJson = (json: Js.Json.t, key: string) =>
  json
  ->Js.Json.decodeObject
  ->Belt.Option.flatMap(getOptionString(_, key))
  ->Belt.Option.getWithDefault(Default.emptyString)

let parseUserData = (jsonString: string) =>
  jsonString
  ->stringToOptionalDict
  ->Belt.Option.mapWithDefault(Default.user, (dict): Types.user => {
    username: dict->getString("username", ""),
    name: dict->getString("name", ""),
    email: dict->getString("email", ""),
    password: dict->getString("password", ""),
  })

let parsePredictData = (jsonString: string) =>
  jsonString
  ->stringToOptionalDict
  ->Belt.Option.mapWithDefault(Default.predictResponse, (dict): Types.predict => {
    message: dict->getString("message", ""),
  })

let parseErrorResponse = (jsonString, default) =>
  jsonString
  ->stringToOptionalDict
  ->Belt.Option.flatMap(getOptionString(_, "responseMessage"))
  ->Belt.Option.getWithDefault(default)
  ->Belt.Result.Error

let parseStockData = (jsonString: string) =>
  jsonString
  ->stringToOptionalDict
  ->Belt.Option.mapWithDefault(Default.stockData, (dict): Types.stockData => {
    name: dict->getString("symbol", ""),
    price: dict->getString("price", ""),
    volume: dict->getString("volume", ""),
    timestamp: dict->getString("timestamp", ""),
  })
