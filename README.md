# Fitness::Track::Ruby

Ruby gem to manipulate and get handle to tracking information within different formats of 'fitness tracking' file - as used by Endomondo, Strava, Garmin etc.  This is to make it easier to use these files within your own fitness tracking app/website.

Current supported files are:-
	<a href= "http://www8.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd">Garmin's Training Centre Datgabase XML format (.tcx)</a>
	<a href= "http://www.topografix.com/gpx.asp">GPS Exchange format</a>  

## Installation

*** not currently available from rubygems, so will need to be pulled from github***

Add this line to your application's Gemfile:

    gem 'fitness-track-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fitness-track-ruby

## Usage

Currently just 2 simple examples, one to read in a tcx file, and one for gpx file.
run either examples from within the examples/filetest folder from console.

These output lap info to console - like I said only simple examples, watch this space!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
