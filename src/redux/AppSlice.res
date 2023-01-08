open Types
open! ReactRedux

type reducers = {
  setUser: (appState, payloadAction<user>) => unit,
  setAppContext: (appState, payloadAction<appContext>) => unit,
  showPopup: (appState, payloadAction<unit>) => unit,
  hidePopup: (appState, payloadAction<unit>) => unit,
  switchTheme: (appState, payloadAction<unit>) => unit,
}

type appSliceActions = {
  setUser: action<user>,
  setAppContext: action<appContext>,
  showPopup: (. unit) => actionType,
  hidePopup: (. unit) => actionType,
  switchTheme: (. unit) => actionType,
}

let createSliceArg: createSliceArg<appState, reducers> = {
  name: "AppState",
  initialState: {
    user: Default.user,
    appContext: MerchantView("RUDRA Pvt Ltd"),
    isPopupOpen: false,
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
    showPopup: (state, _action: payloadAction<unit>) => {
      state.isPopupOpen = true
    },
    hidePopup: (state, _action: payloadAction<unit>) => {
      state.isPopupOpen = false
    },
    switchTheme: (state, _action: payloadAction<unit>) => {
      state.isLightTheme = !state.isLightTheme
    },
  },
}

let appSlice = createSlice(createSliceArg)

let {setUser, setAppContext, showPopup, hidePopup, switchTheme} = appSlice.actions

let default = appSlice.reducer
