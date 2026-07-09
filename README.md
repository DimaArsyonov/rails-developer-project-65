# Bulletin Board

![CI](https://github.com/DimaArsyonov/rails-developer-project-65/actions/workflows/ci.yml/badge.svg)
[![hexlet-check](https://github.com/DimaArsyonov/rails-developer-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/DimaArsyonov/rails-developer-project-65/actions/workflows/hexlet-check.yml)

A Ruby on Rails bulletin board application where users can publish, manage, search, and moderate classified ads.

The project was built as part of the Hexlet Ruby on Rails course. It demonstrates a typical Rails CRUD application with authentication, authorization, admin panel, image uploads, filtering, pagination, and state-based moderation workflow.

## Demo

You can try the deployed application here: [rails-developer-project-65.onrender.com](https://rails-developer-project-65.onrender.com)

## Features

- GitHub OAuth authentication
- Bulletin creation, editing, archiving, and moderation
- Image upload for bulletins
- Bulletin states: draft, under moderation, published, rejected, archived
- User profile page with personal bulletins
- Admin panel
- Category management
- Search and filtering by title and category
- Pagination
- Authorization policies
- Russian localization
- CI checks with tests, linting, and security scanning

## Tech Stack

- Ruby 3.4.5
- Ruby on Rails 7.2
- SQLite for development and test
- PostgreSQL for production
- Bootstrap 5
- Slim
- Simple Form
- AASM
- Pundit
- Ransack
- Kaminari
- Active Storage
- OmniAuth GitHub

## Requirements

Before starting, make sure you have installed:

- Ruby 3.4.5 or later
- Node.js 24.9.0 or later
- Yarn
- SQLite
- ImageMagick or libvips for image processing

## Setup

To set up the project locally, just make the following:

```bash
make setup
```

Then open the application in your browser:

```text
http://localhost:3000
```

## Usage

### Guest user

A guest user can:

- view the list of published bulletins
- open a bulletin page
- search bulletins by title
- filter bulletins by category

### Authenticated user

After signing in with GitHub, a user can:

- create a new bulletin
- upload an image
- edit their own bulletins
- send a bulletin to moderation
- archive their own bulletins
- view their own bulletins on the profile page

### Admin user

An admin can:

- open the admin panel
- view bulletins waiting for moderation
- publish bulletins
- reject bulletins
- archive bulletins
- manage categories

## Examples

### Creating a bulletin

1. Sign in with GitHub.
2. Click **Add**.
3. Fill in the title, description, category, and image.
4. Save the bulletin.
5. Send it to moderation from your profile page.

### Moderating a bulletin

1. Open the admin panel.
2. Find a bulletin under moderation.
3. Choose one of the available actions:
   - publish
   - reject
   - archive

### Searching bulletins

1. Open the main page.
2. Enter part of a bulletin title.
3. Optionally choose a category.
4. Click **Search**.

## License

This project is created for educational purposes.