module UI.DatePicker.XDatePickerView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (..)
import UI.DatePicker.XDatePickerViewModel exposing (..)

import DatePicker exposing (DateEvent(..))
import Model exposing (..)
import UI.DatePicker.Settings exposing (settings)

textFieldView: Model -> Html Msg
textFieldView model =
            Html.div[class "row"][
                Html.div [class "col-12 col-xl-2 col-md-3 mt-3 mb-3 ml-4"][
                    Html.div [class "row border-right"][
                        DatePicker.view model.datePickerViewModel.date settings model.datePickerViewModel.datePicker
                            |> Html.map (\a -> ToDatePicker a |> DatePickerMsg)
                        , Html.i [class "ml-4 align-self-center", onClick (DatePickerMsg SubmitDatePicker)][Html.span [class "hoverable fa fa-calendar"][]]
                    ]
                ]
                , Html.div [class "col-12 offset-xl-8 offset-md-7 col-md-1 border-left align-self-center"][
                    Html.i [class "ml-3 hoverable", onClick ShowDialog][Html.span [class "fa fa-trash"][]]
                ]
            ]