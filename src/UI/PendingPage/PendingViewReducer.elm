module UI.PendingPage.PendingViewReducer exposing (update)
import UI.PendingPage.PendingViewModel exposing(..)
import Model exposing (..)
import Messages exposing (..)
import Api
import Helper exposing (..)


update : PendingPageMsgOptions -> Model -> (Model, Cmd Msg)
update options model =
    case options of
        FetchPendingList ->
            (model, Api.fetchPendingList)
        FetchedPendingList res ->
            case res of
                Ok data ->
                    (model |> setPendingList data, Cmd.none)
                Err _ ->
                    (model |> setErrorMsg "error happened while fetching pending list", Cmd.none)
        ShowPendingMemberDetails u ->
            (model |> setPendingMember u, Cmd.none)

