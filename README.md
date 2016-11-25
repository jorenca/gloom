# gloom
Raspberry Pi controller code for the Gloom automated box kit

## Setup
Assuming you already have ruby >=2.0.0 installed:
- install `wiringPi` somehow
- install dependencies
  - `gem install bundler`
  - `bundle install`

## Execution
To start the server, run:
- `ruby app.rb` (possibly `sudo`)

## Crontab
Use `crontab -e` to set your cronjobs:  
`m1 hlist * * * * curl localhost:80/set/air/1`  
`m2 hlist * * * * curl localhost:80/set/air/0`
