module Model exposing (..)

import Browser.Navigation exposing (Key)
import UI.DatePicker.XDatePickerViewModel exposing (..)
import UI.PendingPage.PendingViewModel exposing (..)
import UI.DashboardPage.DashboardViewModel exposing (..)

---- MODEL ----


type alias Model =
    {
      navigationKey: Key
      , url: String
      , dashboardViewModel: DashboardViewModel
      , datePickerViewModel: DatePickerViewModel
      , pendingViewModel: PendingViewModel
      , viewModel: {
         isDialog: Bool
         , isPendingList: Bool
         , error: String
         , isLoading: Bool
      }
    }