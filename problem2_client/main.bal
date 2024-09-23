import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    string continueworking = "y";
    while continueworking.equalsIgnoreCaseAscii("y") {
        io:println("What would you like to do?");
        io:println("1. Add a new product");
        io:println("2. Update an existing product");
        io:println("3. Remove a product");
        io:println("4. List all available products");
        io:println("5. Search for a product");
        io:println("6. Add a product to the cart");
        io:println("7. Place an order");
        io:println("8. Create a new user account");
        
        string choice = io:readln("Enter your choice (1-8): ");
        
        if choice == "1" {
            string name = io:readln("What's the product name? ");
            string description = io:readln("Give me a short description: ");
            float price = check 'float:fromString(io:readln("How much does it cost? "));
            int stock_quantity = check 'int:fromString(io:readln("How many are in stock? "));
            string sku = io:readln("Enter a unique SKU for the product: ");
            string statusInput = io:readln("Is it available or out of stock? (AVAILABLE/OUT_OF_STOCK) ");
            ProductStatus status = statusInput.toUpperAscii() == "AVAILABLE" ? AVAILABLE : OUT_OF_STOCK;
            
            AddProductRequest addProductRequest = {product: {name, description, price, stock_quantity, sku, status}};
            AddProductResponse addProductResponse = check ep->addProduct(addProductRequest);
            io:println("Product added successfully: ", addProductResponse);

        } else if choice == "2" {
            string name = io:readln("What's the name of the product you want to update? ");
            string description = io:readln("Give me the new description: ");
            float price = check 'float:fromString(io:readln("What's the new price? "));
            int stock_quantity = check 'int:fromString(io:readln("What's the new stock quantity? "));
            string sku = io:readln("Enter the SKU of the product to update: ");
            string statusInput = io:readln("Is it now available or out of stock? (AVAILABLE/OUT_OF_STOCK) ");
            ProductStatus status = statusInput.toUpperAscii() == "AVAILABLE" ? AVAILABLE : OUT_OF_STOCK;
            
            UpdateProductRequest updateProductRequest = {product: {name, description, price, stock_quantity, sku, status}};
            UpdateProductResponse updateProductResponse = check ep->updateProduct(updateProductRequest);
            io:println("Product updated: ", updateProductResponse);

        } else if choice == "3" {
            string sku = io:readln("What's the SKU of the product you want to remove? ");
            RemoveProductRequest removeProductRequest = {sku};
            RemoveProductResponse removeProductResponse = check ep->removeProduct(removeProductRequest);
            io:println("Product removed: ", removeProductResponse);

        } else if choice == "4" {
            string message = io:readln("Got a message you want to send with the request? (Or press Enter to skip): ");
            ListAvailableProductsRequest listAvailableProductsRequest = {message};
            ListAvailableProductsResponse listAvailableProductsResponse = check ep->listAvailableProducts(listAvailableProductsRequest);
            io:println("Here are the available products: ", listAvailableProductsResponse);

        } else if choice == "5" {
            string sku = io:readln("What's the SKU of the product you're searching for? ");
            SearchProductRequest searchProductRequest = {sku};
            SearchProductResponse searchProductResponse = check ep->searchProduct(searchProductRequest);
            io:println("Product details: ", searchProductResponse);

        } else if choice == "6" {
            string user_id = io:readln("What's your user ID? ");
            string sku = io:readln("What's the SKU of the product you want to add to your cart? ");
            AddToCartRequest addToCartRequest = {user_id, sku};
            AddToCartResponse addToCartResponse = check ep->addToCart(addToCartRequest);
            io:println("Product added to cart: ", addToCartResponse);

        } else if choice == "7" {
            string user_id = io:readln("What's your user ID? ");
            string name = io:readln("What's the product name you're ordering? ");
            string description = io:readln("Describe the product: ");
            float price = check 'float:fromString(io:readln("How much is the product? "));
            int stock_quantity = check 'int:fromString(io:readln("How many are you ordering? "));
            string sku = io:readln("What's the product's SKU? ");
            string statusInput = io:readln("Is it available or out of stock? (AVAILABLE/OUT_OF_STOCK) ");
            ProductStatus status = statusInput.toUpperAscii() == "AVAILABLE" ? AVAILABLE : OUT_OF_STOCK;
            
            PlaceOrderRequest placeOrderRequest = {user_id, products: [{name, description, price, stock_quantity, sku, status}]};
            PlaceOrderResponse placeOrderResponse = check ep->placeOrder(placeOrderRequest);
            io:println("Order placed: ", placeOrderResponse);

        } else if choice == "8" {
            string username = io:readln("Choose a username: ");
            string password = io:readln("Create a password: ");
            string userTypeInput = io:readln("Are you signing up as a 'CUSTOMER' or 'ADMIN'? ");
            UserType user_type = userTypeInput.toUpperAscii() == "ADMIN" ? ADMIN : CUSTOMER;
            
            CreateUserRequest createUsersRequest = {username, password, user_type};
            CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
            check createUsersStreamingClient->sendCreateUserRequest(createUsersRequest);
            check createUsersStreamingClient->complete();
            CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
            io:println("Account created: ", createUsersResponse);
        }

        continueworking = io:readln("Do you want to continue working(y/n): ");
    }
}