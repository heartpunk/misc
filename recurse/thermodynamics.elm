import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (..)

type alias Model =
  { x  : Float
  , y  : Float
  , vx : Float
  , vy : Float
  }

main : Signal Element
main =
  Signal.map view (Signal.foldp update defaultDisc (fps 120))
  
--main2 =
--  let
--    timeSoFar = Signal.foldp (+) 0 (fps 60)
--  in
--    Signal.map setting timeSoFar

view : Model -> Element
view discModel =
  let
    x = discModel.x
    y = discModel.y
    renderedDisc = move (x, y) disc
  in
    setting renderedDisc

collageSize = 500
discSize = 5
discRadius = (discSize / 2) + 3
upperBound = collageSize / 2
lowerBound = -upperBound

update : Float -> Model -> Model
update dt model =
  let truncateToBounds upper lower a = if a > upper then upper else (if a < lower then lower else a)
      collided x vx = (x > (upperBound - discRadius)) || (x < (lowerBound))
      newPos x vx = if (collided x vx) then (truncateToBounds (upperBound - discRadius) (lowerBound + discRadius) x) else x + vx
      newVel x vx = if (collided x vx) then -vx else vx
  in
    { model |
      x  <- newPos model.x model.vx,
      y  <- newPos model.y model.vy,
      vx <- newVel model.x model.vx,
      vy <- newVel model.y model.vy
    }

disc =
  group
    [ filled lightGrey (circle discSize)
    , outlined (solid grey) (circle discSize)
      ]

setting renderedDisc =
  collage 500 500 [renderedDisc, outlined (solid red) (rect 500 500)]

defaultDisc : Model
defaultDisc =
  { x  = 125
  , y  = 125
  , vx = 1
  , vy = -1
  }

