module Views.ShareModal exposing (..)

import Components.Button exposing (rectButton)
import Helpers.Style exposing (backgroundImageStyle, classes, headerFont, verticalTransition)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


shareModal : Model -> Html Msg
shareModal model =
    div [ verticalTransition model, class "bg-green vh-100 justify-center items-center flex flex-column", backgroundImageStyle "./assets/ShareModal/zigzag_modal_bg.svg" 90 ]
        [ img [ src "./assets/ShareModal/share_to_blog_icn.svg", class " justify-center items-center flex flex-column mb2" ] []
        , div [ class " w-80 justify-center items-center flex flex-column tc" ]
            [ p [ classes [ headerFont, "mb3" ] ] [ text model.selectedStim.stimName ]
            , p [ classes [ headerFont, "mb3" ] ] [ text "If it works for you, it might work for others too!" ]
            , p [ class "mb3" ] [ text "Share your stim wisdom with others on the Stimmy Things network" ]
            , div
                [ class "mb3 w-100 tc" ]
                [ rectButton "Yes please!" (ShareStim model.selectedStim) ]
            , a [ class "mb3 green underline", onClick (NavigateTo Landing) ] [ text "no thanks, maybe later" ]
            ]
        ]
