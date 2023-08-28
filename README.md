# Health Facilities App
Health facilities is a full-stack web application that leverages GeoDjango, Nginx, Node, and React to visualize the health facilities located in Kenya. The goal of this project is to showcase, to especially beginners and mid-level web developers, the use of backend and frontend technologies in crafting an interactive web application.

![health-facilities](https://github.com/jkariscodes/health-facilities/assets/23359514/2a3c45fb-c4cf-4c75-b4df-eaa690c177a0)


## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

## Features

- Interactive map
- Spatial database
- Scalable frontend and backend apps
- Reverse proxy server
- Containerized services

## Technologies Used

### Frontend

- Node
- React
- Leaflet
- Bootstrap5

### Backend

- Python
- Django
- GeoDjango
- PostGIS

### API Gateway

- Nginx proxy server

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/jkariukidev/health-facilities.git
   cd health-facilities
   
2. Install Docker with these instructions.
3. Rename the [.env_sample](.env_sample) file to .env
4. Populate the .env file with respective values.
5. Build images
   ```bash
   make build
6. Start Postgis, nginx, Django, and client services
    ```bash
    make start services
7. Create tables in the PostGIS database via Django's migrate command.
   ```bash
   make migrate
8. Populate tables with health facilities data
   ```bash
   make load-facilities-data
9. Navigate to http://127.0.0.1/ to view the client app and http://127.0.0.1:8000/api/v1/healthfacilites to view the API.

## Usage

1. __Django Backend__
   * Access the Django admin panel at: http://127.0.0.1:8000/admin/ Create a superuser account to manage the backend: 
           ```python manage.py createsuperuser```
   * Explore the API endpoints. Data API endpoint: http://127.0.0.1:8000/api/v1/healthfacilities/
   * Customize and add your own API endpoints as defined in the Django backend.

2. __React Frontend__
    * Access the React frontend at: http://127.0.0.1/
    * Navigate through the user interface to interact with the app's features.
    * Make HTTP requests to the Django API using libraries like axios or fetch from the frontend code.

Interacting with Both:
* Use the React frontend to send requests to the Django backend's API endpoints.
* Fetch data from the Django backend and display it in the React components.

## API Documentation

This project's API documentation has been generated using:
* __Swagger UI__ which can be accessed at http://127.0.0.1:8000/api/v1/schema/swagger-ui/
* __Redoc__ which is accessed at http://127.0.0.1:8000/api/v1/schema/redoc/

## Contributing

Contributions are welcome! Here's how you can get involved:

1. Fork the repository and create a new branch.
2. Make your changes and test thoroughly.
3. Open a pull request with a clear description of your changes.

## License

This project is licensed under the [MIT License](LICENSE).
