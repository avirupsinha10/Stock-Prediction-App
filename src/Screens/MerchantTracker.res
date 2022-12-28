@react.component
let make = (~merchantDetails: array<Types.merchantDetails>) => {
  merchantDetails->Js.Array2.map(ele => ele.merchantId->React.string)->React.array
}
