#!/bin/bash
export TEST_URL="http://localhost:1337"
export TEST_DAY="15"
export TEST_MONTH="07"
export TEST_YEAR="2016"
export TEST_REFERENCE="APO-50"
# THIS SECTION ALLOWS YOU TO RUN A SPECIFIC TEST
bundle exec rspec spec/verify/features/happy_path_spec.rb
