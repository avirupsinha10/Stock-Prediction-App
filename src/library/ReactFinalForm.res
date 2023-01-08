type fieldRenderPropsInput = {
  name: string,
  onBlur: ReactEvent.Focus.t => unit,
  onChange: ReactEvent.Form.t => unit,
  onFocus: ReactEvent.Focus.t => unit,
  value: Js.Json.t,
  checked: bool,
}

type fieldRenderPropsCustomInput<'t> = {
  name: string,
  onBlur: ReactEvent.Focus.t => unit,
  onChange: 't => unit,
  onFocus: ReactEvent.Focus.t => unit,
  value: Js.Json.t,
  checked: bool,
}
external toTypedField: fieldRenderPropsInput => fieldRenderPropsCustomInput<'t> = "%identity"

type fieldRenderPropsMeta = {
  active: bool,
  data: bool,
  dirty: bool,
  dirtySinceLastSubmit: bool,
  error: Js.Nullable.t<string>,
  initial: bool,
  invalid: bool,
  modified: bool,
  modifiedSinceLastSubmit: bool,
  pristine: bool,
  submitError: string,
  submitFailed: bool,
  submitSucceeded: bool,
  submitting: bool,
  touched: bool,
  valid: bool,
  validating: bool,
  visited: bool,
}

let makeCustomError = error => {
  {
    active: true,
    data: true,
    dirty: true,
    dirtySinceLastSubmit: true,
    error: Js.Nullable.fromOption(error),
    initial: true,
    invalid: true,
    modified: true,
    modifiedSinceLastSubmit: true,
    pristine: true,
    submitError: "",
    submitFailed: true,
    submitSucceeded: true,
    submitting: true,
    touched: true,
    valid: true,
    validating: true,
    visited: true,
  }
}

type fieldRenderProps = {
  input: fieldRenderPropsInput,
  meta: fieldRenderPropsMeta,
}

type formValues = Js.Json.t

type submitErrorResponse = {
  responseCode: string,
  responseMessage: string,
  status: string,
}

type formState = {
  dirty: bool,
  submitError: Js.Nullable.t<string>,
  submitErrors: Js.Nullable.t<Js.Json.t>,
  hasValidationErrors: bool,
  hasSubmitErrors: bool,
  submitting: bool,
  values: Js.Json.t,
  errors: Js.Json.t,
  dirtySinceLastSubmit: bool,
}

type unsubscribeFn = unit => unit

type formApi = {
  batch: bool,
  blur: bool,
  change: bool,
  destroyOnUnregister: bool,
  focus: bool,
  getFieldState: bool,
  getRegisteredFields: bool,
  getState: bool,
  initialize: bool,
  isValidationPaused: bool,
  mutators: bool,
  pauseValidation: bool,
  registerField: bool,
  reset: Js.Nullable.t<Js.Json.t> => unit,
  resetFieldState: bool,
  restart: bool,
  resumeValidation: bool,
  submit: bool,
  subscribe: (formState => unit, Js.Json.t) => unsubscribeFn,
}

type formRenderProps = {
  form: formApi,
  values: Js.Json.t,
  handleSubmit: ReactEvent.Form.t => unit,
  submitError: string,
  // handleSubmit: ReactEvent.Form.t => Promise.t<Js.Nullable.t<Js.Json.t>>,
}

@module("final-form")
external formError: string = "FORM_ERROR"

let subscribeToValues = [("values", true)]->Js.Dict.fromArray

let subscribeToPristine = [("pristine", true)]->Js.Dict.fromArray

module Form = {
  @module("react-final-form") @react.component
  external make: (
    ~children: formRenderProps => React.element=?,
    ~component: bool=?,
    ~debug: bool=?,
    ~decorators: bool=?,
    ~form: string=?,
    ~initialValues: Js.Json.t=?,
    ~initialValuesEqual: bool=?,
    ~keepDirtyOnReinitialize: bool=?,
    ~mutators: bool=?,
    ~onSubmit: (formValues, formApi) => Promise.t<Js.Nullable.t<Js.Json.t>>,
    ~render: formRenderProps => React.element=?,
    ~subscription: Js.Dict.t<bool>,
    ~validate: Js.Json.t => Js.Json.t=?,
    ~validateOnBlur: bool=?,
  ) => React.element = "Form"
}
module Field = {
  @module("react-final-form") @react.component
  external make: (
    ~afterSubmit: bool=?,
    ~allowNull: bool=?,
    ~beforeSubmit: bool=?,
    ~children: fieldRenderProps => React.element=?,
    ~component: fieldRenderProps => React.element=?,
    ~data: bool=?,
    ~defaultValue: bool=?,
    ~format: (. ~value: Js.Json.t, ~name: string) => Js.Json.t=?,
    ~formatOnBlur: bool=?,
    ~initialValue: bool=?,
    ~isEqual: bool=?,
    ~multiple: bool=?,
    ~name: string,
    ~parse: (. ~value: Js.Json.t, ~name: string) => Js.Json.t=?,
    ~ref: bool=?,
    ~render: fieldRenderProps => React.element=?,
    ~subscription: bool=?,
    @as("type") ~type_: bool=?,
    ~validate: (string, Js.Json.t) => Js.Nullable.t<string>=?,
    ~validateFields: bool=?,
    ~value: bool=?,
    ~placeholder: string=?,
  ) => React.element = "Field"
}

type formSubscription = Js.Json.t
let useFormSubscription = (keys): formSubscription => {
  React.useMemo0(() => {
    let dict = Js.Dict.empty()
    Js.Array.forEach(key => {
      Js.Dict.set(dict, key, Js.Json.boolean(true))
    }, keys)
    dict->Js.Json.object_
  })
}

module FormSpy = {
  @module("react-final-form") @react.component
  external make: (
    ~children: formState => React.element,
    ~component: bool=?,
    ~onChange: bool=?,
    ~render: formState => React.element=?,
    ~subscription: formSubscription,
  ) => React.element = "FormSpy"
}

@module("react-final-form")
external useFormState: Js.Nullable.t<Js.Json.t> => formState = "useFormState"

@module("react-final-form")
external useForm: unit => formApi = "useForm"

@module("react-final-form")
external useField: string => fieldRenderProps = "useField"

let makeFakeInput = (
  ~value=Js.Json.null,
  ~onChange=_ev => (),
  ~onBlur=_ev => (),
  ~onFocus=_ev => (),
  (),
) => {
  let input: fieldRenderPropsInput = {
    name: "--",
    onBlur: onBlur,
    onChange: onChange,
    onFocus: onFocus,
    value: value,
    checked: true,
  }
  input
}
