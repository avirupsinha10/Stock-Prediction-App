module App = {
  @react.component
  let make = () => {
    let {appContext, isToastOpen, toastMessage} = ReactRedux.useSelector(store => store.app)
    <>
      {switch appContext {
      | MerchantView(merchantId) => <MerchantScreen merchantId />
      | PSSView(merchantDetails) => <MerchantTracker merchantDetails />
      | EmployeeView(employeeId) => <EmployeeScreen employeeId />
      }}
      {if isToastOpen {
        <FloatingToast toastContent=toastMessage />
      } else {
        React.null
      }}
    </>
  }
}
open MaterialUICore

@react.component
let make = () => {
  let (isRegisterPopupOpen, setRegisterPopupVisibility) = React.useState(_ => false)
  let (isLoginPopupOpen, setLoginPopupVisibility) = React.useState(_ => false)
  <div className="flex flex-col h-screen items-center justify-center">
    <div className="flex items-center">
      <div className="flex flex-col mr-2.5 w-[150px] h-[60px] dark:text-[rgba(246,248,249,0.2)]">
        <Button color=#primary onClick={ev => setRegisterPopupVisibility(_ => true)}>
          {"SignUp"->React.string}
        </Button>
        <RegisterUser
          isPopupOpen=isRegisterPopupOpen setPopupVisibility=setRegisterPopupVisibility
        />
        <Button color=#primary onClick={ev => setLoginPopupVisibility(_ => true)}>
          {"Login"->React.string}
        </Button>
        <LoginUser isPopupOpen=isLoginPopupOpen setPopupVisibility=setLoginPopupVisibility />
      </div>
    </div>
  </div>
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
