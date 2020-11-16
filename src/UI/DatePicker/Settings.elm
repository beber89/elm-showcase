module UI.DatePicker.Settings exposing (..)
import Html.Attributes exposing (..)

import Date exposing (Date, weekday)
import DatePicker exposing (DateEvent(..), defaultSettings)
import Time exposing (Weekday(..))


settings : DatePicker.Settings
settings =
    let
        isDisabled date =
            [ Sat, Sun ]
                |> List.member (weekday date)
    in
    { defaultSettings
        | isDisabled = isDisabled
        , inputClassList = [ ( "form-control", True ) ]
        , inputName = Just "date"
        , inputId = Just "date-field"
        , inputAttributes = [attribute "autocomplete" "off"]
    }