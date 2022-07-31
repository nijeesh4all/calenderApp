
# Google Calender Manager : Ruby on Rails
![ruby-2.6.5](https://img.shields.io/badge/Ruby-v2.7.1-green.svg)
![rails-5.2.4](https://img.shields.io/badge/Rails-v7.0.3-brightgreen.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/b6d8755c5a32fcad1073/maintainability)](https://codeclimate.com/github/nijeesh4all/ShowOffTest/maintainability)

check out the demo here : 
> Since its running on heroku free dyno,the application goes to sleep after some time of inactivity
> so the first request might be really slow so because of that

This is an demo application built for the second round of interview for memory

### User Story

As a user, I want to have my Google Calendar events for today listed on a Web interface,
classified by calendar names.
The events should import and save to db when I connect my account to Google calendar for the
first time, the subsequent events which get
created/updated/deleted should be sync&#39;d to the db automatically.


## Getting started
### Clone
To get started with the app, clone the repo
```
$ cd /path/to/repos
$ git clone 
$ cd calenderApp
```
### Set Environment Variables

This application make use of these Environment variables for working.

1. `GOOGLE_CLIENT_ID`
2. `GOOGLE_CLIENT_SECRET`
3. `SECRET_KEY_BASE`
4. `KEY_DERIVATION_SALT`
5. `PRIMARY_KEY`
6. `DETERMINISTIC_KEY`
7. `APPLICATION_URL`

For development you can use the `.env.example` file for reference.
copy the `.env.example` file to `.env` add your variables in there.

>**ITS VERY VERY IMPORTATION THE YOU DON'T COMMIT THIS FILE TO GIT**

You can either use docker to develop this or you can manually install ruby and run the app in the traditional way.

### Run using docker

first you have to install docker.
instructions on installing docker : https://docs.docker.com/machine/install-machine/

once its installed make sure you have added the `.env` file as instructed above. docker-compose make use of it to set the environment variables

```
# build all the necessary containers.
$ docker-compose build

# start the application
$ docker-compose up
```

### Run Manually
This application is made using Ruby on Rails. So first you need to install ruby version **2.6.3** to get started.

you can follow this tutorial for setting up ruby with rvm https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html

next install all the required gems via bundler
```
$ bundle install --without production
```
If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
## NOTES

### Functionalities
1. Existing events will be imported and save to db when user connect my account to Google calendar for the
   for first time
2. The newly created user events will be synced from google calender once every 12 hours
3. Any Changes made to the event, will be synced automatically
4. Only events created via dashboard will be deleted from google if its deleted from the web

## TESTS
This project uses `rspec` as the testing library

to run the test if you are using docker use this command

```
$ docker-compose run -e "RAILS_ENV=test" web rake spec
```

## License

MIT License

Copyright (c) [20222] [Nijeesh Joshy]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
