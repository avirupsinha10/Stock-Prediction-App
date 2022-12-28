module App = {
  @react.component
  let make = () => {
    let {appContext} = ReactRedux.useSelector(store => store.app)
    switch appContext {
    | MerchantView(merchantId) => <MerchantScreen merchantId />
    | PSSView(merchantDetails) => <MerchantTracker merchantDetails />
    }
  }
}

@react.component
let make = () => {
  let (isMerchant, setIsMerchant) = React.useState(_ => false)
  let (context, setContext) = React.useState(_ => "")
  let (merchantId, setMerchantId) = React.useState(_ => "")
  let dispatch = ReactRedux.useDispatch()
  let onChange = ev => {
    let val = ReactEvent.Form.target(ev)["value"]
    setMerchantId(_ => val)
  }

  let onSubmit = ev => {
    setIsMerchant(_ => true)
    // AppSlice.setAppContext(. MerchantView("rudra"))->dispatch
    ev->ReactEvent.Form.preventDefault
    AppSlice.setUser(. {
      ...Default.user,
      context: context,
      merchantId: merchantId,
    })->dispatch
  }
  <React.Fragment>
    {!isMerchant
      ? <div className="flex flex-col h-screen justify-center items-center">
          <form onSubmit>
            <div className="flex items-center">
              <div
                className="flex flex-col mr-2.5 w-[150px] h-[60px] dark:text-[rgba(246,248,249,0.2)]">
                <div>
                  <input
                    id="pss_user"
                    type_="radio"
                    name="context"
                    onChange={_ev => {
                      setContext(_ => "PSS")
                      setMerchantId(_ => "internal_pss")
                    }}
                  />
                  {React.string("PSS User")}
                </div>
                <div>
                  <input
                    id="merchant_user"
                    type_="radio"
                    name="context"
                    onChange={ev => setContext(_ => "MERCHANT")}
                  />
                  {React.string("Merchant User")}
                </div>
                {if context == "MERCHANT" {
                  <input
                    className="border-[1px] border-black rounded dark:border-[rgba(246,248,249,0.2)] text-black"
                    value=merchantId
                    placeholder="Enter Merchant Id"
                    onChange
                  />
                } else {
                  React.null
                }}
              </div>
              <input
                type_="submit"
                value="Submit"
                disabled={context == "" || (context == "MERCHANT" && merchantId == "")}
                className={`border-2 rounded p-[5px] ${context == "" ||
                    (context == "MERCHANT" && merchantId == "")
                    ? "text-black/50 border-black/50 dark:border-[rgba(246,248,249,0.2)] dark:text-[rgba(246,248,249,0.2)]"
                    : "cursor-pointer border-black dark:border-[rgba(246,248,249,0.5)] dark:text-[rgba(246,248,249,0.5)]"}`}
              />
            </div>
          </form>
        </div>
      : React.null}
    {isMerchant ? <App /> : React.null}
  </React.Fragment>
}
