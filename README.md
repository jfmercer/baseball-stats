# baseball-stats

[![Build Status](https://travis-ci.org/jfmercer/baseball-stats.svg?branch=master)](https://travis-ci.org/jfmercer/baseball-stats) [![Coverage](https://img.shields.io/codeclimate/coverage/github/jfmercer/baseball-stats.svg)](https://codeclimate.com/github/jfmercer/baseball-stats/coverage) [![Code Climate](https://img.shields.io/codeclimate/github/jfmercer/baseball-stats.svg)](https://codeclimate.com/github/jfmercer/baseball-stats) [![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

![](https://media.giphy.com/media/sLQTQI0aSg4GA/giphy.gif)

## Installation

```sh
git clone https://github.com/jfmercer/baseball-stats
cd baseball-stats/
bundle install
./bin/baseball_statistics read ./assets/Master-small.csv ./assets/Batting-07-12.csv
```

### Comments

The most glaring deficiency is code coverage is terrible. Frankly, I didn't
have time to learn the RSpec API. Additionally, input is not validated, certain
variables, such as year number and team id, are hard-coded into the program
rather than passed in as command line arguments, and the program does not calculate
the triple crown winner. Finally, I had hoped to publish this as a Ruby gem, but
those hopes did not materialize.

<sub><small>Made with 💪🏻 in Atlanta, GA.</small></sub>
