module UI.DatePicker.XDatePickerViewModel exposing (..)
import Date exposing (Date)
import DatePicker exposing (DateEvent(..))



type alias DateDay =  String

type alias  DatePickerViewModel =
    {
       date : Maybe Date
       , datePicker : DatePicker.DatePicker
    }

type DatePickerOptions
    = SubmitDatePicker
    | ToDatePicker DatePicker.Msg