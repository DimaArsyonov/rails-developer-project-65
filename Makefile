env-prepare:
	cp -n .env.example .env || true
db-setup:
	bundle exec rails db:create db:migrate db:seed
start:
	bundle exec rails server
test:
	bundle exec rspec