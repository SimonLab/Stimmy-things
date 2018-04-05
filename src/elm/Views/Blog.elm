module Views.Blog exposing (..)

import Helpers.Utils exposing (ifThenElse, viewIf)
import Helpers.Style exposing (horizontalTransition, classes, headerFont, bodyFont, backgroundImageNoPosition, backgroundImageCover)
import Data.Avatar exposing (avatarHeadSelection)
import Html exposing (..)
import Types exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


blog : Model -> Html Msg
blog model =
    div [ horizontalTransition model, class "bg-washed-yellow black fit-content mb3" ]
        [ div [ class "bg-green center tc" ]
            [ div [ class "flex flex-row items-center justify-center relative" ]
                [ div
                    [ class "absolute left-0 ml3 pointer mt3"
                    , onClick <| NavigateTo Landing
                    ]
                    [ img [ src "./assets/StimPreparation/back_btn_white.svg" ] [] ]
                , h1 [ classes [ headerFont, "white mb3 mt4" ] ] [ text "Stimmy Stuff" ]
                ]
            , button
                [ classes
                    [ "green br-pill pa1 w5 mb4 bg-white bn"
                    , bodyFont
                    ]
                ]
                [ text "Blog" ]
            ]
        , div []
            [ div [] (renderBlogStims model)
            ]
        ]


renderBlogStims : Model -> List (Html Msg)
renderBlogStims model =
    List.map
        (\firebaseStim ->
            div [ class "flex flex-column mh3" ]
                [ div [ class "mt3" ]
                    [ img [ class "w-100 mb3", src "./assets/StimInfo/divider_zigzag_grey_small.svg" ] []
                    ]
                , div
                    [ class "fit-content bg-top br2"
                    , backgroundImageCover "./assets/ShareModal/zigzag_modal_bg.svg"
                    ]
                    [ div [ class "flex items-center mb3 mh4 mt4", onClick <| GoToStim firebaseStim.stim ]
                        [ object
                            [ id "avatarHead", attribute "data" <| avatarHeadSelection firebaseStim.user.avatar, type_ "image/svg+xml", class "w3" ]
                            []
                        , div [ class "flex-column mv3 ml3" ]
                            [ p [ classes [ headerFont, "black mb1" ] ] [ text firebaseStim.stim.stimName ]
                            , p [ class "self-end w-100" ] [ text ("By " ++ firebaseStim.user.name) ]
                            ]
                        ]
                    , p [ classes [ headerFont, "black mh4 mb3" ] ] [ text "How to do this:" ]
                    , p [ classes [ bodyFont, "black mb3 mh4" ] ] [ text firebaseStim.stim.instructions ]
                    , viewIf (firebaseStim.stim.videoSrc /= Nothing) (videoSection firebaseStim.stim)
                    , hr [ class "light-gray mb2 mh4" ] []
                    , addOrDoStim (alreadyExistsInIndexedDB firebaseStim.stim model) firebaseStim.stim
                    ]
                ]
        )
        (List.reverse model.blogStims)


alreadyExistsInIndexedDB : Stim -> Model -> Bool
alreadyExistsInIndexedDB blogStim model =
    let
        stimIdList =
            List.map (\stim -> stim.stimId) model.stims
    in
        List.member blogStim.stimId stimIdList


addOrDoStim : Bool -> Stim -> Html Msg
addOrDoStim bool stim =
    ifThenElse bool (div [ class "bg-right h2 mr4 mb3 tr f7 green" ] [ text "Already in your stims!" ]) (div [ class "bg-right h2 mr4 mb3", backgroundImageNoPosition "./assets/Blog/upload_stim_icn.svg" 7, onClick <| ImportStim stim ] [])


videoSection : Stim -> Html Msg
videoSection stim =
    div
        [ class "flex flex-column items-center fit-content mb3"
        ]
        [ div []
            [ iframe [ width 250, height 140, src <| Maybe.withDefault "" stim.videoSrc ] []
            ]
        ]
