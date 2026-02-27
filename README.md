# rails-developer-project-65

![CI](https://github.com/DimaArsyonov/rails-developer-project-65/actions/workflows/ci.yml/badge.svg)
[![hexlet-check](https://github.com/DimaArsyonov/rails-developer-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/DimaArsyonov/rails-developer-project-65/actions/workflows/hexlet-check.yml)

It's my pet bulletin board and third project in Hexlet school

You may try my project via following link: https://rails-developer-project-65.onrender.com

## Installation

To start with your own bulletin board, you need to do following steps:

1. Clone the repository and set up JavaScript depedencies and gems:
   ```bash
   git clone https://github.com/DimaArsyonov/rails-developer-project-65.git
   cd rails-developer-project-65
   bundle install
   yarn install
   ```

2. Set up the database:
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```
   Please note, that SQLite is used in development and test environments, and PostgreSQL is in production.

3. Launch the server:
   ```bash
   bin/rails s
   ```

4. Open the app in your browser:
   ```
   http://localhost:3000
   ```