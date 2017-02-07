# Call these commands with 'make [test, server, install, console, etc.]'

BE=bundle exec

install:
	bundle install

test: install
	$(BE) rspec

server: install
	$(BE) rails s

console: install
	$(BE) rails c

.PHONY: install test server console
