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

print_to_terminal: install
	echo 'what the flip'

.PHONY: install test server console
