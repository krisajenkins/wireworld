module View exposing (root)

import GenericDict exposing (GenericDict)
import Html exposing (Html, div, code, text)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ circuitView model.world
        , code [] [ Html.text <| toString model.world ]
        , div []
            [ code []
                [ Html.text (toString (gridOf [0..10] [0..10])) ]
            ]
        ]


gridOf : List a -> List b -> List ( a, b )
gridOf xs ys =
    List.concat
        <| List.map (\x -> List.map (\y -> ( x, y )) ys) xs


circuitView : World -> Svg msg
circuitView world =
    svg
        [ width "800"
        , height "800"
        , viewBox "0 0 800 800"
        ]
        (List.map
            (\coord ->
                world
                    |> GenericDict.get coord
                    |> Maybe.withDefault Empty
                    |> cellView coord
            )
            (gridOf [0..10] [0..10])
        )


cellSize : Int
cellSize =
    40


cellView : Coord -> Cell -> Svg msg
cellView coord cell =
    rect
        [ x (toString (((fst coord) * (cellSize + 1))))
        , y (toString ((snd coord + 1) * (cellSize + 1)))
        , width (toString cellSize)
        , height (toString cellSize)
        , fill (cellColor cell)
        ]
        []


cellColor : Cell -> String
cellColor cell =
    case cell of
        Empty ->
            "black"

        Head ->
            "blue"

        Tail ->
            "red"

        Conductor ->
            "yellow"
