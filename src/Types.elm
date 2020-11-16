module Types exposing (..)

type alias Flags =  { }

type alias WorkdayData =
    {
       ename: String
       , arrival: String
       , nid: String
       , img: String
    }

type alias MemberPendingData =
    {
       imgName: String
       , nid: String
       , date: String
    }


----------- View Models -----------

type alias Item =
    {
       name: String
       , nid: String
    }