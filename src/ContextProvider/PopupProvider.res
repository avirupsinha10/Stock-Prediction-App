let defaultValue = _ => ()
let popupContext = React.createContext(defaultValue)

module PopupProvider = {
  let makeProps = (~value, ~children, ()) =>
    {
      "value": value,
      "children": children,
    }
  let make = React.Context.provider(popupContext)
}

@react.component
let make = (~children: React.element, ~isPopupOpen: bool) => {
  let dispatch = ReactRedux.useDispatch()
  let (popupData, setPopupData) = React.useState(_ => Default.popupContext)

  let onChange = (values: Js.Json.t, _) => {
    popupData.onSubmit(values)
    Js.Nullable.null->Promise.resolve
  }

  open MaterialUICore
  <PopupProvider value={data => setPopupData(_ => data)}>
    children
    {isPopupOpen
      ? <Modal id=popupData.id \"open"=true onClose={() => AppSlice.hidePopup(.)->dispatch}>
          <Card className=popupData.className>
            <span id={popupData.id ++ "-label"}> {React.string(popupData.titleText)} </span>
            // {popupData.showCloseButton
            //   ? <Icons.CloseIcon
            //       id=popupData.id
            //       className="absolute right-[5%] top-[25px] cursor-pointer fill-current text-black/[0.87]"
            //       onClick={_ev => AppSlice.hidePopup(.)->dispatch}
            //     />
            //   : React.null}
            <div className="flex flex-col h-screen items-center">
              <ReactFinalForm.Form
                subscription=ReactFinalForm.subscribeToValues
                onSubmit=onChange
                initialValues=popupData.initialJson
                render={({handleSubmit, form, values}) => {
                  <form onSubmit={handleSubmit}>
                    <div className="flex flex-col">
                      {popupData.inputFields
                      ->Js.Array2.mapi((field, i) =>
                        <PopupComponents.InputView
                          key={Belt.Int.toString(i)} fieldInputProps=field
                        />
                      )
                      ->React.array}
                      <div className="flex justify-around">
                        {popupData.showResetButton
                          ? <button
                              type_="button"
                              onClick={_ev => form.reset(Js.Nullable.return(popupData.initialJson))}
                              className="border-2 rounded p-[5px] cursor-pointer border-black">
                              {"Reset"->React.string}
                            </button>
                          : React.null}
                        <input
                          id={popupData.id ++ "-submit"}
                          type_="submit"
                          value="Submit"
                          className="border-2 rounded p-[5px] cursor-pointer border-black"
                        />
                      </div>
                    </div>
                  </form>
                }}
              />
              {popupData.outputFields
              ->Js.Array2.mapi((field, i) => {
                <PopupComponents.OutputView key={Belt.Int.toString(i)} fieldInputProps=field />
              })
              ->React.array}
            </div>
          </Card>
        </Modal>
      : React.null}
  </PopupProvider>
}
