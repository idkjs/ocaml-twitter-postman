---
title: Running the Tweets and Users Example with Postman and OCaml - Part 2
published: false
description: Using the Twitter API with OCaml
tags: ocaml, postman, twitter, opam, dune
series: Using the Twitter API with OCaml and Postman.io
---

<div class="center">
<a href="https://www.getpostman.com/"><img src="https://assets.getpostman.com/common-share/postman-logo-horizontal-320x132.png" /></a>
<a href="https://ocaml.org/"><img src="https://ocaml.org/img/colour-logo-white.svg" /></a>
</div>

The `Twitter` docs for this are [here](https://developer.twitter.com/en/docs/labs/tweets-and-users/quick-starts/get-users). Let me say that the `Twitter` docs are all over the place. You will find dead links, unclear explanations and circular doc references and links. This a good part of the reason why I am writing this up, so I can refer back to it.

Follow the steps at the link to get a developer account. The `postman` link on that page is dead. This is the link you need: [tutorials/postman-getting-started](https://developer.twitter.com/en/docs/tutorials/postman-getting-started).

The first thing you need to do is get a `bearer token`. The link for that is [bearer-tokens](https://developer.twitter.com/en/docs/basics/authentication/oauth-2-0/bearer-tokens). I will reproduce the process here.

This is straight from the docs:

> ## How to generate a Bearer Token

> Copy the following cURL request into your command line after making changes to the following consumer API keys previously obtained from your Twitter app. Note that the consumer API keys used on this page have been disabled and will not work for real requests.
> `API key <API key> e.g.xvz1evFS4wEEPTGEFPHBog`
> `API secret key <API secret key> e.g. L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg`

> ```curl
> curl -u '<API key>:<API secret key>' \
>  --data 'grant_type=client_credentials' \
>  'https://api.twitter.com/oauth2/token'
> ```

> Here's an example of how the curl request should look with your API keys entered:

> ```curl
> curl -u 'xvz1evFS4wEEPTGEFPHBog:L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg' \
>  --data 'grant_type=client_credentials' \
>  'https://api.twitter.com/oauth2/token'
> ```

> Here is what the response would look like. Note that this is a decommissioned Bearer Token:

> ```json
> {"token_type":"bearer",>"access_token":"aRjeMU9YWuP5aS8trretKALXhcjBpQ7xY0TJBwq8Dhl1sw3GkRX5VxeyzfqDtqiwAueS9rHbA5PNzr292iE6D1DMwbqLXErMVuhOOzREtZ9eL1FSFTBw6PCVnZmWUtQl3vfiWMaGOdg3gmkQjPLBWqabOcgsufJFdUID3VWrGUo4mT9Bscuq9WZ4Ey6itIMM5InH3mjb"}
> ```

> Our Bearer Token used to authenticate to resources with OAuth 2.0 would be:

> ```sh
> aRjeMU9YWuP5aS8trretKALXhcjBpQ7xY0TJBwq8Dhl1sw3GkRX5VxeyzfqDtqiwAueS9rHbA5PNzr292iE6D1DMwbqLXErMVuhOOzREtZ9eL1FSFTBw6PCVnZmWUtQl3vfiWMaGOdg3gmkQjPLBWqabOcgsufJFdUID3VWrGUo4mT9Bscuq9WZ4Ey6itIMM5InH3mjb
> ```

Once you have your token you want to open up `postman` (download it at postman.io if you dont have it.).

Once you have all that set up, go ahead and click the blue `send` button. My `json` response was:

```json
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
```

## Running this in OCaml

[Postman](https://postman.io) has an amazing code-generation project that gets you the code for a script you ran via `postman`. Check it out here: [postmanlabs/postman-code-generators](https://github.com/postmanlabs/postman-code-generators). This list of available languages are

Look for the `code` button like in the bottom left of this image:

![code-generation-button](./code-button.png)

Click the button and in the popup screen scroll down to `OCaml`. You should see something like this:

{::options parse_block_html="false" /}

<div class="center">

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">And <a href="https://twitter.com/hashtag/FTW?src=hash&amp;ref_src=twsrc%5Etfw">#FTW</a> ⁦<a href="https://twitter.com/getpostman?ref_src=twsrc%5Etfw">@getpostman</a>⁩ has <a href="https://twitter.com/hashtag/OCaml?src=hash&amp;ref_src=twsrc%5Etfw">#OCaml</a> code generation. ⁦<a href="https://twitter.com/sgrove?ref_src=twsrc%5Etfw">@sgrove</a>⁩ eat your heart out. If you want to convert it to <a href="https://twitter.com/hashtag/Reason?src=hash&amp;ref_src=twsrc%5Etfw">#Reason</a>… <a href="https://t.co/4KUzqnb5xK">pic.twitter.com/4KUzqnb5xK</a></p>&mdash; mandalarian (@_idkjs) <a href="https://twitter.com/_idkjs/status/1220466939182624770?ref_src=twsrc%5Etfw">January 23, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

</div>

Click the `copy` icon in the top left of the popup to copy the snippet. Then create a file for it, `touch tweets_and_users.ml`, and paste it in. This is the snippet I got, with [scrambled](./scrambled.js) variables of course. Yours will have your own token in it:

```OCaml

open Lwt
open Cohttp
open Cohttp_lwt_unix

let reqBody =
  let uri = Uri.of_string "https://api.twitter.com/labs/1/users?usernames=TwitterDev&format=detailed" in
  let headers = Header.init ()
    |> fun h -> Header.add h "Authorization" "Bearer aRjeMU9YWuP5aS8trretKALXhcjBpQ7xY0TJBwq8Dhl1sw3GkRX5VxeyzfqDtqiwAueS9rHbA5PNzr292iE6D1DMwbqLXErMVuhOOzREtZ9eL1FSFTBw6PCVnZmWUtQl3vfiWMaGOdg3gmkQjPLBWqabOcgsufJFdUID3VWrGUo4mT9Bscuq9WZ4Ey6itIMM5InH3mjb"
  in
  Client.call ~headers `GET uri >>= fun (resp, body) ->
  body |> Cohttp_lwt.Body.to_string >|= fun body -> body

let () =
  let respBody = Lwt_main.run reqBody in
  print_endline (respBody)
```

Then run `touch dune` and copy over our `Makefile` with `cp ../hello-postman/Makefile .`

```sh
touch dune
cp ../hello-postman/Makefile .
tree
➜  tweets-and-users [master*]tree
.
├── Makefile
├── README.md
├── code-button.png
├── scrambler.js
└── tweets_and_users.ml

0 directories, 5 files
```

In the snippet we see that the project requires `Lwt, Cohttp` and `Cohttp_lwt_unix` so let configure out `dune` file accordingly.

```dune
(executable
 (name tweets-and-users)
 (libraries cohttp lwt cohttp-lwt-unix))
```

Now if you remember, we run `make` to build our the program.

```sh
➜  tweets-and-users [master*]make
dune build
File "tweets_and_users.ml", line 1:
Error (warning 24): bad source file name: "Dune__exe__Tweets-and-users" is not a valid module name.
File "tweets_and_users.ml", line 2, characters 5-11:
2 | open Cohttp
         ^^^^^^
Error: Unbound module Cohttp
make: *** [default] Error 1
```

What happened here? Running `make` can only install the dependencies that we have installed with `opam`. We haven't yet installed the deps we need here so lets do that by running `opam install cohttp lwt cohttp-lwt-unix`.

Then lets try running `make` again.

```sh
➜  tweets-and-users [master*]make
dune build
File "tweets_and_users.ml", line 14, characters 41-45:
14 |   Client.call ~headers `GET uri >>= fun (resp, body) ->
                                              ^^^^
Error (warning 27): unused variable resp.
make: *** [default] Error 1
```

So the code generated by `postman` is not perfect. Looks like the compiler is requiring to use variables or ignore them. We can ignore `resp` by changing it to `_resp` to indicate we are ignoring the variable.

Run `make` again and it compiles!:

```sh
➜  tweets-and-users [master*]make
dune build
➜  tweets-and-users [master*]
```

Now we finally get to run `_build/default/tweets_and_users.exe`:

```sh
➜  tweets-and-users [master*]_build/default/tweets_and_users.exe
Fatal error: exception (Failure "No SSL or TLS support compiled into Conduit")
```

Wow. What in the world does that mean? I searched the web but came up with nothing helpful. I then searched `No SSL or TLS support compiled into Conduit` in the [discord #ocaml channel]() and found this [post](https://discordapp.com/channels/235176658175262720/235200837608144898/542804296136392706). The response from the always helpful [@\_anmonteiro](https://twitter.com/_anmonteiro) says you need to add [`lwt_ssl`](https://opam.ocaml.org/packages/lwt_ssl/) or [`tls`](https://opam.ocaml.org/packages/tls/) if you want ssl support. Let try `lwt_ssl` first.

```sh
opam install lwt_ssl
# output
➜  tweets-and-users [master*]opam install lwt_ssl

The following actions will be performed:
  ∗ install   conf-pkg-config  1.1   [required by conf-libssl]
  ∗ install   conf-libssl      1     [required by ssl]
  ∗ install   ssl              0.5.9 [required by lwt_ssl]
  ∗ install   lwt_ssl          1.1.3
  ↻ recompile conduit-lwt-unix 2.0.2 [uses lwt_ssl]
  ↻ recompile cohttp-lwt-unix  2.5.0 [uses conduit-lwt-unix]
===== ∗ 4   ↻ 2 =====
Do you want to continue? [Y/n] y

<><> Gathering sources ><><><><><><><><><><><><><><><><><><><><><><><><><><>  🐫
[cohttp-lwt-unix.2.5.0] found in cache
[conduit-lwt-unix.2.0.2] found in cache
[lwt_ssl.1.1.3] downloaded from cache at https://opam.ocaml.org/cache
[ssl.0.5.9] downloaded from cache at https://opam.ocaml.org/cache

<><> Processing actions <><><><><><><><><><><><><><><><><><><><><><><><><><>  🐫
⊘ removed   cohttp-lwt-unix.2.5.0
⊘ removed   conduit-lwt-unix.2.0.2
∗ installed conf-pkg-config.1.1
∗ installed conf-libssl.1
∗ installed ssl.0.5.9
∗ installed lwt_ssl.1.1.3
∗ installed conduit-lwt-unix.2.0.2
∗ installed cohttp-lwt-unix.2.5.0
Done.
➜  tweets-and-users [master*]make
dune build
```

Let try running it again:

```sh
➜  _build/default/tweets_and_users.exe
```

returns:

```json
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
          "hashtags": [{ "start": 23, "end": 30, "tag": "DevRel" }]
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
        "followers_count": 506517,
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
```

And it works!

Let's do one more thing to clean this up because it is bothering me. Let's stick our token in an enviromental variable. I am no sure how to do this relative to the specific project so I will do it globally. If you know how to do it project specifically with `dune` and `OCaml` please do leave a comment.

First we `export` our token. I am using `zsh` shell so I am putting in my `~/.zprofile` file like this:

```sh
echo "export TWITTER_TOKEN=aRjeMU9YWuP5aS8trretKALXhcjBpQ7xY0TJBwq8Dhl1sw3GkRX5VxeyzfqDtqiwAueS9rHbA5PNzr292iE6D1DMwbqLXErMVuhOOzREtZ9eL1FSFTBw6PCVnZmWUtQl3vfiWMaGOdg3gmkQjPLBWqabOcgsufJFdUID3VWrGUo4mT9Bscuq9WZ4Ey6itIMM5InH3mjb" >> ~/.zprofile
```

Then make sure its availabe by sourcing it then test it.

```sh
➜ source ~/.zprofile
➜ echo $TWITTER_TOKEN
# output should be your token
aRjeMU9YWuP5aS8trretKALXhcjBpQ7xY0TJBwq8Dhl1sw3GkRX5VxeyzfqDtqiwAueS9rHbA5PNzr292iE6D1DMwbqLXErMVuhOOzREtZ9eL1FSFTBw6PCVnZmWUtQl3vfiWMaGOdg3gmkQjPLBWqabOcgsufJFdUID3VWrGUo4mT9Bscuq9WZ4Ey6itIMM5InH3mjb
```

Now go into `tweets_and_users.ml` and add the following under your `open` calls:

```ocaml
let token = Sys.getenv "TWITTER_TOKEN";;
print_endline(token)

let headers = Header.of_list[ "Authorization", Printf.sprintf "Bearer %s" token]
```

The `print_endline` is just so you can see it logging from the program.

`let headers` is constructing the `header` using the `Cohttp.Header` module. Where you see `"Bearer %s"` the `%s` is a place holder where the variable that follows, here `token` will be placed.

Then change your `reqBody` function to use the `headers` variable.

```ocaml
let reqBody =
  let uri = Uri.of_string "https://api.twitter.com/labs/1/users?usernames=TwitterDev&format=detailed" in
  Client.call ~headers:headers `GET uri >>= fun (_resp, body) ->
  body |> Cohttp_lwt.Body.to_string >|= fun body -> body
```

Compile and run:

```sh
➜ make
➜ _build/default/tweets_and_users.exe
{"data":[{"created_at":"2013-12-14T04:35:55.000Z","description":"The voice of Twitter's #DevRel team, and your official sourc
e for updates, news, & events about Twitter's API.\n\nNeed help? Visit https://t.co/DVDf7qKyS9","entities":{"url":{"urls":[{"
start":0,"end":23,"url":"https://t.co/3ZX3TNiZCY","expanded_url":"https://developer.twitter.com/en/community","display_url":"
developer.twitter.com/en/community"}]},"description":{"urls":[{"start":129,"end":152,"url":"https://t.co/DVDf7qKyS9","expanded_url":"http://twittercommunity.com","display_url":"twittercommunity.com"}],"hashtags":[{"start":23,"end":30,"tag":"DevRel"}]}},"id":"2244994945","location":"127.0.0.1","most_recent_tweet_id":"1214947767250030592","name":"Twitter Dev","pinned_tweet_id":"1214281000932593667","profile_image_url":"https://pbs.twimg.com/profile_images/880136122604507136/xHrnqf1T_normal.jpg","protected":false,"stats":{"followers_count":506517,"following_count":1707,"tweet_count":3498,"listed_count":1641},"url":"https://t.co/3ZX3TNiZCY","username":"TwitterDev","verified":true,"format":"detailed"}]}
```

Well that does it for this episode of `coding in the open`. Though I don't think this project fully complies with the principle, talking to you helps me learn and remember. I encourage you to teach what you are learning. Besides all that, I end up referring back to my own posts to see how I did something so have at it.

The source code for this post is [here](https://github.com/idkjs/ocaml-twitter-postman/tree/master/tweets-and-users).

Thanks.
