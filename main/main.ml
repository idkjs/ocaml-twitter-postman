open Postman

open Yojson.Basic.Util


let most_recent_tweet_id_from json =
  ((([json] |> (filter_member "data")) |> flatten) |>
     (filter_member "most_recent_tweet_id"))
    |> filter_string
let jsonToYojson raw = Yojson.Basic.from_string raw
let rawTweets = Tweets.get ()
let tweetsYojson = jsonToYojson rawTweets
let tweets = Yojson.Basic.to_string tweetsYojson
let tweetId = most_recent_tweet_id_from tweetsYojson
let _ = print_endline "testing json"
let _ = print_endline tweets
let _ = List.iter print_endline tweetId

