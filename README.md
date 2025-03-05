## SocialConnect - A Next-Gen Social Networking Platform

SocialConnect is a feature-rich social networking platform built with Ruby on Rails. It allows users to connect, interact, and share content seamlessly. The platform includes essential social media functionalities such as user authentication, friendships, post creation, likes, comments, and real-time notifications.

### Key Features:
- **User Authentication:** Secure sign-up, login, and password management powered by Devise.
- **Friendships:** Send and accept friend requests, manage connections, and unfriend users.
- **Posts & Comments:** Create and interact with posts, including commenting on friends' updates.
- **Likes & Notifications:** Like posts and receive real-time notifications for user interactions.
- **Admin Panel:** Manage user activities and maintain platform integrity with administrative controls.
- **Progressive Web App (PWA) Support:** Enhancing user experience with offline capabilities and push notifications.

Designed with scalability and performance in mind, SocialConnect leverages PostgreSQL for data management, Active Storage for file handling, and modern front-end technologies to ensure a seamless user experience. Whether you’re looking to build a private social network or scale to a global audience, SocialConnect provides a strong foundation to support your vision.

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

