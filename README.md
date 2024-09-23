DSA612S - Distributed Systems and Applications
Assignment 1: Restful API & gRPC-based Online Shopping System
Group Members:

Monteo Rossner (223116793)
Lineekela Shinavene (223018953)
Bumai B Ndala (223026859)
Freddy Koita (223042390)
Marleny Dassala (223118524)

Question 1: Restful API for Programme Development and Review Workflow
Overview:
This project implements a Restful API for managing the programme development and review workflow within the Programme Development Unit at Namibia University of Science and Technology. The system provides an interface for adding, updating, deleting, and retrieving programmes along with related functionalities. A web UI was developed to interact with the API using GET and POST methods.

API Functionalities:
Add a new programme
Retrieve a list of all programmes
Update an existing programme
Retrieve details of a specific programme
Delete a programme
Retrieve programmes due for review
Retrieve programmes by faculty
Technologies:
Ballerina: API development.
Website UI: Used to interact with the API.
Postman: For API testing.
Installation and Setup:
Clone the repository:
bash
Copy code
git clone https://github.com/your-repo-url.git
cd your-repo-url
Install Ballerina.
Run the API:
bash
Copy code
ballerina run main.bal
The API is accessible at http://localhost:8080/.
API Endpoints:
POST /programmes
GET /programmes
GET /programmes/{code}
PUT /programmes/{code}
DELETE /programmes/{code}
GET /programmes/review
GET /programmes/faculty/{faculty}


Question 2: Online Shopping System using gRPC
Overview:
This part of the project involves the design and implementation of an online shopping system using gRPC, enabling customers and admins to interact with the system. Admins can manage product inventory, and customers can place orders. All remote calls are handled via gRPC in the Ballerina language.

gRPC Operations:
add_product: Admin adds a new product (with name, description, price, stock, SKU, and status).
create_users: Streams multiple users (customers or admins) to the server.
update_product: Admin updates product details.
remove_product: Admin removes a product and returns the updated product list.
list_available_products: Customers view available products.
search_product: Customers search for a product by SKU.
add_to_cart: Customers add products to their cart using user ID and SKU.
place_order: Customers place an order for products in their cart.
Technologies:
gRPC with Protocol Buffers: Defines the remote interface.
Ballerina: Implements both the server-side logic and client interactions.
Installation and Setup:
Clone the repository:
bash
Copy code
git clone https://github.com/your-repo-url.git
cd your-repo-url
Ensure that Ballerina and gRPC tools are installed.
Generate the gRPC code from the protocol buffer contract.
Run the gRPC server:
bash
Copy code
ballerina run grpc_server.bal
Execute the gRPC client to interact with the server:
bash
Copy code
ballerina run grpc_client.bal
Future Improvements:
Enhance security with authentication for gRPC endpoints.
Implement persistent storage for orders and product details.
Expand user functionality to allow customers to track order history.
