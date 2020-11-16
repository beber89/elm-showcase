module UI.ViewComponents exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)
import UI.DatePicker.XDatePickerView as UiDatePickerView
import UI.DashboardPage.DashboardViewModel exposing (..)
import Messages exposing (..)

import Model exposing (..)


viewItem : WorkdayData -> Html a
viewItem model =
   Html.div [class "ibtn-hover card w-100 m-0 bg-light rounded-0"] [
       Html.div [class "card-body"] [
          Html.p [class "card-text"][
             Html.strong [] [text model.ename]
             , Html.p [class "card-text"] [text model.nid]
             ]
          ]
       ]


listItem : WorkdayData -> Html Msg
listItem workDay  =
       Html.li [
          class "row hoverable"
          , onClick (DashboardPageMsg (ShowAttendanceDateDetails workDay)) ][
          Html.div [class "offset-1 col-2 align-self-center"][
             Html.span [class "fa fa-user fa-3x"][]
          ]
          , Html.div [class "col-7"][
             Html.h4 [class "col-12 mb-1"] [text workDay.ename]
             , Html.p [class "col-12 text-muted"] [text workDay.nid]
          ]
          , Html.div [class "col bg-primary"][]
       ]


navBarTop: Html Msg
navBarTop =
    Html.nav [class "navbar navbar-expand-sm border-bottom"][
        Html.div [class "container-fluid mr-0 ml-0"][
            Html.div [class "row w-100"] [
                Html.div [class "col-2 border-right"][
                    Html.a [class "navbar-brand text-primary", href "/"] [text "Comitatus"]
                ]
                , Html.div [class "col-5"][]
                , Html.div [class "offset-1 col-2"][
                    Html.span [class "row justify-content-end w-100"][
                        Html.a [class "btn btn-outline-primary"][
                            Html.span [class "fa fa-refresh mr-1" ][]
                            , Html.span [][text "Retrain"]
                        ]
                    ]
                ]
                , Html.div [class "col-2 border-left"][
                    Html.a [class "btn btn-outline-primary", onClick TogglePendingList][
                        Html.span [class "fa fa-sign-in mr-1" ][]
                        , Html.span [][text "Pending"]
                    ]
                ]
            ]
        ]
    ]

headerBarTop: Model -> Html Msg
headerBarTop model =
        Html.header [class "container-fluid border-bottom w-100"][
                UiDatePickerView.textFieldView model
        ]

memberDetails: WorkdayData -> Html Msg
memberDetails model =
        Html.table [class "table table-striped"][
          Html.tbody[][
            Html.tr[][
              Html.th [scope "row"][text "Name"]
              , Html.td [] [text model.ename]
            ]
            , Html.tr[][
              Html.th [scope "row"][text "ID"]
              , Html.td [] [text model.nid]
            ]
            , Html.tr[][
              Html.th [scope "row"][text "Arrival"]
              , Html.td [] [text model.arrival]
            ]
            , Html.tr [] [
               Html.th [scope "row"][text "Checkout"]
               , Html.td [] [text "4:00"]
            ]
          ]
        ]


listerView: (List WorkdayData) -> Html Msg
listerView model =
    model
      |> List.map (\m -> listItem m)
      |> Html.ul [class "mdl-list"]


dialogBox: Msg -> Msg -> Html Msg
dialogBox yes no =
    Html.div [class "", tabindex -1, attribute "role" "dialog"][
      Html.div [class "modal-dialog", attribute "role" "document"][
        Html.div [class "modal-content"][
          Html.div [class "modal-body"][
            Html.p [] [text "Are you sure you want to delete member from database?"]
          ]
          , Html.div [class "modal-footer"][
              Html.button [type_ "button", onClick no, class "btn btn-secondary"][text "Close"]
              , Html.button [type_ "button", onClick yes, class "btn btn-primary"][text "Yes"]
          ]
        ]
      ]
    ]

loadSpinner: Html Msg
loadSpinner =
    Html.div [class "loader"][]