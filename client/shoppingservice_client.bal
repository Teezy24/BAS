import ballerina/grpc;
import ballerina/io;
import ballerina/protobuf;

ShoppingServiceClient ep = check new ("http://localhost:9090");

function printMenu() {

    io:println("1. Add new product");
    io:println("2. Update existing product");
    io:println("3. Remove existing product");
    io:println("4. View all available products");
    io:println("5. Search for a product");
    io:println("6. Add to my cart");
    io:println("7. Place my order");
    io:println("8. Create users");
}

public function main() returns error? {
    string continueworking = "y";
    while continueworking.equalsIgnoreCaseAscii("y") {
        printMenu();
        string option = io:readln("Select option 1-8");

        match option {
            "1" => {
                var product_id = io:readln("Enter Product ID: ");
                var product_name = io:readln("Enter Product Name: ");
                var category = io:readln("Enter Product Category: ");
                var brand = io:readln("Enter Product Brand: ");
                float|error price = float:fromString(io:readln("Enter Product Price: "));
                int|error stock = int:fromString(io:readln("Enter Available Stock: "));
                var description = io:readln("Enter Product Description: ");

                // add_product
                if (price is float && stock is int) {
                    AddProductRequest addProductRequest = {
                        product: {
                            name: product_name,
                            price: price,
                            stock_quantity: stock,
                            description: description,
                            status: "AVAILABLE"
                        }
                    };
                    AddProductResponse AddProductResponse = check ep->addProduct(addProductRequest);
                    io:println(AddProductResponse);
                    continue;
                }
                io:println("Unable to add product:invalid details entered");
                AddProductRequest addProductRequest = {product: {name: product_name, description: description,status: "AVAILABLE"}};
                AddProductResponse addProductResponse = check ep->addProduct(addProductRequest);
                io:println(addProductResponse);
                continue;
            }

            "2" => {
                var product_id = io:readln("Enter Product ID: ");
                var product_name = io:readln("Enter Product Name: ");
                var category = io:readln("Enter Product Category: ");
                var brand = io:readln("Enter Product Brand: ");
                float|error price = float:fromString(io:readln("Enter Product Price: "));
                int|error stock = int:fromString(io:readln("Enter Available Stock: "));
                var description = io:readln("Enter Product Description: ");

                // update_product
                if (price is float && stock is int) {
                    UpdateProductRequest updateProductRequest = {
                        product: {

                            name: product_name,
                            price: price,
                            description: description,
                            status: "AVAILABLE"
                        }
                    UpdateProductResponse updateProductResponse = check ep->updateProduct(updateProductRequest);

                    io:println(UpdateProductResponse);
                    continue;
                }
                io:println("Unable to add product:invalid details entered");
                continue;
            }

            "3" => {

                // remove_product
                var product_id = io:readln("Enter Product ID: ");
                RemoveProductRequest removeProductRequest = {sku: product_id};
                RemoveProductResponse|grpc:Error removeProductResponse = check ep->removeProduct(removeProductRequest);
                if removeProductResponse !is grpc:Error {
                    foreach var item in removeProductResponse.products {
                        io:println(item);

                    }
                }
                continue;
            }

            "4" => {
                // list_available_product
                var product_id = io:readln("Enter Product ID:");
                ListAvailableProductsRequest listAvailableProductsRequest = {};
                ListAvailableProductsResponse listAvailableProductsResponse = check ep->listAvailableProducts(listAvailableProductsRequest);
                if listAvailableProductsResponse !is grpc:Error {
                foreach var item in listAvailableProductsResponse.products { 
                    io:println(item);
                }
                }
                continue;
            }

            "5" => {
                var product_id = io:readln("Enter Product ID: ");

                // search product
                SearchProductRequest searchProductRequest = {sku:" " };
                SearchProductResponse searchProductResponse = check ep->searchProduct(searchProductRequest);
                io:println(searchProductResponse);
                continue;
            }

            "6" => {
                var product_id = io:readln("Enter Product ID: ");
                var user_id = io:readln("Enter Uder ID: ");

                // add_to_cart
                AddToCartRequest addToCartRequest = {user_id: user_id, sku: " "};
                AddToCartResponse addToCartResponse = check ep->addToCart(addToCartRequest);
                io:println("Added to cart successfully");
            }
            

            "7" => {
                // place_order
                 PlaceOrderRequest placeOrderRequest = {user_id: " ", products: [{name:" " , description: "Product Description ", price: 10.0, stock_quantity: 5, sku: " ", status: "AVAILABLE"}]};
                 PlaceOrderResponse placeOrderResponse = check ep->placeOrder(placeOrderRequest);
                 io:println(placeOrderResponse);

                }
                continue;
            }

            "8" => {
                // create_users
                CreateUserRequest createUsersRequest = {
                    username: "",
                    password: "",
                    user_type: CUSTOMER
                    user_type: ADMIN
                };
            }
        }
        CreateUserRequest createUsersRequest = {username: " ", password: " ", user_type: "CUSTOMER",  user_type:"ADMIN"};
        CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
        check createUsersStreamingClient->sendCreateUserRequest(createUsersRequest);
        check createUsersStreamingClient->complete();
        CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
        io:println(createUsersResponse);
        continue;

        continueworking = io:readln("Would you like to continue shopping? (y/n)");
    }
}


