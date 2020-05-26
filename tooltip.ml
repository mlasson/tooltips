open Js_browser
open Bindings

type options = Popper.options

type Vdom.Custom.t += Popper of options

let handler ctx options =
  let instance = ref None in
  let disposed = ref false in
  let parent = Vdom_blit.Custom.parent ctx in
  let options = ref options in
  Vdom_blit.Custom.after_redraw ctx (fun () ->
      if not !disposed then begin
        let target = Element.parent_node parent in
        let inst = Popper.create target parent (Some !options) in
        instance := Some inst;
        Console.log console (Popper.t_to_js inst)
      end);
  let dispose () =
    disposed := true;
    Option.iter Popper.destroy !instance
  in
  let sync ct =
    match ct with
    | Popper new_options ->
        if new_options <> !options then begin
          options := new_options;
          Option.iter
            (fun inst -> Popper.set_options inst new_options)
            !instance
        end;
        true
    | _ -> false
  in
  let elt = Js_browser.(Document.create_text_node document "") in
  Vdom_blit.Custom.make ~dispose ~sync elt

let () =
  let f ctx attr =
    match attr with Popper value -> Some (handler ctx value) | _ -> None
  in
  Vdom_blit.(register (custom f))

let tooltip ?placement content =
  Vdom.elt "div"
    (Vdom.custom ~key:"popper-instance"
       (Popper { placement; strategy = Some Absolute })
    :: content
    )
