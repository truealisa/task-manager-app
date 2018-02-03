# Task Manager App

> Under development :heavy_exclamation_mark:

This is a single page web application built for **RubyGarage** test task.

## Technology stack
* Ruby on Rails (5.1.4)
* Webpack
* ...

## Functionality
- [ ] **Single page application**
- [ ] **Authentification** (JSON web tokens)
- [ ] **Managing projects and tasks**
- [ ] --- Create/update/delete projects
- [ ] --- Create/update/delete tasks inside of projects
- [ ] --- Set priority, deadline and status (done/not done) for tasks
- [ ] **Validation**
- [ ] --- Server side
- [ ] --- Client side
- [ ] **Automated tests**

## Installation

1. Clone the repo.

```
$ git clone https://github.com/gbarillot/rails-vue-demo-app.git
```

2. Install the needed gems:

```
$ bundle install --without production
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

##### Backend

```
$ rails exec rspec
```

##### Frontend

```
$ ...
```

## Running the app

Run Task Manager App in a local server:

```
$ foreman start
```
