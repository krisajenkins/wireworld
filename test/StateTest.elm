module StateTest exposing (tests)

import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test exposing (evidenceToTest)
import ElmTest exposing (..)
import State exposing (..)
import Types exposing (..)


tests : Test
tests =
    ElmTest.suite "State"
        []
