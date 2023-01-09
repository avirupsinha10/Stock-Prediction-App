type header = {
  label: string,
  align: option<string>,
}

type tableContext = {
  headerFields: array<header>,
  list: array<Js.Dict.t<string>>,
  onEdit: option<Js.Dict.t<string> => unit>,
}

// type dropDownOption = Value(string) | ValueLabelPair((string, string))
