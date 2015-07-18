# AmionAdapter

This is an adapter for the API for AMION scheduling software

# Usage

```
amion_adapter = AmionAdapter.new( "account_login" )

raw_html = amion_adapter.fetch_report("625c", Date.today)

puts raw_csv
```

# Parsing is not yet implemented
Currently reports are difficult to parse because the API:
- lacks standardization (a given report for two different accounts may have different structures)
- lacks a row that defines column headers
- has arbitrary number of "header rows" at the top
- a given report type may have variable number of columns depending on the account
- goes by academic year, entering 6/2014 may give you 6/2014 or 6/2015 because June shifts exist on the edge of two different academic years

# Report types
```
625c        all shifts
619         call schedule
2           person_ids
34          role_ids        0-3           2
```

## Installation

This is not yet available as a Gem, pending a parser, however in the future you will be able to add it this way:

Add this line to your application's Gemfile:

    gem 'amion_adapter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amion_adapter

## Contributing

1. Fork it ( http://github.com/<my-github-username>/amion_adapter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
