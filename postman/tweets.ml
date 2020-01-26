open Lwt
open Cohttp
open Cohttp_lwt_unix
let token = Sys.getenv "TWITTER_TOKEN"
let headers =
  Header.of_list [("Authorization", (Printf.sprintf "Bearer %s" token))]
let uriOfString id =
  Printf.sprintf "https://api.twitter.com/labs/1/tweets?ids=%s" id
let reqBody uri =
  (Client.call ~headers `GET uri) >>=
    (fun (_resp,body)  ->
       (body |> Cohttp_lwt.Body.to_string) >|= (fun body  -> body))
let getLastTweet id =
  let uri = Uri.of_string (uriOfString id) in
  let lastTweet = Lwt_main.run (reqBody uri) in lastTweet