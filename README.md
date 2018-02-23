# Task Manager App

This is a single page web application built for **RubyGarage** test task.

## Technology stack
* Ruby on Rails (5.1.4)
* VueJS (2.5.13)
* Webpack

## Functionality
- [x] **Single page application**
- [x] **Authentification** (JSON web tokens)
- [x] **Managing projects and tasks**
- [x] --- Create/update/delete projects
- [x] --- Create/update/delete tasks inside of projects
- [x] --- Set priority, deadline and status (done/not done) for tasks
- [x] **Validation**
- [x] --- Server side
- [x] --- Client side
- [x] **Automated tests** (backend)

## Installation

1. Clone the repo:

```
$ git clone https://github.com/truealisa/task-manager-app.git
```

2. Install the needed gems:

```
$ bundle install
```

3. Install frontend dependencies:

```
$ yarn install
```

4. Migrate the database:

```
$ rails db:migrate
```

## Testing

```
$ rails exec rspec
```

## Running the app

Run Task Manager App in a local server:

```
$ foreman start
```
