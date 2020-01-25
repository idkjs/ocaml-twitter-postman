open Postman

open Yojson.Basic.Util

let most_recent_user_id_from json =
  ((([json] |> (filter_member "data")) |> flatten) |>
     (filter_member "most_recent_tweet_id"))
    |> filter_string
let jsonToYojson raw = Yojson.Basic.from_string raw
let rawUsers = Users.get ()
let usersYojson = jsonToYojson rawUsers
let users = Yojson.Basic.to_string usersYojson
let userId = most_recent_user_id_from usersYojson
let _ = print_endline "testing json"
let _ = print_endline users
let _ = List.iter print_endline userId

