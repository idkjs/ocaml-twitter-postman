---
title: The Postman Rides OCaml - Part 1
published: false
description: OCaml Postman Twitter Examples Setup
tags: ocaml, postman, twitter
series: The Postman Rides OCaml
---

![Alt Text](https://thepracticaldev.s3.amazonaws.com/i/4bfpk9fbjm65jun7puxr.png)

<a href="https://www.getpostman.com/"><img src="https://assets.getpostman.com/common-share/postman-logo-horizontal-320x132.png" /></a>

This is a walkthrough on how to setup a project so we can run some `http` requests against the `Twitter API` with `OCaml`. If you already now how to do this, you can skip to the next articles in this series. Have at it!

## Setup

1. Download `opam` if you don't have it. Check the install instructions on the link on the [opam home page](https://opam.ocaml.org/).

2. After you have it installed make a director for this project and `cd` into it: `mkdir ocaml-twitter-postman && cd ocaml-twitter-postman`.

3. We need to create a compiler specific to this project which we will do in our root directory which is the `/ocaml-twitter-postman` dir, by running `opam switch create . ocaml-base-compiler.4.08.1`. This part takes a while so go for a walk around the block. This `switch` is the one we will use to compile our `OCaml` code in all the examples. After the process finishes lets do what the output is telling us and run `eval $(opam env)` to update the current shell environment so it knows to use this compiler.

4. We are going to need `dune` to run some commands so let's install it with: `opam install dune`.

5. Now let's make a directory for first example, `mkdir hello-postman && cd !$` then create a `dune` file and initiate `dune`. The `dune install` command we run below creates a `dune-project` file we wont ever look at again. Run:

```sh
touch dune && dune install

# running `tree` in your terminal gets you:
.
├── _build
│   └── log
├── dune
└── dune-project

1 directory, 3 files
```

Check out [dune.build](https://dune.build/) to get started there if you don't know that its not just a [movie](https://youtu.be/hzUlXEyvJeA).

6. Create a `hello_postman.ml` file in the root with the following contents:

```ocaml
Lwt_main.run (Lwt_io.printf "Hello, postman!\n")
```

7. Configure the `dune` file by adding the following to it:

```dune
(executable
 (name hello_postman)
 (libraries lwt.unix))
```

8. Lets add a `Makefile` to simplify some running commands. Run `touch Makefile` and the following to it:

```Makefile
INSTALL_ARGS := $(if $(PREFIX),--prefix $(PREFIX),)

default:
  dune build

install:
  dune install $(INSTALL_ARGS)

uninstall:
  dune uninstall $(INSTALL_ARGS)

reinstall: uninstall install

clean:
  dune clean

.PHONY: default install uninstall reinstall clean
```

I don't remember where I stole this file from but thank you, nonetheless.

8. To build and run the project run the following commands from the `./hello-postman` directory. `make` will run the script at the top of the make file then the `default` argument in which is the `build` command. This will install any dependencies we listed in our `dune` file then build the project. This is doing the same thing as when we ran `dune install` above. So if you run `make clean` it will get rid of all the generated files. You can then just run `make` and your deps will be installed and `dune-project` will be created. #NoteToSelf: Its worth remembering that we are using the compiler we created in the root repository.

```sh
make clean
make
_build/default/hello_postman.exe

# output
➜  hello-postman make
dune build
Info: Creating file dune-project with this contents:
| (lang dune 2.1)
➜  hello-postman _build/default/hello_postman.exe
Hello, postman!
```

9. Add a `OCaml.gitignore` file. You can find the `github` template [here](https://github.com/github/gitignore/blob/master/OCaml.gitignore)
