## Stock Track
Track NYSE and NASADQ Stock prices and ratings.
- Demo - [https://stock-track1.herokuapp.com/](https://stock-track1.herokuapp.com/)

## Build status
[![Codeship Status for bTspm/stock-track](https://app.codeship.com/projects/4f2d2090-7aeb-0138-3f1a-3a5302a14683/status?branch=master)](https://app.codeship.com/projects/396696)

## Tech/framework used
<b>Built with</b>
- [Ruby](https://www.ruby-lang.org) - 2.7.1
- [Rails](https://rubyonrails.org/) - 5.2.1
- [PostgreSQL](https://www.postgresql.org/) - 13.2
- [Elasticsearch](https://www.elastic.co/)
- [HighCharts](https://www.highcharts.com/) 
- [Bootstrap](https://getbootstrap.com/) - 4.6
- [Redis](https://redis.io/)

## Features
- Stock Watch Lists.
- Price Targets and Analyst Ratings from across the web.

## Installation
1. Clone the repo.
```sh
$ git clone https://github.com/bTspm/stock-track.git
```
2. Navigate to project directory.
```sh
$ cd stock-track
```
3. Set .env file with properties
- [IEX](Iexcloud.io/) - Register and get key
- [FinnHub](https://finnhub.io/) - Register and get key
- [Tradier](https://tradier.com/) - Register and get key
- [TwelveData](https://twelvedata.com/) - Register and get key
- [Searchly](https://www.searchly.com/) - Register and get key (For Elasticsearch) - Not Required for Local Env

```sh
ELASTICSEARCH_URL = ''
FINNHUB_KEY = ''
IEX_CLOUD_KEY = ''
TWELVE_DATA_KEY = ''
TRADIER_KEY = ''

IEX_SYMBOl_LOGO_PREFIX = ''
```
4. Run the migrations and seed the ref data.
```sh
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```
5. Start the Rails server.
```sh
$ bundle exec rails s
```
6. Start Redis Server.
```sh
$ brew services start redis
```
7. Start Sidekiq to process the background jobs.
```sh
$ bundle exec sidekiq
```
8. Navigate to [http//localhost:3000](http//localhost:3000)
## Tests
```sh
$ bundle exec rspec spec 
```
## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)