# Webhook Delivery System

## Description

This project is a basic Ruby on Rails application with a simple webhook delivery system. The application notifies third-party APIs of data changes via webhooks. The project includes the following features:

- A `DataChange` model with basic validations.
- Endpoints to create and update `DataChange` records.
- Configurable third-party API endpoints.
- Webhook notifications for create and update actions.
- Verification of webhook authenticity.

## Prerequisites

- Ruby (3.1.0 or later)
- Rails (7.0.4 or later)
- SQLite (default database)
- Bundler

## Setup

1. **Clone the repository:**

   ```sh
   git clone https://github.com/your-username/webhook_delivery_system.git
   cd webhook_delivery_system

2. **Install dependencies:**

   ```sh
    bundle install

3. **Configure database:**

    By default, the project is set up to use SQLite. You can change the database settings in config/database.yml if needed.

    ```sh
    rails db:create
    rails db:migrate

4. **Configure credentials:**

    Set up the credentials for the webhook secret. Run the following command and add your secret key:

    ```sh
    EDITOR="vim" rails credentials:edit
    ```
    Add the following line in the opened file:

    ```yaml
    webhook_secret: your_secret_key_here
    ```
    Save and close the file.

## Running the Application
1. Start the Rails server:

    ```sh
    rails server
    ```
    By default, the server runs on http://localhost:3000.

## Testing Endpoints
You can test the `create` and `update` endpoints using `curl` or Postman.

### Create a DataChange
```sh
curl -X POST http://localhost:3000/data_changes -H "Content-Type: application/json" -d '{"data_change": {"name": "Test", "data": "This is a test"}}'
```
### Update a DataChange
Assuming the `id` of the data change you want to update is `1`:

```sh
curl -X PUT http://localhost:3000/data_changes/1 -H "Content-Type: application/json" -d '{"data_change": {"name": "Updated Test", "data": "This is an updated test"}}'
```

## Project Structure
- `app/models/data_change.rb`: The `DataChange` model with validations.
- `app/controllers/data_changes_controller.rb`: The controller handling create and update actions.
- `app/jobs/webhook_notifier_job.rb`: The job that sends webhook notifications.
- `config/routes.rb`: Defines the routes for the `DataChange` endpoints.

## Webhook Notification
The application sends webhook notifications to all configured endpoints whenever a DataChange record is created or updated. Each notification includes a payload and a signature for authenticity verification.