# Call these commands with 'make [test, server, install, console, etc.]'

BE=bundle exec

install:
	bundle install

migrate:
	$(BE) rake db:migrate

test: install
	$(BE) rspec

server: install
	$(BE) rails s

console: install
	$(BE) rails c

mailcatcher:
	$(BE) mailcatcher

print_to_terminal: install
	echo 'what the flip'

.PHONY: install test server console migrate
