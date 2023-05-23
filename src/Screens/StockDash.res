@react.component
let make = (~isDashboardPageOpen: bool, ~setIsDashboardPageOpen: (bool => bool) => unit) => {
  let {user} = ReactRedux.useSelector(store => store.app)
  let companyArr = ["AAPL", "MSFT", "TSLA", "IBM"]
  let (companyName, setCompanyName) = React.useState(_ => companyArr[0])
  let (searchQuery, setSearchQuery) = React.useState(_ => "")
  let (stockData, setStockData) = React.useState(_ => Default.stockData)
  let predictStock = ApiUtils.useApiCall(ApiHandler.predictStock, "Predict Stock")
  let getStockData = ApiUtils.useApiCall(ApiHandler.fetchStockData, "Fetch Stock Data")
  let (isLogoutOpen, setIsLogoutOpen) = React.useState(_ => false)
  let (isStockOpen, setIsStockOpen) = React.useState(_ => false)
  // let (sum, setSum) = React.useState(_ => 0)

  let (isBuyStockPopupOpen, setIsBuyStockPopupOpen) = React.useState(_ => false)
  let (isSellStockPopupOpen, setIsSellStockPopupOpen) = React.useState(_ => false)
  let (stockArray, setStockArray) = React.useState(_ => [])

  let sum = ref(0)
  let _sumArray = (array: array<int>) => {
    array->Js.Array2.map(ele => sum.contents + ele)->ignore
    sum.contents
  }

  let getStockName = (uid: string) => {
    switch uid {
    | "AAPL" => "Apple"
    | "MSFT" => "Microsoft"
    | "TSLA" => "Tesla"
    | "IBM" => "IBM"
    | _ => ""
    }
  }
  let toggleDropdown = () => setIsLogoutOpen(_ => !isLogoutOpen)

  let handleLogout = () => setIsDashboardPageOpen(_ => false)

  let getCompanyIcon = (name: string) => {
    switch name {
    | "AAPL" => <Icons.Apple />
    | "MSFT" => <Icons.Microsoft />
    | "TSLA" => <Icons.Tesla />
    | "IBM" => <Icons.IBM />
    | _ => React.null
    }
  }

  React.useEffect1(() => {
    setIsLogoutOpen(_ => false)
    None
  }, [isDashboardPageOpen])

  if isDashboardPageOpen {
    <>
      <div
        className={`h-screen w-screen bg-white dark:bg-[rgba(0,0,0,0.6)] top-0 right-0 absolute flex flex-col`}>
        <div onClick={(event: ReactEvent.Mouse.t) => event->ReactEvent.Mouse.stopPropagation}>
          <div id="navbar" className="flex flex-row bg-gray-50">
            <div
              className="ml-10 mt-[24px] font-mono not-italic font-bold text-[25px] leading-[20px] items-center">
              {"Dashboard"->React.string}
            </div>
            <SearchInput
              id="merchant-search-box"
              inputText=searchQuery
              placeholder="Search a Company"
              onChange={value => {
                setSearchQuery(_ => value)
              }}
            />
            <button
              className="bg-blue-500 text-white rounded-md p-2 ml-4 my-4"
              onClick={_ev => {
                predictStock(
                  ~payload=[("stock_name", searchQuery->Js.Json.string)]
                  ->Js.Dict.fromArray
                  ->Js.Json.object_,
                  ~onStart=() => {
                    ()
                    // snackbar for graph displayed
                    // setCompanyName(_ => searchQuery)
                  },
                  ~onSuccess=predicted => {
                    Js.log(predicted)
                  },
                  ~onFailure=_ => {
                    ()
                  },
                  ~beforeResolve=() => {()},
                  (),
                )
              }}>
              {"Predict Future Prices"->React.string}
            </button>
            <div className="ml-[800px] mt-5 flex flex-row">
              <Icons.User className="mr-4" />
              <span className="font-sans not-italic font-bold text-[18px] leading-[22px] ml-4">
                {user.name->React.string}
              </span>
              <svg
                className="h-6 w-6 cursor-pointer ml-4"
                onClick={_ev => toggleDropdown()}
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor">
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={"2"}
                  d="M4 6h16M4 12h16m-7 6h7"
                />
              </svg>
              {isLogoutOpen
                ? <div
                    className="bg-red-500 mx-3 mt-1 w-fit h-fit rounded-md shadow-lg z-40 items-center">
                    <button
                      className="px-2 py-2 text-sm text-white w-full text-left"
                      onClick={_ev => handleLogout()}>
                      {"Logout"->React.string}
                    </button>
                  </div>
                : React.null}
            </div>
          </div>
          <hr />
          <div className="flex flex-row">
            <div className="w-[75%]">
              <div className="flex flex-row mt-8 ml-14">
                <div
                  className="text-[rgba(143,0,255,0.5)] font-sans not-italic font-bold text-[15px] leading-[28px] flex flex-row items-center">
                  {"DASHBOARD"->React.string}
                </div>
                <div
                  className="ml-4 text-[rgba(128,128,128,1)] font-sans not-italic text-[15px] font-bold leading-[28px] flex flex-row items-center">
                  {">"->React.string}
                </div>
                <div
                  className="ml-3 text-[rgba(128,128,128,1)] font-sans not-italic text-[15px] font-bold leading-[28px] flex flex-row items-center">
                  {"TODAY"->React.string}
                </div>
              </div>
              <div className="ml-10 mt-10 flex flex-col justify-center items-center">
                <div className="font-sans not-italic font-bold text-[50px] leading-[28px]">
                  {"Search Stocks to Buy!"->React.string}
                </div>
                <DropDown
                  className="mt-8 h-4"
                  options=companyArr
                  value={companyName}
                  onChange={company => {setCompanyName(_ => company)}}
                />
                <button
                  className="mt-10 bg-blue-500 text-white rounded-md p-2 my-4"
                  onClick={_ev => {
                    getStockData(
                      ~payload=[("company_name", companyName->Js.Json.string)]
                      ->Js.Dict.fromArray
                      ->Js.Json.object_,
                      ~onStart=() => {
                        ()
                        // snackbar for graph displayed
                        // setCompanyName(_ => searchQuery)
                      },
                      ~onSuccess=stock => {
                        setStockData(_ => stock)
                        setIsStockOpen(_ => true)
                        Js.log(stock)
                      },
                      ~onFailure=_ => {
                        ()
                      },
                      ~beforeResolve=() => {()},
                      (),
                    )
                  }}>
                  {"Get Stock Info"->React.string}
                </button>
                <div> {getCompanyIcon(stockData.name)} </div>
                {if isStockOpen {
                  <>
                    <div
                      className="border-2 border-solid rounded-md flex flex-col p-4 dark:bg-[rgba(44,45,47,0.5)] dark:border-[rgba(246,248,249,0.1)]">
                      <div
                        className="flex items-center font-mono not-italic text-[24px] leading-[16px]">
                        {("Stock Name   : " ++ getStockName(stockData.name))->React.string}
                        <CopyToClipboard content=stockData.name />
                      </div>
                      <div
                        className="flex items-center mt-8 font-mono not-italic text-[24px] leading-[16px]">
                        {("Stock Price  : " ++ stockData.price)->React.string}
                        <CopyToClipboard content=stockData.price />
                      </div>
                      <div
                        className="flex items-center mt-8 font-mono not-italic text-[24px] leading-[16px]">
                        {("Stock Volume : " ++ stockData.volume)->React.string}
                        <CopyToClipboard content=stockData.volume />
                      </div>
                      <div
                        className="flex items-center mt-8 font-mono not-italic text-[24px] leading-[16px]">
                        {("TimeStamp    : " ++ stockData.timestamp)->React.string}
                        <CopyToClipboard content=stockData.timestamp />
                      </div>
                    </div>
                    <div className="flex flex-row gap-4">
                      <button
                        className="mt-10 bg-green-500 text-white rounded-md p-2 my-4"
                        onClick={_ev => {
                          setIsBuyStockPopupOpen(_ => true)
                        }}>
                        {"Buy Stocks"->React.string}
                      </button>
                      <button
                        className="mt-10 bg-yellow-500 text-white rounded-md p-2 my-4"
                        onClick={_ev => {
                          setIsSellStockPopupOpen(_ => true)
                        }}>
                        {"Sell Stocks"->React.string}
                      </button>
                    </div>
                  </>
                } else {
                  React.null
                }}
              </div>
              // <div
              //   id="graph-section"
              //   className="mt-10 font-sans not-italic font-bold text-[50px] leading-[28px] items-center">
              //   {"GRAPH"->React.string}
              // </div>
            </div>
            <div
              className="w-[25%] bg-[rgba(207,159,255,0.1)] flex flex-col px-14 pt-14 pb-[482px] gap-4">
              <div
                className="font-sans not-italic text-[20px] leading-[28px] flex flex-row items-center">
                {"Invested STOCK's"->React.string} <Icons.InfoIcon className="fill-current ml-2" />
              </div>
              <input
                id="name"
                disabled=true
                value={(stockArray: array<Types.stockUI>)
                ->Js.Array2.map(ele => ele.stockName ++ " , ")
                ->Js.Json.stringifyAny
                ->Belt.Option.getWithDefault("")}
                // onChange={event => setName(_ => {event->ReactEvent.Form.target}["value"])}
                // placeholder="Invested Amount"
                className="mt-4 border border-gray-300 rounded-md p-2 mb-4"
              />
              <div
                className="font-sans not-italic text-[20px] leading-[28px] flex flex-row items-center">
                {"Invested Amount"->React.string} <Icons.InfoIcon className="fill-current ml-2" />
              </div>
              <input
                id="name"
                value={stockArray
                ->Js.Array2.map(ele => ele.stockAmount)
                ->Js.Json.stringifyAny
                ->Belt.Option.getWithDefault("")}
                disabled=true
                // onChange={event => setName(_ => {event->ReactEvent.Form.target}["value"])}
                // placeholder="Current Amount"
                className="mt-4 border border-gray-300 rounded-md p-2 mb-4"
              />
              //No app in this world will predict returns in a product approach
              <div
                className="font-sans not-italic text-[20px] leading-[28px] flex flex-row items-center">
                {"Total Amount Invested"->React.string}
                <Icons.InfoIcon className="fill-current ml-2" />
              </div>
              <input
                id="name"
                disabled=true
                value={stockArray
                ->Js.Array2.map(ele => ele.stockAmount)
                ->Js.Json.stringifyAny
                ->Belt.Option.getWithDefault("")}
                // value={stockArray
                // ->Js.Array2.map(ele => ele.stockAmount)
                // ->sumArray
                // ->Belt.Int.toString}
                // onChange={event => setName(_ => {event->ReactEvent.Form.target}["value"])}
                className="mt-4 border border-gray-300 rounded-md p-2 mb-4"
              />
            </div>
          </div>
        </div>
      </div>
      <BuyStock
        isPopupOpen=isBuyStockPopupOpen
        setPopupVisibility=setIsBuyStockPopupOpen
        stockData
        setStockArray
        stockArray
      />
      <SellStock
        isPopupOpen=isSellStockPopupOpen
        setPopupVisibility=setIsSellStockPopupOpen
        stockData
        setStockArray
        stockArray
      />
    </>
  } else {
    React.null
  }
}
