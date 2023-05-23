open Promise

// let changeStepStatus: (
//   ~payload: Types.changeStepStatusRequest,
//   ~token: string,
// ) => t<Types.changeStepStatusResponse> = (~payload, ~token) => {
//   let body = [
//     ("id", payload.id->Js.Json.string),
//     ("status", (payload.status :> string)->Js.Json.string),
//   ]
//   payload.presentVersion
//   ->Belt.Option.map(presentVersion =>
//     body->Js.Array2.push(("present_version", presentVersion->Js.Json.string))
//   )
//   ->ignore

//   ApiUtils.getApiPromise(
//     ApiEndpoints.changeStepStatusURL,
//     ~token,
//     ~body,
//     ~handleSuccessResponse=Parser.parseChangeStepStatusArray,
//     ~handleErrorResponse=response => {
//       switch response->Fetch.Response.status {
//       | 409 => #CONFLICTED->Belt.Result.Error->resolve
//       | _ => response->Fetch.Response.text->thenResolve(str => #OTHER_ERROR(str)->Belt.Result.Error)
//       }
//     },
//   )
// }

let loginUser: (~payload: Js.Json.t) => t<Types.userResponse> = (~payload) => {
  let body =
    payload
    ->Js.Json.decodeObject
    ->Belt.Option.mapWithDefault([], dict => {
      [
        ("username", dict->Parser.getString("username", "")->Js.Json.string),
        ("password", dict->Parser.getString("password", "")->Js.Json.string),
      ]
    })
  ApiUtils.getApiPromise(
    ApiEndpoints.loginUserURL,
    ~body,
    ~handleSuccessResponse=resp => {
      // Js.log(resp)
      Parser.parseUserData(resp)
    },
    ~handleErrorResponse=ApiUtils.defaultErrorHandler,
  )
}

let registerUser: (~payload: Js.Json.t) => t<Types.userResponse> = (~payload) => {
  let body =
    payload
    ->Js.Json.decodeObject
    ->Belt.Option.mapWithDefault([], dict => {
      [
        ("name", dict->Parser.getString("name", "")->Js.Json.string),
        ("username", dict->Parser.getString("username", "")->Js.Json.string),
        ("email", dict->Parser.getString("email", "")->Js.Json.string),
        ("password", dict->Parser.getString("password", "")->Js.Json.string),
      ]
    })
  ApiUtils.getApiPromise(
    ApiEndpoints.registerUserURL,
    ~body,
    ~handleSuccessResponse=resp => Parser.parseUserData(resp),
    ~handleErrorResponse=ApiUtils.defaultErrorHandler,
  )
}

let predictStock: (~payload: Js.Json.t) => t<Types.predictResponse> = (~payload) => {
  let body =
    payload
    ->Js.Json.decodeObject
    ->Belt.Option.mapWithDefault([], dict => {
      [("stock_name", dict->Parser.getString("stock_name", "")->Js.Json.string)]
    })
  ApiUtils.getApiPromise(
    ApiEndpoints.predictStockURL,
    ~body,
    ~handleSuccessResponse=resp => Parser.parsePredictData(resp),
    ~handleErrorResponse=ApiUtils.defaultErrorHandler,
  )
}

let fetchStockData: (~payload: Js.Json.t) => t<Types.stockResponse> = (~payload) => {
  let body =
    payload
    ->Js.Json.decodeObject
    ->Belt.Option.mapWithDefault([], dict => {
      [("company_name", dict->Parser.getString("company_name", "")->Js.Json.string)]
    })
  ApiUtils.getApiPromise(
    ApiEndpoints.getStockDetailsURL,
    ~body,
    ~handleSuccessResponse=resp => Parser.parseStockData(resp),
    ~handleErrorResponse=ApiUtils.defaultErrorHandler,
  )
}

// let fetchEmailList: (
//   ~payload: Types.fetchEmailListRequest,
//   ~token: string,
// ) => t<Types.fetchEmailListResponse> = (~payload, ~token) => {
//   ApiUtils.getApiPromise(
//     ApiEndpoints.fetchAllEmailURL,
//     ~token,
//     ~body=[
//       ("merchant_id", payload.merchantId->Js.Json.string),
//       ("product_id", payload.productId->Js.Json.string),
//     ],
//     ~handleSuccessResponse=response =>
//       response->Parser.stringToOptionalDict->Belt.Option.getWithDefault(Js.Dict.empty()),
//     ~handleErrorResponse=ApiUtils.defaultErrorHandler,
//   )
// }

// let updateMerchantStatus: (
//   ~payload: Js.Json.t,
//   ~token: string,
// ) => t<Types.updateMerchantStatusResponse> = (~payload, ~token) => {
//   Fetch.fetchWithInit(
//     ApiEndpoints.updateMerchantStatusURL,
//     Fetch.RequestInit.make(
//       ~headers=ApiUtils.defaultHeaders(token),
//       ~method_=Fetch.Post,
//       ~body=payload->Js.Json.stringify->Fetch.BodyInit.make,
//       (),
//     ),
//   )
//   ->then(response =>
//     switch response->Fetch.Response.status {
//     | 200 =>
//       response
//       ->Fetch.Response.text
//       ->thenResolve(response => response->Parser.parseMerchantStatusResponse->Belt.Result.Ok)
//     | _ => response->ApiUtils.defaultErrorHandler
//     }
//   )
//   ->catch(e => Belt.Result.Error(e->JsUtil.External.treatAsAny)->resolve)
// }
