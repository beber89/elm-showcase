module UI.DatePicker.XDatePickerReducer exposing (..)
import Model exposing (..)
import Messages exposing (..)
import UI.DatePicker.XDatePickerViewModel exposing(..)
import Api exposing (..)
import Date exposing (Date)
import DatePicker exposing (DateEvent(..))
import UI.DatePicker.Settings exposing (settings)


init_commands: (DatePickerOptions -> Msg) -> Cmd DatePicker.Msg ->  Cmd Msg
init_commands msg datePickerFx = Cmd.map (\x -> msg (ToDatePicker x)) datePickerFx


update : DatePickerOptions -> Model -> (Model, Cmd Msg)
update options ({datePickerViewModel} as model) =
    case options of
        SubmitDatePicker ->
            let
                oldViewModel = model.viewModel
                newModel = {model | viewModel = {oldViewModel | isLoading = True} }
                tocmd =
                    case datePickerViewModel.date of
                        Just d ->
                            Date.toIsoString d |> fetchMembersTodate
                        Nothing -> Cmd.none

            in
                (newModel, tocmd)
        ToDatePicker subMsg ->
            let
                ( newDatePicker, event ) =
                    DatePicker.update settings subMsg datePickerViewModel.datePicker
                dtPickerViewModel = { datePickerViewModel
                    | date =
                        case event of
                            Picked date ->
                                Just date
                            _ ->
                                datePickerViewModel.date
                      , datePicker = newDatePicker}
            in
            ( { model
                | datePickerViewModel =
                    dtPickerViewModel
              }
            , Cmd.none
            )