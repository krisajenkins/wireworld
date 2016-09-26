module View exposing (root)

import GenericDict exposing (GenericDict)
import Html exposing (Html, div, code, text)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Svg.Keyed as Keyed
import Types exposing (..)


cellSize : Int
cellSize =
    50


gridSizeX : Int
gridSizeX =
    20


gridSizeY : Int
gridSizeY =
    10


root : Model -> Html Msg
root model =
    div []
        [ circuitView model.world ]


gridOf : List a -> List b -> List ( a, b )
gridOf xs ys =
    List.concat
        <| List.map (\x -> List.map (\y -> ( x, y )) ys) xs


circuitView : World -> Svg Msg
circuitView world =
    Keyed.node "svg"
        [ width (toString (gridSizeX * cellSize))
        , height (toString (gridSizeY * cellSize))
        , viewBox "0 0 1200 600"
        ]
        (List.map
            (\coord ->
                ( toString coord
                , world
                    |> GenericDict.get coord
                    |> Maybe.withDefault Empty
                    |> cellView coord
                )
            )
            (gridOf [0..(gridSizeX - 1)] [0..(gridSizeY - 1)])
        )


cellView : Coord -> Cell -> Svg Msg
cellView coord cell =
    rect
        [ x (toString (((fst coord) * (cellSize + 1))))
        , y (toString ((snd coord + 1) * (cellSize + 1)))
        , width (toString cellSize)
        , height (toString cellSize)
        , fill (cellColor cell)
        , onClick (ToggleCell coord)
        ]
        []


cellColor : Cell -> String
cellColor cell =
    case cell of
        Empty ->
            "black"

        Head ->
            "#0080FF"

        Tail ->
            "#FF4000"

        Conductor ->
            "#FFD700"
