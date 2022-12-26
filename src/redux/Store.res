type reducer = {app: ReactRedux.sliceReducer}

type configStore = {reducer: reducer}

@module("@reduxjs/toolkit")
external configureStore: configStore => ReactRedux.enhancedStore = "configureStore"

let store = configureStore({
  reducer: {
    app: AppSlice.default,
  },
})

let default = store
