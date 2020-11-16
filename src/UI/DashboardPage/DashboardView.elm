module UI.DashboardPage.DashboardView exposing (view)
import Messages exposing (..)
import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import UI.ViewComponents as Ui
import Model exposing (..)
import UI.DashboardPage.DashboardViewModel exposing (..)
----- Mock Data -------------
items = { name = "Don", nid = "2891110" }

----------- ViewActions --------


---- VIEW ----

view : Model -> Document Msg
view model =
    { title = "Distinctly Average",
      body =
      [
              Ui.navBarTop
              , Ui.headerBarTop model
              , Html.div [class "container-fluid"][
                  Html.div [class "row", style "width" "100vw", style "height" "100vh"][
                      if not model.viewModel.isPendingList
                      then
                          Html.div [class "col-12 col-sm-3"][
                          -- FIXME: SEVERE Error is here
                              let
                                  l = List.length model.dashboardViewModel.workDayData
                              in
                              if l > 0 then
                                 model.dashboardViewModel.workDayData |> Ui.listerView
                              else
                                 Html.div [] []
                          ]
                      else Html.div [][]
                       , Html.div [class "d-inline-block h-100 col-0 col-sm-1 shd-r"][]

                       , Html.div [class "col-12 col-sm h-100"][
                          if model.viewModel.isDialog then
                             let
                                 m = case model.dashboardViewModel.selectedWorkdayData of
                                     Just u -> DeleteMember u.nid
                                     Nothing -> DismissDialog
                             in
                                 Ui.dialogBox m  DismissDialog
                          else
                             Html.div [class "row align-items-center h-100"][
                                case model.dashboardViewModel.selectedWorkdayData of
                                    Nothing -> Html.div [] []
                                    Just workdayData ->
                                        --Ui.deleteMemberBtn
                                           let
                                               imgSrc = if String.contains "ximage.png" workdayData.img
                                                   then
                                                       "./ximage.png"
                                                   else
                                                       "http://127.0.0.1:8080/p/nid/"++workdayData.nid++"/img/"++workdayData.img
                                           in
                                               Html.div [class "col-12 col-sm-10"][
                                                  Html.div [class "row m-2"][
                                                     Html.img [src (imgSrc), alt "uthappizza", class "col-12 offset-sm-3 col-sm-6 mr-3 img-thumbnail align-self-center"][]
                                                  ]
                                                  , Html.div [class "row m-2"][
                                                         case model.dashboardViewModel.selectedWorkdayData of
                                                             Nothing -> Html.div [] []
                                                             Just w -> Ui.memberDetails w
                                                  ]
                                               ]
                             ]
                       ]
                       , Html.div [class "h-100 col-0 col-sm-1 shd-l"][]
                       , if model.viewModel.isPendingList
                       then Html.div [class "col-12 col-sm-3 h-100"][]
                       else Html.div [][]
                  ]
               ]
           ]
    }

