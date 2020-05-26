type t

val t_of_js : Ojs.t -> t

val t_to_js : t -> Ojs.t

type placement =
  | Auto [@js "auto"]
  | AutoStart [@js "auto-start"]
  | AutoEnd [@js "auto-end"]
  | Top [@js "top"]
  | TopStart [@js "top-start"]
  | TopEnd [@js "top-end"]
  | Bottom [@js "bottom"]
  | BottomStart [@js "bottom-start"]
  | BottomEnd [@js "bottom-end"]
  | Right [@js "right"]
  | RightStart [@js "right-start"]
  | RightEnd [@js "right-end"]
  | Left [@js "left"]
  | LeftStart [@js "left-start"]
  | LeftEnd [@js "left-end"]
[@@js.enum]

type strategy = Absolute [@js "absolute"] | Fixed [@js "fixed"] [@@js.enum]

type options = { placement: placement option; strategy: strategy option }

val create : Js_browser.Element.t -> Js_browser.Element.t -> options option -> t
  [@@js.global "Popper.createPopper"]

val set_options : t -> options -> unit [@@js.call]

val update : t -> unit [@@js.call]

val destroy : t -> unit [@@js.call]
