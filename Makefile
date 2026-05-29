env-prepare:
	cp -n .env.example .env || true
db-setup:
	bundle exec rails db:create db:migrate db:seed