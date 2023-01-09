open Types
open! ReactRedux

type reducers = {
  setUser: (appState, payloadAction<user>) => unit,
  setAppContext: (appState, payloadAction<appContext>) => unit,
  showToast: (appState, payloadAction<unit>) => unit,
  hideToast: (appState, payloadAction<unit>) => unit,
  setToastMessage: (appState, payloadAction<string>) => unit,
  switchTheme: (appState, payloadAction<unit>) => unit,
}

type appSliceActions = {
  setUser: action<user>,
  setAppContext: action<appContext>,
  showToast: (. unit) => actionType,
  hideToast: (. unit) => actionType,
  setToastMessage: action<string>,
  switchTheme: (. unit) => actionType,
}

let createSliceArg: createSliceArg<appState, reducers> = {
  name: "AppState",
  initialState: {
    user: Default.user,
    appContext: MerchantView("RUDRA Pvt Ltd"),
    isToastOpen: false,
    toastMessage: "",
    isLightTheme: true,
  },
  reducers: {
    setUser: (state, action: payloadAction<user>) => {
      state.user = action.payload
      LocalDB.storeUserDetails(~userDetails=state.user)
    },
    setAppContext: (state, action: payloadAction<appContext>) => {
      state.appContext = action.payload
    },
    showToast: (state, _action: payloadAction<unit>) => {
      state.isToastOpen = true
    },
    hideToast: (state, _action: payloadAction<unit>) => {
      state.isToastOpen = false
    },
    setToastMessage: (state, action: payloadAction<string>) => {
      state.toastMessage = action.payload
    },
    switchTheme: (state, _action: payloadAction<unit>) => {
      state.isLightTheme = !state.isLightTheme
    },
  },
}

let appSlice = createSlice(createSliceArg)

let {setUser, setAppContext, switchTheme, showToast, hideToast, setToastMessage} = appSlice.actions

let default = appSlice.reducer
