// let usePopupContext = () => {
//   let {isLightTheme} = ReactRedux.useSelector(store => store.app)
//   let setPopupContextData = React.useContext(PopupProvider.popupContext)
//   let dispatch = ReactRedux.useDispatch()
//   let enqueueSnackbar = NotiStack.useSnackbar()
//   let replicateTemplateFlow = ApiUtils.useApiCall(
//     ApiHandler.replicateTemplateFlow,
//     "Replicate Template Flow",
//   )

//   let replicateTemplateFlowContext: UiTypes.popupContext = {
//     id: "replicate-template-flow",
//     onSubmit: values => {
//       replicateTemplateFlow(
//         ~payload=values,
//         ~onStart=() => {
//           AppSlice.setToastMessage(. "Replicating Template Flow")->dispatch
//           AppSlice.showToast(.)->dispatch
//         },
//         ~onSuccess=templateScopeId => {
//           FlowSlice.setTemplateScopeId(. templateScopeId)->dispatch
//           AppSlice.hideToast(.)->dispatch
//           enqueueSnackbar("Replicated Succesfully", ~variant=#success, ())
//           getTemplateFlow(
//             ~templateScopeId,
//             ~onStartMessage="Updating Template Flow",
//             ~onSuccessMessage="Updated Template Flow successfully...",
//             ~onFailureMessage="Failed to Update Template Flow...",
//             ~onClose={_ => AppSlice.hidePopup(.)->dispatch},
//             (),
//           )
//         },
//         ~onFailure=_ => {
//           AppSlice.hideToast(.)->dispatch
//           enqueueSnackbar("Failed to Replicate", ~variant=#error, ())
//         },
//         (),
//       )
//       if !isTemplateFlowMode {
//         AppSlice.toggleTemplateFlowMode(.)->dispatch
//       }
//     },
//     titleText: "Replicate TemplateScopeFlow",
//     showCloseButton: true,
//     initialJson: Js.Json.null,
//     inputFields: [
//       {
//         key: "template_scope_id",
//         fieldType: #TextInput({"required": true}),
//         id: "template-scope-id",
//         label: "Enter Template Scope Id:",
//         placeholderText: "Enter Template Scope Id",
//       },
//       {
//         key: "new_template_scope_name",
//         fieldType: #TextInput({"required": true}),
//         id: "new-template-scope-name",
//         label: "Enter New Template Scope Name:",
//         placeholderText: "Enter New Template Scope Name",
//       },
//       {
//         key: "new_template_flow_name",
//         fieldType: #TextInput({"required": true}),
//         id: "new-template-flow-name",
//         label: "Enter New Template Flow Name:",
//         placeholderText: "Enter New Template Flow Name",
//       },
//     ],
//     outputFields: [],
//     className: `p-5 absolute bottom-1/2 left-1/4 w-1/2 h-[300px] flex flex-col items-center justify-center ${isLightTheme
//         ? "bg-white"
//         : "bg-[rgba(33,36,38,1)] text-[rgba(249,246,246,0.6)]"}`,
//     showResetButton: false,
//     onVerify: None,
//   }

//   () => {
//     replicateTemplateFlowContext->setPopupContextData
//     AppSlice.showPopup(.)->dispatch
//   }
// }

