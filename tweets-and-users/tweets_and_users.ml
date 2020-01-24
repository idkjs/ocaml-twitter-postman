open Lwt
open Cohttp
open Cohttp_lwt_unix

let token = Sys.getenv "TWITTER_TOKEN";;
print_endline(token)

let headers = Header.of_list[ "Authorization", Printf.sprintf "Bearer %s" token];;

let reqBody =
  let uri = Uri.of_string "https://api.twitter.com/labs/1/users?usernames=TwitterDev&format=detailed" in
  Client.call ~headers:headers `GET uri >>= fun (_resp, body) ->
  body |> Cohttp_lwt.Body.to_string >|= fun body -> body

let () =
  let respBody = Lwt_main.run reqBody in
  print_endline (respBody)