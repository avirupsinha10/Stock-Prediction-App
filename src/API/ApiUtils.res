open Promise

let makeBody = array =>
  array->Js.Dict.fromArray->Js.Json.object_->Js.Json.stringify->Fetch.BodyInit.make

let defaultErrorHandler = response =>
  response->Fetch.Response.text->thenResolve(Parser.parseErrorResponse(_, "Error"))

let getApiPromise = (url, ~body, ~handleSuccessResponse, ~handleErrorResponse) =>
  Fetch.fetchWithInit(
    url,
    Fetch.RequestInit.make(
      ~headers=Fetch.HeadersInit.make({
        "Content-Type": "application/json",
      }),
      ~method_=Fetch.Post,
      ~body=body->makeBody,
      (),
    ),
  )
  ->then(response =>
    switch response->Fetch.Response.status {
    | 200 =>
      response
      ->Fetch.Response.text
      ->thenResolve(stringifiedFlow => stringifiedFlow->handleSuccessResponse->Belt.Result.Ok)
    | _ => response->handleErrorResponse
    }
  )
  ->catch(e => Belt.Result.Error(e->JsUtil.External.treatAsAny)->resolve)

let caller = (apiPromise, ~onError, ~onOk, ~beforeResolve=() => (), ()) =>
  apiPromise
  ->thenResolve(response => {
    switch response {
    | Error(errorData) => onError(errorData)
    | Ok(responseData) => onOk(responseData)
    }
    beforeResolve()
  })
  ->ignore

let useApiCall = (
  apiPromise,
  apiName,
  ~payload,
  ~onStart=() => (),
  ~onSuccess,
  ~onFailure,
  ~beforeResolve=() => (),
  (),
) => {
  Js.log2(apiName, "API call, please wait !!!")
  onStart()
  caller(
    apiPromise(~payload),
    ~onError=error => {
      Js.log3(apiName, "Error :", error)
      onFailure(error)
    },
    ~onOk=ok => {
      Js.log3(apiName, "Success :", ok)
      onSuccess(ok)
    },
    ~beforeResolve,
    (),
  )
}
