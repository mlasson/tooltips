module V = Vdom

type model = Bindings.Popper.placement

let placement_of_string : string -> Bindings.Popper.placement option = function
  | "Auto" -> Some Auto
  | "AutoStart" -> Some AutoStart
  | "AutoEnd" -> Some AutoEnd
  | "Top" -> Some Top
  | "TopStart" -> Some TopStart
  | "TopEnd" -> Some TopEnd
  | "Bottom" -> Some Bottom
  | "BottomStart" -> Some BottomStart
  | "BottomEnd" -> Some BottomEnd
  | "Right" -> Some Right
  | "RightStart" -> Some RightStart
  | "RightEnd" -> Some RightEnd
  | "Left" -> Some Left
  | "LeftStart" -> Some LeftStart
  | "LeftEnd" -> Some LeftEnd
  | _ -> None

let string_of_placement : Bindings.Popper.placement -> string = function
  | Auto -> "Auto"
  | AutoStart -> "AutoStart"
  | AutoEnd -> "AutoEnd"
  | Top -> "Top"
  | TopStart -> "TopStart"
  | TopEnd -> "TopEnd"
  | Bottom -> "Bottom"
  | BottomStart -> "BottomStart"
  | BottomEnd -> "BottomEnd"
  | Right -> "Right"
  | RightStart -> "RightStart"
  | RightEnd -> "RightEnd"
  | Left -> "Left"
  | LeftStart -> "LeftStart"
  | LeftEnd -> "LeftEnd"

type msg = Change of Bindings.Popper.placement

let init = V.return Bindings.Popper.Left

let update _ (Change placement) = Vdom.return placement

let view_placement placement =
  let open Bindings.Popper in
  let options =
    [
      Auto;
      AutoStart;
      AutoEnd;
      Top;
      TopStart;
      TopEnd;
      Bottom;
      BottomStart;
      BottomEnd;
      Right;
      RightStart;
      RightEnd;
      Left;
      LeftStart;
      LeftEnd;
    ]
  in
  let onchange index = Change (List.nth options index) in
  V.elt
    ~a:[ V.onchange_index onchange ]
    "select"
    (List.map
       (fun option ->
         let label = string_of_placement option in
         let a = [ V.value label ] in
         let a = if option = placement then V.attr "selected" "" :: a else a in
         V.elt ~a "option" [ V.text label ])
       options)

let view placement =
  V.div ~a:[ V.class_ "box" ]
    [ Tooltip.tooltip ~placement [ view_placement placement ] ]

let app = V.app ~init ~view ~update ()

open Js_browser

let run () =
  let container = Document.body document in
  ignore (Vdom_blit.run ~container app)

let () = Window.set_onload window run
