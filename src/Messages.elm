module Messages exposing (..)
import Http exposing (Error)
import UI.DatePicker.XDatePickerViewModel exposing (..)
import UI.PendingPage.PendingViewModel exposing (..)
import UI.DashboardPage.DashboardViewModel exposing (..)

type Msg
    =  PendingPageMsg PendingPageMsgOptions
    | DatePickerMsg DatePickerOptions
    | DashboardPageMsg DashboardPageMsgOptions
    | DeleteMember String
    | DeletedMember String (Result Error String)
    | ShowDialog
    | DismissDialog
    | ServerResponse (Result Error String)
    | UpdateUrl String
    | TogglePendingList
    | LoadingState
    | NoOp