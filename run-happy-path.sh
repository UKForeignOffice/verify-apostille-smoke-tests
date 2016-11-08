#!/bin/bash
export TEST_URL="http://localhost:1337"
# THIS SECTION ALLOWS YOU TO RUN A SPECIFIC TEST
bundle exec rspec spec/verify/features/happy_path_spec.rb
