module UI.PendingPage.PendingViewModel exposing (..)
import Http exposing (Error)
import Types exposing (..)


type alias  PendingViewModel =
    {
       pendingList: List MemberPendingData
       , selectedMemberPendingData: Maybe MemberPendingData
    }

type PendingPageMsgOptions
    =  FetchedPendingList (Result Error (List MemberPendingData))
    | FetchPendingList
    | ShowPendingMemberDetails MemberPendingData