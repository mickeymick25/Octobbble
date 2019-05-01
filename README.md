# Octobbble

The aim of the project is to make a copycat of dribbble's website applied to the ux-tribe. The goal is to make projects more visible than what's Google Drive exposed.

## Docker
The project is based on docker & docker-compose. I followed the this [tutorial](https://medium.com/firehydrant-io/developing-a-ruby-on-rails-app-with-docker-compose-d75b20334634)in order to run a web application based on rails.

So to build the image
`docker-compose build web`

Then
`docker-compose up web`

## Rails
in order to interact with rail from the docker image...
`docker-compose run --rm web rails [your command]`

to lunch the rails console :
`docker-compose run --rm web rails c`

## Postgresql
