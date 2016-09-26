module Types exposing (..)

import GenericDict exposing (GenericDict)
import Time exposing (Time)


type Cell
    = Empty
    | Head
    | Tail
    | Conductor


type Msg
    = Tick Time
    | ToggleCell Coord


type alias Coord =
    ( Int, Int )


type alias World =
    GenericDict Coord Cell


type alias Model =
    { world : World }
