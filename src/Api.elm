module Api exposing (..)
import Http
import Types exposing (..)
import Messages exposing (..)
import Json.Decode as D exposing (Decoder)
import UI.PendingPage.PendingViewModel exposing (..)
import UI.DashboardPage.DashboardViewModel exposing (..)


membersListDecoder: Decoder (List WorkdayData)
membersListDecoder =
   D.list (
      D.map4 WorkdayData
         (D.field "ename" D.string)
         (D.field "arrival" D.string)
         (D.field "nid" D.string)
         (D.field "img" D.string)
   )

fetchMembersTodate : DateDay -> Cmd Msg
fetchMembersTodate day =
    Http.get { url = "http://127.0.0.1:8080/members/"++day
        , expect = Http.expectJson (\x -> DashboardPageMsg (FetchedAttendanceDate x)) membersListDecoder
        }


pendingMembersListDecoder: Decoder (List MemberPendingData)
pendingMembersListDecoder =
   D.list (
      D.map3 MemberPendingData
         (D.field "imgName" D.string)
         (D.field "nid" D.string)
         (D.field "date" D.string)
   )

type alias DateDay =  String


deleteMemberFromDB : String -> Cmd Msg
deleteMemberFromDB nid =
    Http.get { url = "http://127.0.0.1:8080/members/"++nid++"/remove"
        , expect = Http.expectString (DeletedMember nid)
    }

fetchPendingList : Cmd Msg
fetchPendingList =
    Http.get { url = "http://127.0.0.1:8080/pendings/"
        , expect = Http.expectJson (\x -> PendingPageMsg (FetchedPendingList x)) pendingMembersListDecoder
        }