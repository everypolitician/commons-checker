# commons-checker

## Usage

Add to the `Gemfile` dependencies for a proto-commons- repository:

    gem 'commons-checker', :git => 'git://github.com/everypolitician/commons-checker.git'


Ensure that the Python environment has `fiona` and `shapely`:

    mkvirtualenv commons-checker
    pip install -r requirements.txt

Run with:

    bundle exec check


## Structure

Add new checks in `lib/commons/checker/checks` such that they look like existing checks.

Most checks are written in Ruby, but the geometry checks in `boundary_check.rb` call out to the `bin/check_geometry`
Python script. This returns a JSON report on `stdout` that is then incorporated into the main report.


## Direction

* Add more checks
* GitHub and Travis integration (to submit reports as comments on pull requests)
