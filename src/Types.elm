module Types exposing (..)

import GenericDict exposing (GenericDict)


type Cell
    = Empty
    | Head
    | Tail
    | Conductor


type Msg
    = Tick


type alias Coord =
    ( Int, Int )


type alias World =
    GenericDict Coord Cell


type alias Model =
    { world : World }
