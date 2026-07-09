setup: install env-prepare db-setup
install:
	bundle install
env-prepare:
	test -f .env || cp .env.example .env
db-setup:
	bundle exec rails db:create db:migrate db:seed
start:
	bundle exec rails s
test:
	bin/rails test
test-system:
	bin/rails test:system