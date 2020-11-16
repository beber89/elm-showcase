module UI.DashboardPage.DashboardViewReducer exposing (update)
import UI.DashboardPage.DashboardViewModel exposing(..)
import Model exposing (..)
import Messages exposing (..)


update : DashboardPageMsgOptions -> Model -> (Model, Cmd Msg)
update options model =
    case options of
        ShowAttendanceDateDetails workDayData ->
            let
                oldViewModel = model.dashboardViewModel
                newViewModel = {oldViewModel | selectedWorkdayData = Just workDayData}
            in
                ({model | dashboardViewModel =newViewModel}, Cmd.none)
        FetchedAttendanceDate u ->
            case u of
                Ok workDayData ->
                    let
                        oldViewModel = model.viewModel
                        newViewModel = {oldViewModel | isLoading = False}

                        newModel4Dashboard = {model | viewModel =newViewModel}
                        dashboardViewModel = newModel4Dashboard.dashboardViewModel
                        dashboardViewModelMod = {dashboardViewModel | workDayData = workDayData }
                        newModel = {newModel4Dashboard | dashboardViewModel = dashboardViewModelMod}
                        -- _ = Debug.log "data get " workDayData
                    in
                        (newModel, Cmd.none)
                Err m ->
                    let
                        -- _ = Debug.log "error " m
                        oldViewModel = model.viewModel
                        newViewModel = {oldViewModel | isLoading = False, error = "error happened"}
                        dashboardViewModel = model.dashboardViewModel
                        dashboardViewModelMod = {dashboardViewModel | workDayData = [{ename= "404", arrival="", nid="Could not reach server", img="ximage.png"}] }
                    in
                        ({model | viewModel =newViewModel, dashboardViewModel=dashboardViewModelMod}, Cmd.none)

