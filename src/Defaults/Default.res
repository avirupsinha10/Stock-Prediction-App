let user: Types.user = {
  username: "",
  token: "",
  merchantId: "",
  email: "",
  context: "",
}

let emptyString = ""

let popupContext: UiTypes.popupContext = {
  className: "",
  id: "",
  titleText: "",
  initialJson: Js.Json.null,
  inputFields: [],
  outputFields: [],
  showResetButton: false,
  onSubmit: {_ => ()},
  showCloseButton: false,
}
