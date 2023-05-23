// open MaterialUICore
// @react.component
// let make = (~isPopupOpen: bool, ~setPopupVisibility: (bool => bool) => unit) => {
//   let registerUser = ApiUtils.useApiCall(ApiHandler.registerUser, "Register User")
//   let dispatch = ReactRedux.useDispatch()
//   let onChange = (values: Js.Json.t, _) => {
//     Js.log2("<<>>", values)
//     registerUser(
//       ~payload=values,
//       ~onStart=() => {
//         AppSlice.setToastMessage(. "Registering User... Please Wait")->dispatch
//         AppSlice.showToast(.)->dispatch
//       },
//       ~onSuccess=user => {
//         AppSlice.hideToast(.)->dispatch
//         // enqueueSnackbar("Registered Succesfully", ~variant=#success, ())
//         switch user.context {
//         | #INTERNAL => AppSlice.setAppContext(. PSSView([]))->dispatch
//         | #EMPLOYEE => AppSlice.setAppContext(. EmployeeView(""))->dispatch
//         | #MERCHANT => AppSlice.setAppContext(. MerchantView(""))->dispatch
//         }
//       },
//       ~onFailure=_ => {
//         AppSlice.hideToast(.)->dispatch
//         // enqueueSnackbar("Failed to Replicate", ~variant=#error, ())
//       },
//       (),
//     )
//     Js.Nullable.null->Promise.resolve
//   }
//   let {isLightTheme} = ReactRedux.useSelector(store => store.app)
//   isPopupOpen
//     ? <Modal id="popupData.id" \"open"=isPopupOpen onClose={ev => setPopupVisibility(_ => false)}>
//         <Card
//           className={`p-5 absolute bottom-1/4 left-1/4 w-1/2 h-[400px] flex flex-col items-center justify-center ${isLightTheme
//               ? "bg-white"
//               : "bg-[rgba(33,36,38,1)] text-[rgba(249,246,246,0.6)]"}`}>
//           <span id="{popupDat-label"> {React.string(" Register User ")} </span>
//           <Icons.CloseIcon
//             id="popupData.id"
//             className="absolute right-[5%] top-[25px] cursor-pointer fill-current text-black/[0.87]"
//             onClick={_ev => setPopupVisibility(_ => false)}
//           />
//           <div className="flex flex-col h-screen items-center">
//             <ReactFinalForm.Form
//               subscription=ReactFinalForm.subscribeToValues
//               onSubmit=onChange
//               initialValues=Js.Json.null
//               render={({handleSubmit, form, _}) => {
//                 <form onSubmit={handleSubmit}>
//                   <div className="flex flex-col">
//                     <div
//                       className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
//                       id="id">
//                       {React.string("username:")}
//                       <ReactFinalForm.Field
//                         name="username"
//                         render={({input}) => {
//                           <input
//                             id="-input"
//                             className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
//                                 ? "bg-white"
//                                 : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
//                             placeholder="Enter User Name"
//                             value={input.value->Parser.jsonToString}
//                             onChange=input.onChange
//                             required=true
//                           />
//                         }}
//                       />
//                     </div>
//                     <div
//                       className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
//                       id="id">
//                       {React.string("email:")}
//                       <ReactFinalForm.Field
//                         name="email"
//                         render={({input}) => {
//                           <input
//                             id="-input"
//                             className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
//                                 ? "bg-white"
//                                 : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
//                             placeholder="Enter Email"
//                             value={input.value->Parser.jsonToString}
//                             onChange=input.onChange
//                             required=false
//                           />
//                         }}
//                       />
//                     </div>
//                     <div
//                       className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
//                       id="id">
//                       {React.string("password:")}
//                       <ReactFinalForm.Field
//                         name="password"
//                         render={({input}) => {
//                           <input
//                             id="-input"
//                             className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
//                                 ? "bg-white"
//                                 : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
//                             placeholder="Enter Password"
//                             value={input.value->Parser.jsonToString}
//                             onChange=input.onChange
//                             required=true
//                           />
//                         }}
//                       />
//                     </div>
//                     <div
//                       className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
//                       id="id">
//                       {React.string("Context:")}
//                       <ReactFinalForm.Field
//                         name="type"
//                         render={({input}) => {
//                           <input
//                             id="-input"
//                             className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
//                                 ? "bg-white"
//                                 : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
//                             placeholder="Enter Context"
//                             value={input.value->Parser.jsonToString}
//                             onChange=input.onChange
//                             required=true
//                           />
//                         }}
//                       />
//                     </div>
//                     <div className="flex justify-around">
//                       <button
//                         type_="button"
//                         onClick={_ev => form.reset(Js.Nullable.return(Js.Json.null))}
//                         className="border-2 rounded p-[5px] cursor-pointer border-black">
//                         {"Reset"->React.string}
//                       </button>
//                       <input
//                         id="-submit"
//                         type_="submit"
//                         value="Submit"
//                         className="border-2 rounded p-[5px] cursor-pointer border-black"
//                       />
//                     </div>
//                   </div>
//                 </form>
//               }}
//             />
//           </div>
//         </Card>
//       </Modal>
//     : React.null
// }

