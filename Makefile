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
	@echo THIS COMMAND HAS BEEN DISABLED.
	@echo please see the readme.

seed:
	$(BE) rake db:drop
	$(BE) rake db:create
	$(BE) rake db:migrate
	$(BE) rake db:seed

coverage: test
	open ./coverage/index.html

js_dev:
	./bin/webpack --watch --progress --colors

.PHONY: install test server console migrate coverage
