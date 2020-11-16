module Main exposing (..)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav exposing (Key)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>))
import Model exposing (..)
import Helper exposing (..)
import Api
import UI.ViewComponents as Ui
import UI.DatePicker.XDatePickerReducer as UiDatePicker
import UI.DashboardPage.DashboardView as DashboardView
import UI.PendingPage.PendingView as PendingView
import UI.PendingPage.PendingViewModel as PendingViewModel
import UI.PendingPage.PendingViewReducer as UiPendingPage
import UI.DashboardPage.DashboardViewReducer as UiDashboardPage
import Types exposing (..)
import DatePicker


import Messages exposing (..)



type Route
     = Signin String
     | NotFound

routeParser : Parser.Parser (Route -> a) a
routeParser =
    Parser.oneOf
      [
        -- map whereTo  (structureToMatch)
        Parser.map Signin (Parser.s "signin" </> Parser.string)
      ]

init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init _ _ key =
    let
        ( datePicker, datePickerFx ) = DatePicker.init
        newModel: Model
        newModel =
           {
              navigationKey = key
              , url = "/"
              , dashboardViewModel = {workDayData=[], selectedWorkdayData=Nothing}
              , datePickerViewModel = {date = Nothing, datePicker = datePicker}
              , pendingViewModel = {  pendingList = [], selectedMemberPendingData = Nothing }
              , viewModel = {
                 error=""
                 , isDialog=False
                 , isPendingList = False
                 , isLoading = False
              }
           }
        (_, c) = update (PendingPageMsg PendingViewModel.FetchPendingList) newModel
        commands =
            Cmd.batch [
                c
                , UiDatePicker.init_commands DatePickerMsg datePickerFx
            ]
    in
        (newModel, commands)



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        DatePickerMsg options ->
            UiDatePicker.update options model
        PendingPageMsg options ->
            UiPendingPage.update options model
        DashboardPageMsg options ->
            UiDashboardPage.update options model
        ShowDialog ->
            let
                oldViewModel = model.viewModel
                newViewModel = {oldViewModel | isDialog = True}
            in
            ({model | viewModel =newViewModel}, Cmd.none)
        DismissDialog ->
            let
                oldViewModel = model.viewModel
                newViewModel = {oldViewModel | isDialog = False}
                newModel = {model | viewModel =newViewModel}
            in
            (newModel, Cmd.none)
        DeleteMember nid ->
            (model |> setIsLoading True, Api.deleteMemberFromDB nid)
        DeletedMember nid _ ->
            let
                viewedMembers = model.dashboardViewModel.workDayData
                   |> List.filter (\m -> m.nid == nid |> not)
                oldViewModel = model.viewModel
                newViewModel = {oldViewModel | isDialog = False}
                newModel1 = {model | viewModel =newViewModel}

                dashboardViewModel = model.dashboardViewModel
                dashboardViewModelMod = {dashboardViewModel | workDayData = viewedMembers}
                newModel = {newModel1 | dashboardViewModel = dashboardViewModelMod}

            in
            (newModel |> setIsLoading False, Cmd.none)
        UpdateUrl _ -> (urlUpdater model msg, Cmd.none)

        ServerResponse response ->
            (model, Cmd.none)
        LoadingState ->
            ( model |> setIsLoading True, Cmd.none)
        TogglePendingList ->
            (
                case model.viewModel.isPendingList of
                    True -> model |> setShowPendingList False
                    False -> model |> setShowPendingList True
                , Cmd.none)







---- VIEW ----

urlUpdater: Model -> Msg -> Model
urlUpdater model msg =
    case msg of
        UpdateUrl url ->
            let
                loadedModel = model |> setIsLoading False
            in
                {loadedModel | url = url}
        _ -> model

onUrlRequest : UrlRequest -> Msg
onUrlRequest urlRequest =
    case urlRequest of
        Browser.Internal url ->
            -- let
            --     -- _ = Debug.log "Url: " url.path
            -- in
                UpdateUrl url.path
        _ -> NoOp


onUrlChange : Url -> Msg
onUrlChange url =
    NoOp

loaderView: Model -> Document Msg -> Document Msg
loaderView model v =
    case model.viewModel.isLoading of
        True -> {v | body = List.append v.body [Ui.loadSpinner] }
        _ -> v


view: Model -> Document Msg
view model =
    --case model.viewModel.isPendingList of
    --    True -> PendingView.view model |> loaderView model
    --    _ -> DashboardView.view model |> loaderView model
    case model.url of
        "/pending" -> PendingView.view model |> loaderView model
        _ -> DashboardView.view model |> loaderView model
---- PROGRAM ----



main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        }