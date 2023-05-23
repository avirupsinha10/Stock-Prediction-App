// open MaterialUICore

@react.component
let make = () => {
  let (isRegisterModalOpen, setRegisterModalVisibility) = React.useState(_ => false)
  let (isDashboardPageOpen, setIsDashboardPageOpen) = React.useState(_ => false)
  let (username, setUsername) = React.useState(_ => "")
  let (name, setName) = React.useState(_ => "")
  let (password, setPassword) = React.useState(_ => "")
  let (email, setEmail) = React.useState(_ => "")
  let loginUser = ApiUtils.useApiCall(ApiHandler.loginUser, "Login User")
  let registerUser = ApiUtils.useApiCall(ApiHandler.registerUser, "Register User")
  let dispatch = ReactRedux.useDispatch()
  <>
    <div
      className="w-screen h-screen flex flex-row dark:bg-[rgba(15,16,17,1)] dark:text-white"
      onClick={(event: ReactEvent.Mouse.t) => {
        event->ReactEvent.Mouse.stopPropagation
      }}>
      <div className="w-[60%] bg-blue-500 justify-center">
        <div className="flex flex-col items-center">
          <div
            className="p-2 font-sans not-italic font-bold text-[80px] leading-[28px] mr-[180px] text-white mt-[450px]">
            {"GoFinance"->React.string}
          </div>
          <div className="flex flex-row">
            <div
              className="mt-[30px] gap-2 font-sans not-italic font-bold text-[18px] leading-[28px] ml-[120px] text-white">
              {"The most popular peer to peer"->React.string}
            </div>
            <div
              className="mt-[30px] ml-[10px] font-sans not-italic font-bold text-[50px] leading-[28px] text-[rgba(211,211,211,1)]">
              {"Investment App"->React.string}
            </div>
          </div>
        </div>
      </div>
      <div className="w-[40%] justify-center">
        {isRegisterModalOpen
          ? <div className="flex flex-col items-center mt-[350px]">
              <div className="font-sans not-italic font-bold text-[30px] leading-[28px]">
                {"Create Account"->React.string}
              </div>
              <div className="mt-4 font-sans not-italic text-[20px] leading-[28px]">
                {"Lets Start Investing"->React.string}
              </div>
              <input
                id="name"
                value=name
                onChange={event => setName(_ => {event->ReactEvent.Form.target}["value"])}
                placeholder="Name"
                className="mt-4 border border-gray-300 rounded-md p-2 mb-4"
              />
              <input
                id="username"
                placeholder="Username"
                value=username
                onChange={event => setUsername(_ => {event->ReactEvent.Form.target}["value"])}
                className="border border-gray-300 p-2 mb-4 rounded-md"
              />
              <input
                id="email"
                value=email
                onChange={event => setEmail(_ => {event->ReactEvent.Form.target}["value"])}
                placeholder="Email"
                className="border border-gray-300 rounded-md p-2 mb-4"
              />
              <input
                type_="password"
                id="password"
                value=password
                onChange={event => setPassword(_ => {event->ReactEvent.Form.target}["value"])}
                placeholder="Password"
                className="border border-gray-300 rounded-md p-2 mb-4"
              />
              <button
                className="bg-blue-500 text-white rounded-md py-2 px-4"
                onClick={_ev => {
                  registerUser(
                    ~payload=[
                      ("username", username->Js.Json.string),
                      ("name", name->Js.Json.string),
                      ("email", email->Js.Json.string),
                      ("password", password->Js.Json.string),
                    ]
                    ->Js.Dict.fromArray
                    ->Js.Json.object_,
                    ~onStart=() => {
                      ()
                    },
                    ~onSuccess=user => {
                      AppSlice.setUser(. user)->dispatch
                      setIsDashboardPageOpen(_ => true)
                    },
                    ~onFailure=_ => {
                      ()
                    },
                    ~beforeResolve=() => {()},
                    (),
                  )
                }}>
                {"Submit"->React.string}
              </button>
              <div className="mt-2">
                {"Already have an account?"->React.string}
                <a
                  className="ml-2 cursor-pointer hover:underline"
                  onClick={_ev => setRegisterModalVisibility(_ => false)}>
                  {"Sign In"->React.string}
                </a>
              </div>
            </div>
          : <div className="flex flex-col items-center mt-[350px]">
              <div className="font-sans not-italic font-bold text-[30px] leading-[28px]">
                {"Hello Again!"->React.string}
              </div>
              <div className="mt-4 font-sans not-italic text-[20px] leading-[28px]">
                {"Welcome Back"->React.string}
              </div>
              <input
                id="username"
                placeholder="Username"
                value=username
                onChange={event => setUsername(_ => {event->ReactEvent.Form.target}["value"])}
                className="mt-4 border border-gray-300 rounded-md p-2 mb-4"
              />
              <input
                type_="password"
                id="password"
                placeholder="Password"
                value=password
                onChange={event => setPassword(_ => {event->ReactEvent.Form.target}["value"])}
                className="border border-gray-300 rounded-md p-2 mb-4"
              />
              <button
                className="bg-blue-500 text-white rounded-md py-2 px-4"
                onClick={_ev => {
                  loginUser(
                    ~payload=[
                      ("username", username->Js.Json.string),
                      ("password", password->Js.Json.string),
                    ]
                    ->Js.Dict.fromArray
                    ->Js.Json.object_,
                    ~onStart=() => {
                      ()
                    },
                    ~onSuccess=user => {
                      AppSlice.setUser(. user)->dispatch
                      Js.log(user)
                      setIsDashboardPageOpen(_ => true)
                      // setIsUserLoggedIn(_ => true)
                    },
                    ~onFailure=_ => {
                      ()
                    },
                    ~beforeResolve=() => {()},
                    (),
                  )
                }}>
                {"Submit"->React.string}
              </button>
              <div className="mt-2">
                {"Dont have an account?"->React.string}
                <a
                  className="ml-2 cursor-pointer hover:underline"
                  onClick={_ev => setRegisterModalVisibility(_ => true)}>
                  {"Sign Up"->React.string}
                </a>
              </div>
            </div>}
      </div>
    </div>
    <StockDash isDashboardPageOpen setIsDashboardPageOpen />
  </>
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
