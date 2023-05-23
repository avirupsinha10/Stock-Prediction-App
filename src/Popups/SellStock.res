open MaterialUICore
@react.component
let make = (
  ~isPopupOpen: bool,
  ~setPopupVisibility: (bool => bool) => unit,
  ~stockData: Types.stockData,
  ~setStockArray: (array<Types.stockUI> => array<Types.stockUI>) => unit,
  ~stockArray: array<Types.stockUI>,
) => {
  // let dispatch = ReactRedux.useDispatch()
  let onChange = (values: Js.Json.t, _) => {
    let stockAmt = values->Parser.getStringFromJson("amount")
    let amt = stockAmt->Utils.stringToFloat->Belt.Int.fromFloat
    let singleStockAmt = stockData.price->Utils.stringToFloat->Belt.Int.fromFloat
    let totalAmt = amt * singleStockAmt
    // setStockArray(_ => [
    //   {
    //     stockName: stockData.name,
    //     stockAmount: totalAmt,
    //   },
    // ])
    setStockArray(_ =>
      stockArray->Js.Array2.concat([{stockName: stockData.name, stockAmount: totalAmt}])
    )
    setPopupVisibility(_ => false)
    Js.Nullable.null->Promise.resolve
  }
  let {isLightTheme} = ReactRedux.useSelector(store => store.app)
  isPopupOpen
    ? <Modal id="popupData.id" \"open"=isPopupOpen onClose={ev => setPopupVisibility(_ => false)}>
        <Card
          className={`p-5 absolute bottom-1/4 left-1/4 w-1/2 h-[300px] flex flex-col items-center justify-center ${isLightTheme
              ? "bg-white"
              : "bg-[rgba(33,36,38,1)] text-[rgba(249,246,246,0.6)]"}`}>
          <span id="{popupDat-label"> {React.string(` Sell Stocks of ${stockData.name} `)} </span>
          <Icons.CloseIcon
            id="popupData.id"
            className="absolute right-[5%] top-[25px] cursor-pointer fill-current text-black/[0.87]"
            onClick={_ev => setPopupVisibility(_ => false)}
          />
          <hr />
          <div className="flex flex-col h-screen items-center">
            <ReactFinalForm.Form
              subscription=ReactFinalForm.subscribeToValues
              onSubmit=onChange
              initialValues=Js.Json.null
              render={({handleSubmit, form, _}) => {
                <form onSubmit={handleSubmit}>
                  <div className="flex flex-col">
                    <div
                      className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
                      id="id">
                      {React.string("No of Stocks ")}
                      <ReactFinalForm.Field
                        name="amount"
                        render={({input}) => {
                          <input
                            id="-input"
                            className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
                                ? "bg-white"
                                : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
                            placeholder="Enter No of Stocks"
                            value={input.value->Parser.jsonToString}
                            onChange=input.onChange
                            required=true
                          />
                        }}
                      />
                    </div>
                    <div className="flex justify-around">
                      <button
                        type_="button"
                        onClick={_ev => form.reset(Js.Nullable.return(Js.Json.null))}
                        className="border-2 rounded p-[5px] cursor-pointer border-black">
                        {"Reset"->React.string}
                      </button>
                      <input
                        id="-submit"
                        type_="submit"
                        value="Sell"
                        className="border-2 rounded p-[5px] cursor-pointer border-black"
                      />
                    </div>
                  </div>
                </form>
              }}
            />
          </div>
        </Card>
      </Modal>
    : React.null
}
