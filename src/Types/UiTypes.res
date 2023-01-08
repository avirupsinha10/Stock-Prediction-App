type header = {
  label: string,
  align: option<string>,
}

type tableContext = {
  headerFields: array<header>,
  list: array<Js.Dict.t<string>>,
  onEdit: option<Js.Dict.t<string> => unit>,
}

type dropDownOption = Value(string) | ValueLabelPair((string, string))

type inputType = [
  | #NonEditable
  | #DropDown({"options": array<dropDownOption>})
  | #TextInput({"required": bool})
  | #Chip
]

type outputType = [
  | #Table(tableContext)
]

type fieldInput = {
  fieldType: inputType,
  key: string,
  id: string,
  label: string,
  placeholderText: string,
}

type fieldOutput = {
  fieldType: outputType,
  id: string,
  label: string,
}

type popupContext = {
  className: string,
  id: string,
  titleText: string,
  initialJson: Js.Json.t,
  inputFields: array<fieldInput>,
  outputFields: array<fieldOutput>,
  showResetButton: bool,
  onSubmit: Js.Json.t => unit,
  showCloseButton: bool,
}
