module State exposing (..)

import Exts.Basics exposing (compareBy)
import GenericDict
import Types exposing (..)


initialWorld : World
initialWorld =
    GenericDict.fromList (compareBy toString)
        [ ( ( 4, 4 ), Head )
        , ( ( 5, 4 ), Tail )
        , ( ( 6, 4 ), Conductor )
        , ( ( 7, 4 ), Conductor )
        , ( ( 8, 4 ), Conductor )
        , ( ( 8, 5 ), Conductor )
        , ( ( 8, 6 ), Conductor )
        , ( ( 8, 7 ), Conductor )
        , ( ( 8, 8 ), Conductor )
        , ( ( 7, 8 ), Conductor )
        , ( ( 6, 8 ), Conductor )
        , ( ( 5, 8 ), Conductor )
        , ( ( 4, 8 ), Conductor )
        , ( ( 4, 7 ), Conductor )
        , ( ( 4, 6 ), Conductor )
        , ( ( 4, 5 ), Conductor )
        ]


initialState : ( Model, Cmd Msg )
initialState =
    ( { world = initialWorld }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( model
            , Cmd.none
            )
