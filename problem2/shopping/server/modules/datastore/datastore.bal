import server.pb as PB;

public table<PB:Product> key(sku) addProduct = table [
    {name: "",description: "",price: 0.0,stock_quantity: 0, sku: ""}

];

public table<PB:Product> key(sku) addToCart = table [


];


// Product table for managing products
public table<PB:Product> key(sku) addProduct = table [
    // Example product (can be removed or customized)
    {name: "Sample Product", description: "Sample Description", price: 100.0, stock_quantity: 50, sku: "SP001"}
];

// Table for managing users and their carts (cart stores SKU and quantity)
public table<username: string, cart: map<string, int>> key(username) users = table [];

// Table for order placements
public table<username: string, orders: map<string, int>> key(username) orders = table [];

// View all available products
public table<string, PB:Product> viewAllProducts = table from var product in addProduct
    select product;

// Search for products based on name (partial match)
public table<string, PB:Product> searchProduct = table from var product in addProduct
    where product.name.toLowerAscii().contains("search_term")
    select product;

// Update product in the product table (replace entire product if it exists)
public table<PB:Product> updateProduct = table from var product in addProduct
    where product.sku == "sku_value_to_update"
    select product;

// Remove product from the product table
public table<string, PB:Product> removeProduct = table from var product in addProduct
    where product.sku != "sku_to_remove"
    select product;

// Add to cart (table maps username to product SKU and quantity)
public table<string, map<string, int>> addToCart = table from var user in users
    select user.cart;

// Place an order for a specific user (move products from cart to order table)
public table<string, map<string, int>> placeOrder = table from var user in users
    select user.orders;
