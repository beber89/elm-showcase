module UI.PendingPage.PendingView exposing (view)
import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import UI.ViewComponents as Ui
import Messages exposing (..)
import Model exposing (..)
import Types exposing (..)
import UI.PendingPage.PendingViewModel exposing (..)
import Html.Events exposing (onClick)



----- Mock Data -------------
items = { name = "Don", nid = "2891110" }


---------------ViewComponents----------

pendingListItem : MemberPendingData -> Html Msg
pendingListItem model  =
       Html.li [class "mdl-list__item mdl-list__item--two-line hoverable item-list", onClick (ShowPendingMemberDetails  model |> PendingPageMsg )][
          Html.span [class "mdl-list__item-primary-content"][
             Html.i [class "material-icons mdl-list__item-avatar"][text "person"]
             , Html.span [] [text model.nid]
             , Html.span [class "mdl-list__item-sub-title"] [text model.date]
          ]
          , Html.span [
             class "mdl-list__item-secondary-content mdl-color--pink-900"
             ][
          ]
       ]

listerPendingView: (List MemberPendingData) -> Html Msg
listerPendingView model =
    model
      |> List.map (\m -> pendingListItem m)
      |> Html.ul [class "mdl-list"]

----------- ViewActions --------


---- VIEW ----

view : Model -> Document Msg
view model =
    { title = "Distinctly Average",
      body =
      [
              Ui.navBarTop
              , Ui.headerBarTop model
              , Html.div [class "row", style "width" "100vw", style "height" "100vh"][
                   Html.div [class "col-12 col-sm-3"][
                      -- FIXME: SEVERE Error is here
                      let
                          l = List.length model.pendingViewModel.pendingList
                      in
                      if l > 0 then
                         model.pendingViewModel.pendingList
                         -- Trim the date , taking only the day not the hour
                         |> List.map (\m ->  {m | date = Maybe.withDefault "0" (String.split ":" m.date |> List.head)}  )
                         |> listerPendingView
                      else
                         Html.div [] []
                   ]

                   , Html.div [class "mdl-cell mdl-cell--9-col"][
                      if model.viewModel.isDialog then
                         let
                             m = case model.dashboardViewModel.selectedWorkdayData of
                                 Just u -> DeleteMember u.nid
                                 Nothing -> DismissDialog
                         in
                             Ui.dialogBox m DismissDialog
                      else
                         Html.div[][]
                      , Html.div [class "mdl-grid"][
                        Html.div [class "mdl-layout-spacer"][]
                        , Html.button [
                           class "mdl-button mdl-js-button"
                           , style "margin-top" "15px"
                        ][
                          Html.i [class "material-icons"][text "cancel"]
                          , Html.span[][text "deny"]
                        ]
                        , Html.button [
                           class "mdl-button mdl-js-button"
                           , style "margin-top" "15px"
                        ][
                          Html.i [class "material-icons"][text "check"]
                          , Html.span[][text "accept"]
                        ]
                        , Html.div [class "mdl-layout-spacer"][]
                      ]
                      , case model.pendingViewModel.selectedMemberPendingData of
                          Just selected ->
                              Html.div [class "mdl-grid"][
                                 Html.div [class "mdl-cell mdl-cell--6-col"][
                                    Html.div [class "demo-card-image mdl-card mdl-shadow--2dp"][
                                       --Ui.imager ("http://127.0.0.1:8080/nid/"++selected.nid++"/img/"++ selected.imgName ++ "/pending_" )
                                    ]
                                 ]
                                 , Html.div [class "mdl-cell mdl-cell--6-col"][
                                    Html.div [class "demo-card-image mdl-card mdl-shadow--2dp"][
                                       --Ui.imager "image.png"
                                    ]
                                 ]
                              ]
                          Nothing -> Html.div [] []
              ]
           ]
      ]
    }

