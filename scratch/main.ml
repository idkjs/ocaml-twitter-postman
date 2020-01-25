open Postman

open Yojson.Basic.Util

let json_data =
  Yojson.Basic.from_string
    {|
{
  "data": [
    {
      "created_at": "2013-12-14T04:35:55.000Z",
      "description": "The voice of Twitter's #DevRel team, and your official source for updates, news, & events about Twitter's API.\n\nNeed help? Visit https://t.co/DVDf7qKyS9",
      "entities": {
        "url": {
          "urls": [
            {
              "start": 0,
              "end": 23,
              "url": "https://t.co/3ZX3TNiZCY",
              "expanded_url": "https://developer.twitter.com/en/community",
              "display_url": "developer.twitter.com/en/community"
            }
          ]
        },
        "description": {
          "urls": [
            {
              "start": 129,
              "end": 152,
              "url": "https://t.co/DVDf7qKyS9",
              "expanded_url": "http://twittercommunity.com",
              "display_url": "twittercommunity.com"
            }
          ],
          "hashtags": [
            {
              "start": 23,
              "end": 30,
              "tag": "DevRel"
            }
          ]
        }
      },
      "id": "2244994945",
      "location": "127.0.0.1",
      "most_recent_tweet_id": "1214947767250030592",
      "name": "Twitter Dev",
      "pinned_tweet_id": "1214281000932593667",
      "profile_image_url": "https://pbs.twimg.com/profile_images/880136122604507136/xHrnqf1T_normal.jpg",
      "protected": false,
      "stats": {
        "followers_count": 506515,
        "following_count": 1707,
        "tweet_count": 3498,
        "listed_count": 1641
      },
      "url": "https://t.co/3ZX3TNiZCY",
      "username": "TwitterDev",
      "verified": true,
      "format": "detailed"
    }
  ]
}
|};;
let most_recent_tweet_id_from json =
  [json]
    |> filter_member "data"
    |> flatten
    |> filter_member "most_recent_tweet_id"
    |> filter_string


let test json = most_recent_tweet_id_from json;;
let name json =
  (((json |> (member "data")) |> flatten) |> (member "most_recent_tweet_id"))
    |> to_string
(* List.iter print_endline (test);; *)
(* let tweetId json = (most_recent_tweet_id_from json) |> to_string;;
(* let _ = Tweets.get () *)
let tweets = Tweets.get ()


let _ = List.iter print_endline (tweetId tweets) *)

(* let _ = print_endline tweets *)

let tweetId json = (most_recent_tweet_id_from json) |> to_string;;
let tweets = Tweets.get ()

let main () =
  let json = tweets in
  List.iter print_endline (tweetId json);;
(* let main () =
  let json = json_data in
  List.iter print_endline (test json) *)
print_endline ("testing json");;
print_endline (test);;
print_endline (tweets);;
print_endline (tweets name);;
(* let () = main () *)