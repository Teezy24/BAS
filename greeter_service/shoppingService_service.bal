import ballerina/grpc;
import ballerina/io;

listener grpc:Listener grpcListener = new(9090);

// Define message types

type Product record {
    string name;
    string size;
    decimal price;
    int quantity;
    string sku;
    string product;
    // Add other fields as needed (e.g., description, category)
};

type AddProductRequest record {
    Product product;
    // Add other fields as needed (e.g., quantity, price)
};

type AddProductResponse record {
    string productCode;
};

type CreateUsersRequest record {
    string username;
    string email;
    // Add other user information fields as needed
};

type CreateUsersResponse record {
    CreateUsersRequest[] users;
};

type UpdateProductRequest record {
    string productCode;
    // Add fields for update details (e.g., name, price)
};

type UpdateProductResponse record {
    string productCode;
};

type RemoveProductRequest record {
    string productCode;
    string productList;
};

type RemoveProductResponse record {
    Product[] products;
};

// Define the shopping service
@grpc:ServiceDescriptor {
    descriptor: "shopping.ShoppingService"
}
service "ShoppingService" on grpcListener {

 // Admin operations
    remote function addProduct(AddProductRequest req) returns AddProductResponse {
        if req.product.sku != "" {
            io:println("Adding product: " + req.product.sku);
            AddProductResponse res = { productCode: "" }; 
            res.productCode = "PRODUCT-" + req.product.sku;
            return res;
        } else {
            io:println("Product not provided.");
            AddProductResponse res = { productCode: "" }; 
            res.productCode = "ERROR: No product provided";
            return res;
        }
    }

    remote function createUsers(CreateUsersRequest[] req) returns CreateUsersResponse {
    io:println("Creating users.");

    // Initialize the response with an empty user list
    CreateUsersResponse res = { users: [] };

    // Iterate over the array and add each user to the response
    foreach CreateUsersRequest user in req {
        res.users.push(user);
    }

    return res;
}


    remote function updateProduct(UpdateProductRequest req) returns UpdateProductResponse {
        io:println("Updating product: " + req.productCode);
        UpdateProductResponse res = {productCode: ""};
        res.productCode = "PRODUCT-" + req.productCode;
        return res;
    }

    remote function removeProduct(RemoveProductRequest req) returns RemoveProductResponse {
        io:println("Removing product with SKU: " + req.productCode);
        Product[] remainingProducts = from Product p in productList
        where p.sku != req.productCode select p;


    // Create the response with the remaining products
    RemoveProductResponse res = {products: remainingProducts};
    
    return res;
    }
}