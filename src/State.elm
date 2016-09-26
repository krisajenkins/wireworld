module State exposing (..)

import Exts.Basics exposing (compareBy)
import GenericDict
import Time exposing (..)
import Types exposing (..)


initialWorld : World
initialWorld =
    GenericDict.fromList (compareBy toString)
        [ ( ( 0, 2 ), Head )
        , ( ( 0, 3 ), Tail )
        , ( ( 0, 4 ), Conductor )
        , ( ( 0, 5 ), Conductor )
        , ( ( 0, 6 ), Conductor )
        , ( ( 1, 1 ), Conductor )
        , ( ( 1, 7 ), Conductor )
        , ( ( 10, 1 ), Conductor )
        , ( ( 10, 7 ), Tail )
        , ( ( 11, 0 ), Conductor )
        , ( ( 11, 2 ), Conductor )
        , ( ( 11, 7 ), Conductor )
        , ( ( 12, 0 ), Conductor )
        , ( ( 12, 2 ), Conductor )
        , ( ( 12, 7 ), Conductor )
        , ( ( 13, 1 ), Conductor )
        , ( ( 13, 7 ), Conductor )
        , ( ( 14, 1 ), Conductor )
        , ( ( 14, 7 ), Conductor )
        , ( ( 15, 2 ), Conductor )
        , ( ( 15, 3 ), Conductor )
        , ( ( 15, 4 ), Conductor )
        , ( ( 15, 5 ), Conductor )
        , ( ( 15, 6 ), Conductor )
        , ( ( 2, 1 ), Conductor )
        , ( ( 2, 6 ), Conductor )
        , ( ( 2, 8 ), Conductor )
        , ( ( 3, 0 ), Conductor )
        , ( ( 3, 2 ), Conductor )
        , ( ( 3, 5 ), Conductor )
        , ( ( 3, 9 ), Conductor )
        , ( ( 4, 0 ), Conductor )
        , ( ( 4, 10 ), Conductor )
        , ( ( 4, 2 ), Conductor )
        , ( ( 4, 4 ), Conductor )
        , ( ( 4, 6 ), Conductor )
        , ( ( 4, 8 ), Conductor )
        , ( ( 5, 1 ), Conductor )
        , ( ( 5, 10 ), Conductor )
        , ( ( 5, 4 ), Conductor )
        , ( ( 5, 6 ), Conductor )
        , ( ( 5, 8 ), Conductor )
        , ( ( 6, 1 ), Conductor )
        , ( ( 6, 10 ), Conductor )
        , ( ( 6, 4 ), Conductor )
        , ( ( 6, 6 ), Conductor )
        , ( ( 6, 8 ), Conductor )
        , ( ( 7, 0 ), Conductor )
        , ( ( 7, 2 ), Conductor )
        , ( ( 7, 5 ), Conductor )
        , ( ( 7, 9 ), Conductor )
        , ( ( 8, 0 ), Conductor )
        , ( ( 8, 2 ), Conductor )
        , ( ( 8, 6 ), Conductor )
        , ( ( 8, 8 ), Conductor )
        , ( ( 9, 1 ), Conductor )
        , ( ( 9, 7 ), Head )
        ]


initialState : ( Model, Cmd Msg )
initialState =
    ( { world = initialWorld }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (50 * millisecond) Tick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | world = GenericDict.map (tickCell model.world) model.world }
            , Cmd.none
            )

        ToggleCell coord ->
            ( { model | world = GenericDict.update coord toggleCell model.world }
            , Cmd.none
            )


toggleCell : Maybe Cell -> Maybe Cell
toggleCell maybeCell =
    case maybeCell of
        Nothing ->
            Just Head

        Just _ ->
            Nothing


tickCell : World -> Coord -> Cell -> Cell
tickCell world coord cell =
    case cell of
        Empty ->
            Empty

        Head ->
            Tail

        Tail ->
            Conductor

        Conductor ->
            case countNeighbouringHeads world coord of
                1 ->
                    Head

                2 ->
                    Head

                _ ->
                    Conductor


countNeighbouringHeads : World -> Coord -> Int
countNeighbouringHeads world coord =
    neighbours coord
        |> List.filterMap (flip GenericDict.get world)
        |> List.filter ((==) Head)
        |> List.length


neighbours : Coord -> List Coord
neighbours ( x, y ) =
    [ ( x - 1, y - 1 )
    , ( x - 0, y - 1 )
    , ( x + 1, y - 1 )
    , ( x - 1, y + 0 )
    , ( x + 1, y + 0 )
    , ( x - 1, y + 1 )
    , ( x - 0, y + 1 )
    , ( x + 1, y + 1 )
    ]
