// type snackBarVariant = [#default | #info | #success | #warning | #error]
// type verticalPosition = [#top | #bottom]
// type horizontalPosition = [#left | #center | #right]

// type snackBarPosition = {
//   vertical: verticalPosition,
//   horizontal: horizontalPosition,
// }
// type snackBarMeta = {
//   variant: snackBarVariant,
//   anchorOrigin: snackBarPosition,
// }
// type notiStack = {
//   enqueueSnackbar: (string, snackBarMeta) => unit,
//   closeSnackbar: string => unit,
// }

// @module("notistack")
// external useSnackbarOrig: unit => notiStack = "useSnackbar"

// let useSnackbar = () => {
//   let {enqueueSnackbar} = useSnackbarOrig()
//   let newEnqueueSnackbar = (
//     message,
//     ~variant: snackBarVariant=#default,
//     ~verticalPosition: verticalPosition=#bottom,
//     ~horizontalPosition: horizontalPosition=#left,
//     (),
//   ) => {
//     let anchorOrigin = {
//       vertical: verticalPosition,
//       horizontal: horizontalPosition,
//     }
//     enqueueSnackbar(message, {variant: variant, anchorOrigin: anchorOrigin})
//   }

//   newEnqueueSnackbar
// }

// let useSnackbarCloser = () => {
//   let {closeSnackbar} = useSnackbarOrig()
//   closeSnackbar
// }

// module Action = {
//   @react.component
//   let make = (~notificationKey) => {
//     let closeSnackbar = useSnackbarCloser()
//     let onClickDismiss = _ev => {
//       closeSnackbar(notificationKey)
//     }
//     <MaterialUICore.Button
//       onClick=onClickDismiss className="bg-none border-none text-[rgba(241,241,241,1)]">
//       <Icons.CloseIcon className="fill-current" />
//     </MaterialUICore.Button>
//   }
// }

// module SnackbarProvider = {
//   @module("notistack") @react.component
//   external make: (
//     ~maxSnack: int,
//     ~action: string => React.element,
//     ~children: React.element,
//   ) => React.element = "SnackbarProvider"
// }

