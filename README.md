# SocialConnect

## Overview
SocialConnect is a social networking platform built using Ruby on Rails (RoR). It enables users to connect, interact, and share posts, similar to Facebook. The platform includes features such as user authentication, friendships, posts, likes, comments, and notifications.

## Features
- **User Authentication**: Uses Devise for secure authentication.
- **Friendships**: Users can send, accept, and manage friend requests.
- **Posts & Comments**: Users can create, view, and comment on posts.
- **Likes**: Users can like posts.
- **Notifications**: Users receive notifications for interactions.
- **Admin Panel**: An admin dashboard for user management.
- **PWA Support**: Progressive Web App (PWA) capabilities.

## Directory Structure
```
├── app
│   ├── controllers      # Handles requests and responses
│   ├── models          # Defines database schema and logic
│   ├── views           # Frontend HTML using ERB templates
│   ├── assets          # Images, stylesheets, and JavaScript files
├── config              # Application configuration files
├── db                  # Database migrations and schema
├── public              # Static files and error pages
├── test                # Automated test cases
├── log                 # Application logs
```

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/social-connect.git
   cd social-connect
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Set up the database:
   ```sh
   rails db:create db:migrate db:seed
   ```
4. Start the server:
   ```sh
   rails server
   ```
5. Open `http://localhost:3000` in your browser.

## API Routes
- `GET /posts` - View all posts
- `POST /posts` - Create a new post
- `DELETE /posts/:id` - Delete a post
- `POST /friendships` - Send a friend request
- `DELETE /friendships/:id` - Remove a friend
- `GET /notifications` - View notifications

## Deployment
To deploy, configure the `deploy.yml` file and run:
```sh
bin/kamal deploy
```

## Technologies Used
- **Ruby on Rails** (Backend framework)
- **PostgreSQL** (Database)
- **Devise** (Authentication)
- **Active Storage** (File uploads)
- **PWA** (Progressive Web App support)
- **Bootstrap** (Frontend styling)

## Contribution
1. Fork the repository
2. Create a new feature branch
3. Commit changes and push
4. Submit a pull request

