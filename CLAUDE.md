# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Server and Asset Compilation
- `bin/dev` - Start development server with Tailwind CSS watching (uses Procfile.dev)
- `bin/rails server` - Start Rails server only
- `bin/rails tailwindcss:watch` - Watch and compile Tailwind CSS changes

### Database Operations
- `bin/rails db:create` - Create development and test databases
- `bin/rails db:migrate` - Run pending migrations
- `bin/rails db:seed` - Seed database with initial data
- `bin/rails db:setup` - Create, migrate, and seed database

### Testing
- `bin/rails test` - Run all tests using Minitest
- `bin/rails test test/models/user_test.rb` - Run specific test file
- `bin/rails test:system` - Run system tests with Capybara/Selenium

### Code Quality
- `bin/rubocop` - Run RuboCop linter (Rails Omakase configuration)
- `bin/brakeman` - Run security vulnerability analysis

## Application Architecture

### Multi-Tenant Account System
This Rails 8 application implements a multi-tenant architecture:

- **Users** can belong to multiple **Accounts** through **AccountUsers** join table
- Each **Account** has an owner (User) and can have multiple members with roles (admin/member)
- **Invitations** system allows account owners/admins to invite users to accounts
- Authentication uses session-based system with `has_secure_password` and custom session management

### Key Models and Relationships
- `User` - Core user model with secure password, has many accounts through account_users
- `Account` - Tenant model with slug-based routing, belongs to owner (User)
- `AccountUser` - Join table defining user roles within accounts (admin/member)
- `Invitation` - Invitation system for adding users to accounts
- `Session` - Custom session management for authentication

### Authentication & Authorization
- Custom authentication system in `app/controllers/concerns/authentication.rb`
- Session-based with signed cookies
- Admin impersonation functionality included
- Account-level authorization methods in ApplicationController
- Route-level authentication with `allow_unauthenticated_access` class method

### Technology Stack
- Rails 8.0.2 with SQLite3 database
- Hotwire (Turbo + Stimulus) for frontend interactions
- Tailwind CSS for styling
- Importmap for JavaScript module management
- Solid Cache/Queue/Cable for caching, jobs, and real-time features
- Image processing with Active Storage
- Instrumental Components gem for UI components

### Routing Patterns
Routes are organized by account slug (`:account_slug` parameter):
- Account-scoped routes: `/:account_slug/members`, `/:account_slug/invitations`
- Admin routes: `/admin/*` for system administration
- User profile routes: `/users/*` for profile management
- Authentication routes: `/login`, `/signup`, `/passwords`

### Testing Framework
Uses Minitest with parallel test execution and system testing via Capybara/Selenium.


## Goal of this application

This application is a Rails 8.0.2 application for creating biographies of people. Main idea is to give a user a pre-defined template to start writing a biography of a person. Using AI, user will be provided with a ai generated enhanced story in each section given only some basic information about the given subject.

1. Set of pre-defined chapter ideas are provided to the user.
   1. 머릿말
   2. 태어난 곳 이야기
   3. 어린 시절
   4. 학교생활
      1. 초등학교
      2. 중학교
      3. 고등학교
   5. 직업생활
      1. 첫 직업
      2. 두 번째 직업
      3. 세 번째 직업
   6. 개인생활
      1. 가족
         1. 어떻게 부인과 만나게 되었는지
         2. 아이들
         3. 동물
      2. 친구
      3. 관계
         1. 좋아하는 친구
         2. 싫어하는 친구
         
      4. 취미
         1. 좋아하는 취미
         2. 싫어하는 취미
   6. 성취
   7. 개인 철학
   8. 영향
2. 
3. User can select ones that he/she wants to include in the biography.
4. User can generate sub-sections within each chapter idea.
5. User can also add new chapter ideas to the biography.
6. User can also re-arrange the order of the chapters.
7. User can also delete the chapters.
8. User can also edit the chapters.
9.  User can also add images to the chapters.

## Tech Stack
- Rails 8.0.2 with SQLite3 database
- Hotwire (Turbo + Stimulus) for frontend interactions
- Tailwind CSS for styling
- Importmap for JavaScript module management
- Solid Cache/Queue/Cable for caching, jobs, and real-time features
- Image processing with Active Storage
- Instrumental Components gem for UI components
  - instrumental authentication
  - instrumental teams
  - instrumental commerce
  - instrumental components
  - instrumental scaffolding
  - instrumental search
  - instrumental ai integration
- sqlite3 for database
- solid_queue for background jobs
- solid_cache for caching
- solid_cable for real-time features
- instrumental_components for UI components
- action_text for rich text editing
- active_storage for image processing
- positioning gem for reordering
- most of it is already provided by Instrumental gem

## Models
### User
### Account
### AccountUser
### Invitation
### Session

### Book
- title
- subtitle
- slug
- author


```
rails g instrumental:scaffold book title:string subtitle:string slug:string author:string 


```
### Chapter
has many Sections
- position:integer
- title


```
rails g instrumental:scaffold chapter position:integer title:string book
:references

```

### Section

```
rails g instrumental:scaffold section position:integer title:string chapter:references

belongs to Chapter
has_many key_words
sample_story:text
body:text

### Key

```

belongs to Section
- word:string

## Workflow

### login
1. user logs in
2. user is taken to the dashboard
3. User can view a tutorial on how to use the application
### create a book
1. user clicks on the create a book button
2. user is taken to the create a book page
3. user fills in the book details
4. user clicks on the create book button
5. user is taken to the book page

### create a chapter
1. User is shown a list of chapters
2. User can click on the the check box to select the chapter
3. User can click on the create a chapter button
4. User is taken to the create a chapter page
5. User fills in the chapter details
6. User clicks on the create chapter button
7. User is taken to the chapter page

### create a section
1. user clicks on the create a section button
2. user is taken to the create a section page
3. user fills in the section details
4. user clicks on the create section button
5. user is taken to the section page

### create a section
1. the idea is to user writes couple of key words into key_words field.
2. User then clicks on the AI button to generate a sample story.
3. AI makes up a short sample story based on the key words and provides it to the user to start writing a biography of a person.
4. User can then fill in the body field with the story and edit more text to make it better.
5. User can also add images to the section.
6. User can also ask AI to enhance the story, by clicking on the AI button.


### create seed data for books
1. create 4 sample book content
2. create 20 sample chapters
3. create 5 sample sections for each chapter topics
4. create 20 sample key words for each section
