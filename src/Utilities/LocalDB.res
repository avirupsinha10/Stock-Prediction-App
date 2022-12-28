//Note:
//Some browsers might have localStorage disabled and accessing localStorage in that case might throw an error.
//So Always consider any localStorage operation as unsafe

type model = [
  | #userDetails
  | #merchantId
  | #tutorial
  | #giveMePower
]

open JsUtil
let setItem: (model, string) => unit = (a, b) =>
  LocalStore.localStorage->LocalStore.setItem("PSS_" ++ (a :> string), b)
let getItem = a =>
  LocalStore.localStorage
  ->LocalStore.getItem("PSS_" ++ a->External.treatAsString)
  ->Js.Null_undefined.toOption

let storeUserDetails = (~userDetails: Types.user) =>
  try {
    setItem(#userDetails, userDetails->External.treatAsJson->Js.Json.stringify)
  } catch {
  | e => Js.log2("Unable to store user details", e)
  }

let fetchUserDetails = () =>
  try {
    #userDetails->getItem->Belt.Option.map(a => a->Parser.parseUserData)
  } catch {
  | e => {
      Js.log2("Unable to retrieve user details", e)
      None
    }
  }

let removeUserDetails = () =>
  try {
    LocalStore.localStorage->LocalStore.removeItem(#userDetails->External.treatAsString)
  } catch {
  | e => Js.log2("Unable to remove userDetails", e)
  }
