module Helper exposing (..)
import Types exposing (..)
import Model exposing (..)

setIsLoading: Bool -> Model -> Model
setIsLoading b model =
    let
        oldViewModel = model.viewModel
    in
        {model | viewModel = {oldViewModel | isLoading = b}}

setPendingList: List MemberPendingData -> Model -> Model
setPendingList data model =
    let
        oldViewModel = model.pendingViewModel
    in
    {model | pendingViewModel = {oldViewModel | pendingList = data}}

setPendingMember: MemberPendingData -> Model -> Model
setPendingMember data model =
    let
        oldViewModel = model.pendingViewModel
    in
        {model | pendingViewModel = {oldViewModel | selectedMemberPendingData = Just data}}

setErrorMsg: String -> Model -> Model
setErrorMsg msg model =
    let
        oldViewModel = model.viewModel
    in
        {model | viewModel = { oldViewModel | error = msg} }

setShowPendingList: Bool -> Model -> Model
setShowPendingList bl model =
    let
        oldViewModel = model.viewModel
    in
        {model | viewModel = { oldViewModel | isPendingList = bl} }

