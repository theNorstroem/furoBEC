# フロー furoBEC

#### The furo build essentials container.

This container contains all tools you need to work with a furo spec project. 

## Usage
Bash mode

    docker run -it --rm -v `pwd`:/project spectools 
    # do your stuff
    # type exit to quit
    exit

Command mode

    docker run -it --rm -v `pwd`:/project spectools build

## Installed Tools
Please look at the dockerfile if you are interested in the versions.

- golang
- git
- protoc
- protoc-gen-grpc-gateway (v2)
- protoc-gen-openapiv2
- protoc-gen-go
- protoc-gen-go-grpc
- simple-generator
- spectools
- furoc

> No furoc generators are installed. Add the needed furoc-gen-XXX to the `.furobecrc` file.

## .furobecrc
Make settings for your project in this file. Maybe you need a $GOPRIVATE or other Env vars.
The `.furobecrc` is runned when you start the container.

    # change the bash prompt
    PS1="フロー spectest#"
    GOPRIVATE=git.companybitbucket.com/projects


## Builtin "commands" Arguments
- noarg
  > will start a bash

- build
  > Will start the `spectools run build` command end exit.
  > Make sure that you have a `build` flow in your `.spectools`
  