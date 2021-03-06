module Data.Feelings exposing (..)

import Json.Decode exposing (..)
import Types exposing (..)


feelings : List Feeling
feelings =
    [ Happy
    , Hyper
    , Motivated
    , Anxious
    , Cheerful
    , Angry
    , Excited
    , Bored
    , Sad
    , Annoyed
    , Relaxed
    , Frustrated
    ]


decodeFeeling : Decoder Feeling
decodeFeeling =
    Json.Decode.map stringToFeeling string


stringToFeeling : String -> Feeling
stringToFeeling string =
    case string of
        "Happy" ->
            Happy

        "Hyper" ->
            Hyper

        "Motivated" ->
            Motivated

        "Anxious" ->
            Anxious

        "Cheerful" ->
            Cheerful

        "Angry" ->
            Angry

        "Excited" ->
            Excited

        "Bored" ->
            Bored

        "Sad" ->
            Sad

        "Annoyed" ->
            Annoyed

        "Relaxed" ->
            Relaxed

        "Frustrated" ->
            Frustrated

        _ ->
            Happy
