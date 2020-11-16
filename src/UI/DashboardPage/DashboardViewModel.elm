module UI.DashboardPage.DashboardViewModel exposing (..)
import Types exposing (..)
import Http exposing (Error)


type alias  DashboardViewModel =
    {
        workDayData: List WorkdayData
        , selectedWorkdayData: Maybe WorkdayData
    }

type DashboardPageMsgOptions
    = ShowAttendanceDateDetails WorkdayData
    | FetchedAttendanceDate (Result Error (List WorkdayData))