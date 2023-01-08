module App = {
  @react.component
  let make = () => {
    let {appContext} = ReactRedux.useSelector(store => store.app)
    switch appContext {
    | MerchantView(merchantId) => <MerchantScreen merchantId />
    | PSSView(merchantDetails) => <MerchantTracker merchantDetails />
    | EmployeeView(employeeId) => <EmployeeScreen employeeId />
    }
  }
}
open MaterialUICore

@react.component
let make = () => {
  <Button color=#warning> {"SignUp"->React.string} </Button>
}

// let onChange = ev => {
//   let val = ReactEvent.Form.target(ev)["value"]
//   setMerchantId(_ => val)
// }

// let onSubmit = ev => {
//   setIsMerchant(_ => true)
//   // AppSlice.setAppContext(. MerchantView("rudra"))->dispatch
//   ev->ReactEvent.Form.preventDefault
//   AppSlice.setUser(. {
//     ...Default.user,
//     context: context,
//     merchantId: merchantId,
//   })->dispatch
// }
