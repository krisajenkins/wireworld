module State exposing (..)

import String
import GenericDict
import Time exposing (..)
import Types exposing (..)


compareCoord : Coord -> Coord -> Order
compareCoord a b =
    let
        compareX =
            compare (fst a) (fst b)
    in
        if compareX == EQ then
            compare (snd a) (snd b)
        else
            compareX


initialWorld : World
initialWorld =
    GenericDict.fromList compareCoord
        [ ( ( 2, 0 ), Head )
        , ( ( 3, 0 ), Tail )
        , ( ( 4, 0 ), Conductor )
        , ( ( 5, 0 ), Conductor )
        , ( ( 6, 0 ), Conductor )
        , ( ( 1, 1 ), Conductor )
        , ( ( 7, 1 ), Conductor )
        , ( ( 1, 10 ), Conductor )
        , ( ( 7, 10 ), Tail )
        , ( ( 0, 11 ), Conductor )
        , ( ( 2, 11 ), Conductor )
        , ( ( 7, 11 ), Conductor )
        , ( ( 0, 12 ), Conductor )
        , ( ( 2, 12 ), Conductor )
        , ( ( 7, 12 ), Conductor )
        , ( ( 1, 13 ), Conductor )
        , ( ( 7, 13 ), Conductor )
        , ( ( 1, 14 ), Conductor )
        , ( ( 7, 14 ), Conductor )
        , ( ( 2, 15 ), Conductor )
        , ( ( 3, 15 ), Conductor )
        , ( ( 4, 15 ), Conductor )
        , ( ( 5, 15 ), Conductor )
        , ( ( 6, 15 ), Conductor )
        , ( ( 1, 2 ), Conductor )
        , ( ( 6, 2 ), Conductor )
        , ( ( 8, 2 ), Conductor )
        , ( ( 0, 3 ), Conductor )
        , ( ( 2, 3 ), Conductor )
        , ( ( 5, 3 ), Conductor )
        , ( ( 9, 3 ), Conductor )
        , ( ( 0, 4 ), Conductor )
        , ( ( 10, 4 ), Conductor )
        , ( ( 2, 4 ), Conductor )
        , ( ( 4, 4 ), Conductor )
        , ( ( 6, 4 ), Conductor )
        , ( ( 8, 4 ), Conductor )
        , ( ( 1, 5 ), Conductor )
        , ( ( 10, 5 ), Conductor )
        , ( ( 4, 5 ), Conductor )
        , ( ( 6, 5 ), Conductor )
        , ( ( 8, 5 ), Conductor )
        , ( ( 1, 6 ), Conductor )
        , ( ( 10, 6 ), Conductor )
        , ( ( 4, 6 ), Conductor )
        , ( ( 6, 6 ), Conductor )
        , ( ( 8, 6 ), Conductor )
        , ( ( 0, 7 ), Conductor )
        , ( ( 2, 7 ), Conductor )
        , ( ( 5, 7 ), Conductor )
        , ( ( 9, 7 ), Conductor )
        , ( ( 0, 8 ), Conductor )
        , ( ( 2, 8 ), Conductor )
        , ( ( 6, 8 ), Conductor )
        , ( ( 8, 8 ), Conductor )
        , ( ( 1, 9 ), Conductor )
        , ( ( 7, 9 ), Head )
        ]


initialState : ( Model, Cmd Msg )
initialState =
    ( { world = initialWorld
      , tickingSpeed = 1
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions { tickingSpeed } =
    let
        updateRate =
            1 / (toFloat tickingSpeed) * 500
    in
        Time.every (updateRate * millisecond) Tick


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

        UpdateTickingSpeed speed ->
            case String.toInt speed of
                Err _ ->
                    ( model, Cmd.none )

                Ok newSpeed ->
                    ( { model | tickingSpeed = newSpeed }, Cmd.none )


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
