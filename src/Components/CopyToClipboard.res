open Promise
@react.component
let make = (~content: string) => {
  // let enqueueSnackbar = NotiStack.useSnackbar()
  let onCopy = _ => {
    Utils.writeToClipboard(content)->thenResolve(_ => ())->catch(_ => ()->resolve)->ignore
  }

  <Icons.Copy
    className="cursor-pointer ml-4 text-[rgba(21,133,216,1)] dark:text-[rgba(15,159,255,1)] fill-current"
    onClick={_ => onCopy(content)}
  />
}
