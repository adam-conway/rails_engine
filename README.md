# Rails Engine
This is a Rails-based API that allows a user or application to consume sales engine data for merchants, items, invoices, invoice items, transactions, and customers. Setup and other instructions, including information regarding each of the available endpoints, are detailed below.

### Setup
To use this application, first clone the repository from the following location:

```
$ git clone https://github.com/adam-conway/rails_engine.git
```

From the application directory, run the following commands to install and update all gem dependencies:

```
$ bundle
$ bundle update
```

Next, run the following commands to initialize the database and import CSV data:

```
$ rake db:{create,migrate}
$ rake import:all
```

Then spin up a server:

```
$ rails s
```

### Contribute

For the [repository](https://github.com/adam-conway/rails_engine) if you would like to contribute to this project. Pull requests will be considered in kind, but please note that contributions must adhere to a test-driven, rebase workflow.

This project uses the RSpec test framework. Run tests using the standard `$ rspec` command.

#### Database Schema
![schema](https://github.com/adam-conway/rails_engine/tree/master/public/rails-engine-schema.png)

#### Current Contributors
[Adam Conway](http://www.github.com/adam-conway)

[Andrew Piermarini](http://www.github.com/agpiermarini)

### Versions
Ruby 2.4.1  
Rails 5.1.6
ActiveRecord 5.1.6
RSpec-Rails 3.7.2

### Endpoints
*NOTE: References to `:id` in URLs should be substituted with an integer corresponding to the desired record*

#### Merchant Endpoints
**Merchant Index**

Request URL
```
api/v1/merchants
```

Response Body
```
[
  {
    id: 1,
    name: "Schroeder-Jerde"
  },
  {
    id: 2,
    name: "Klein, Rempel and Jones"
  },
  {
    id: 3,
    name: "Willms and Sons"
  },
  {...}
]
```
Response Code
```
200
```

**Merchant Show**

Request URL
```
api/v1/merchants/:id
```

Response Body
```
{
  id: 1,
  name: "Schroeder-Jerde"
}
```

Response Code
```
200
```

##### Merchant Relationship Endpoints
**Invoices Associated with a Merchant**

Request URL
```
api/v1/merchants/:id/invoices
```

Response Body
```
[
  {
    id: 29,
    customer_id: 7,
    merchant_id: 1,
    status: "shipped"
  },
  {
    id: 137,
    customer_id: 25,
    merchant_id: 1,
    status: "shipped"
  },
  {
    id: 155,
    customer_id: 29,
    merchant_id: 1,
    status: "shipped"
  },
  {...},
]
```

Response Code
```
200
```

**Items Associated with a Merchant**

Request URL
```
api/v1/merchants/:id/items
```

Response Body
```
[
  {
    id: 15,
    name: "Item Rerum Est",
    description: "Nemo voluptatem facere aut quo. Consequatur vel voluptas et. Consequuntur quibusdam ea consectetur accusamus sit optio qui.",
    merchant_id: 1,
    unit_price: "426.29"
  },
  {
    id: 14,
    name: "Item Itaque Consequatur",
    description: "Voluptatibus omnis quo recusandae distinctio voluptatem quibusdam et. Voluptas odio accusamus delectus sunt quia. Non atque rerum vitae officia odit. Magnam iste occaecati in nihil autem saepe.",
    merchant_id: 1,
    unit_price: "398.91"
  },
  {
    id: 13,
    name: "Item Voluptatem Sint",
    description: "Nostrum doloribus quia. Expedita vitae beatae cumque. Aut ut illo aut eum.",
    merchant_id: 1,
    unit_price: "594.54"
  },
  {...},
]
```

Response Code
```
200
```

##### Merchant Business Intelligence Endpoints

##### *All Merchants*
**Top Merchants Ranked by Total Revenue**

Request URL
```
api/v1/merchants/most_revenue?quantity=x
```
*Where X is the number of merchants you would like to be returned*

Response Body
```
[
  {
    id: 14,
    name: "Dicki-Bednar"
  },
  {
    id: 89,
    name: "Kassulke, O'Hara and Quitzon"
  },
  {
    id: 98,
    name: "Okuneva, Prohaska and Rolfson"
  },
  {...}
]
```
**Total Revenue for Date**

Request URL
```
api/v1/merchants/revenue?date=x
```
*Where X is the date passed in 'YYYY-MM-DD' format*

Response Body
```
{
  total_revenue: "2495397.37"
}
```

Response Code
```
200
```

**Top Merchants Ranked by Total Number of Items Sold**

Request URL
```
api/v1/merchants/most_items?quantity=x
```
*Where X is the total number of merchants you would like to be returned*

Response Body
```
[
  {
    id: 89,
    name: "Kassulke, O'Hara and Quitzon"
  },
  {
    id: 12,
    name: "Kozey Group"
  },
  {
    id: 22,
    name: "Thiel Inc"
  },
  {...},
]
```

Response Code
```
200
```

##### *Single Merchant*
*:id should be substituted with an integer corresponding to the desired merchant*

**Total Revenue for a Merchant Across Successful Transactions**

Request URL
```
api/v1/merchants/:id/revenue
```

Response Body
```
{
  revenue: "528774.64"
}
```

Response Code
```
200
```


**Total Revenue for a Merchant for a Specific Invoice Date**

Request URL
```
api/v1/merchants/:id/revenue?date=x
```
*Where X is the date passed in 'YYYY-MM-DD' format*

Response Body
```
{
  revenue: "2708.26"
}
```

Response Code
```
200
```

**Customers with Unpaid Invoices for a Given Merchant**

Request URL
```
api/v1/merchants/:id/customers_with_pending_invoices
```

Response Body
```
[
  {
    first_name: "Rahsaan",
    id: 862,
    last_name: "Fahey"
  },
  {
    first_name: "Marielle",
    id: 826,
    last_name: "Nikolaus"
  },
  {...},
]
```

Response Code
```
200
```

**Customer with Highest Number of Successful Transactions for a Given Merchant**

Request URL
```
api/v1/merchants/:id/favorite_customer
```

Response Body
```
{
  first_name: "Carmella",
  id: 787,
  last_name: "Zulauf"
}
```

Response Code
```
200
```

#### Item Endpoints
**Item Index**

Request URL
```
api/v1/items
```

Response Body
```
[
  {
    id: 1,
    name: "Item Qui Esse",
    description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
    merchant_id: 1,
    unit_price: "751.07"
  },
  {
    id: 2,
    name: "Item Autem Minima",
    description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.",
    merchant_id: 1,
    unit_price: "670.76"
  },
  {..},
]
```

Response Code
```
200
```

**Item Show**

Request URL
```
api/v1/items/:id
```

Response Body
```
{
  id: 1,
  name: "Item Qui Esse",
  description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
  merchant_id: 1,
  unit_price: "751.07"
}
```

Response Code
```
200
```

##### Item Relationship Endpoints
**Invoice Items Associated with an Item**

Request URL
```
api/v1/items/:id/invoice_items
```

Response Body
```
[
  {
    id: 135,
    quantity: 2,
    unit_price: "751.07",
    invoice_id: 29,
    item_id: 1
  },
  {
    id: 645,
    quantity: 7,
    unit_price: "751.07",
    invoice_id: 137,
    item_id: 1
  },
  {...},
]
```

Response Code
```
200
```

**Merchant Associated with an Item**

Request URL
```
api/v1/items/:id/merchant
```

Response Body
```
{
  id: 1,
  name: "Schroeder-Jerde"
}
```

Response Code
```
200
```

##### Item Business Intelligence Endpoints
##### *Single Item*
**Date with the Most Sales for an Associated Item**

Request URL
```
api/v1/items/:id/best_day
```

Response Body
```
{
  best_day: "2012-03-27T08:57:26.000Z"
}
```

Response Code
```
200
```

##### *All Items*
**Top Items Ranked by Total Revenue**

Request URL
```
api/v1/items/most_revenue?quantity=x
```
*Where X is the total number of items you would like to be returned*

Response Body
```
[
  {
    id: 227,
    name: "Item Dicta Autem",
    description: "Fugiat est ut eum impedit vel et. Deleniti quia debitis similique. Sint atque explicabo similique est. Iste fugit quis voluptas. Rerum ut harum sed fugiat eveniet ullam ut.",
    merchant_id: 14,
    unit_price: "853.19"
  },
  {
    id: 2174,
    name: "Item Nam Magnam",
    description: "Eligendi quibusdam eveniet temporibus sed ratione ut magnam. Sit alias et. Laborum dignissimos quos impedit excepturi molestiae.",
    merchant_id: 89,
    unit_price: "788.08"
  },
  {...},
]  
```

Response Code
```
200
```

**Top Items Ranked by Total Number Sold**

Request URL
```
api/v1/items/most_items?quantity=x
```
*Where X is the total number of items you would like to be returned*

Response Body
```
[
  {
    id: 227,
    name: "Item Dicta Autem",
    description: "Fugiat est ut eum impedit vel et. Deleniti quia debitis similique. Sint atque explicabo similique est. Iste fugit quis voluptas. Rerum ut harum sed fugiat eveniet ullam ut.",
    merchant_id: 14,
    unit_price: "853.19"
  },
  {
    id: 2174,
    name: "Item Nam Magnam",
    description: "Eligendi quibusdam eveniet temporibus sed ratione ut magnam. Sit alias et. Laborum dignissimos quos impedit excepturi molestiae.",
    merchant_id: 89,
    unit_price: "788.08"
  },
  {...},
]  
```

Response Code
```
200
```

#### Invoice Endpoints
**Invoice Index**

Request URL
```
api/v1/invoices
```

Response Body
```
[
  {
    id: 1,
    customer_id: 1,
    merchant_id: 26,
    status: "shipped"
  },
  {
    id: 2,
    customer_id: 1,
    merchant_id: 75,
    status: "shipped"
  },
  {},
]    
```

Response Code
```
200
```

**Invoice Show**
Request URL
```
api/v1/invoices/:id
```

Response Body
```
{
  id: 1,
  customer_id: 1,
  merchant_id: 26,
  status: "shipped"
}
```

Response Code
```
200
```

##### Invoice Relationship Endpoints

**Transactions**

Request URL
```
http://localhost:3000/api/v1/invoices/:id/transactions
```

Response Body
```
[
  {
    credit_card_number: "4244851993865068",
    id: 1422,
    invoice_id: 1230,
    result: "success"
  },
  {
    credit_card_number: "4357653120585642",
    id: 1421,
    invoice_id: 1230,
    result: "failed"
  },
  {...}
]
```

Response Code
```
200
```

**Items**

Request URL
```
http://localhost:3000/api/v1/invoices/:id/items
```

Response Body
```
[
  {
    id: 1552,
    name: "Item Ea Consequatur",
    description: "Vero numquam non provident qui error ducimus. Tenetur minima necessitatibus non est. Alias iusto sint perferendis eum.",
    merchant_id: 65,
    unit_price: "759.37"
  },
  {
    id: 1524,
    name: "Item Ea Atque",
    description: "Aspernatur voluptatem natus et ex. Eos molestias quis maxime. Soluta est vel voluptate quisquam eos hic.",
    merchant_id: 65,
    unit_price: "416.19"
  },
  {...}
]
```

Response Code
```
200
```

**Invoice Items**

Request URL
```
http://localhost:3000/api/v1/invoices/:id/invoice_items
```

Response Body
```
[
  {
    id: 5464,
    quantity: 9,
    unit_price: "759.37",
    invoice_id: 1230,
    item_id: 1552
  },
  {
    id: 5463,
    quantity: 3,
    unit_price: "416.19",
    invoice_id: 1230,
    item_id: 1524
  },
  {...}
]
```

Response Code
```
200
```

**Customer**

Request URL
```
http://localhost:3000/api/v1/invoices/:id/customer
```

Response Body
```
{
  first_name: "Emmanuelle",
  id: 238,
  last_name: "Buckridge"
}
```

Response Code
```
200
```

**Merchant**

Request URL
```
http://localhost:3000/api/v1/invoices/:id/merchant
```

Response Body
```
{
  id: 65,
  name: "Hermann, Weimann and Botsford"
}
```

Response Code
```
200
```

#### Invoice Item Endpoints
**Invoice Item Index**

Request URL
```
http://localhost:3000/api/v1/invoice_items
```

Response Body
```
[
  {
    id: 1,
    quantity: 5,
    unit_price: "136.35",
    invoice_id: 1,
    item_id: 539
  },
  {
    id: 2,
    quantity: 9,
    unit_price: "233.24",
    invoice_id: 1,
    item_id: 528
  },
  {...},
]  
```

Response Code
```
200
```

**Invoice Item Show**

Request URL
```
http://localhost:3000/api/v1/invoice_items/:id
```

Response Body
```
{
  id: 1,
  quantity: 5,
  unit_price: "136.35",
  invoice_id: 1,
  item_id: 539
}
```

Response Code
```
200
```

##### Invoice Item Relationships
**Invoice Associated with Invoice Item**

Request URL
```
http://localhost:3000/api/v1/invoice_items/:id/invoice
```

Response Body
```
{
  id: 1,
  customer_id: 1,
  merchant_id: 26,
  status: "shipped"
}
```

Response Code
```
200
```

**Item Associated with Invoice Item**

Request URL
```
api/v1/invoice_items/:id/item
```

Response Body
```
{
  id: 539,
  name: "Item Sunt Saepe",
  description: "Quibusdam aut qui. Sint repudiandae et dolor quo. Et nihil qui beatae est ipsam quo corrupti. Voluptatibus ut pariatur dolorem nostrum temporibus magnam enim. Quia nisi voluptate aperiam vel et.",
  merchant_id: 26,
  unit_price: "136.35"
}
```

Response Code
```
200
```

#### Transaction Endpoints
**Transaction Index**

Request URL
```
http://localhost:3000/api/v1/transactions
```

Response Body
```
[
  {
    credit_card_number: "4654405418249632",
    id: 1,
    invoice_id: 1,
    result: "success"
  },
  {
    credit_card_number: "4580251236515201",
    id: 2,
    invoice_id: 2,
    result: "success"
  },
  {...},
]  
```

Response Code
```
200
```
**Transaction Show**

Request URL
```
http://localhost:3000/api/v1/transactions/:id
```

Response Body
```
{
  credit_card_number: "4654405418249632",
  id: 1,
  invoice_id: 1,
  result: "success"
}  
```

Response Code
```
200
```

##### Transaction Relationship Endpoints

**Invoice**

Request URL
```
http://localhost:3000/api/v1/transactions/:id/invoice
```

Response Body
```
{
  id: 1,
  customer_id: 1,
  merchant_id: 26,
  status: "shipped"
}
```

Response Code
```
200
```

#### Customer Endpoints
**Customer Index**

Request URL
```
http://localhost:3000/api/v1/customers
```

Response Body
```
[
  {
    first_name: "Joey",
    id: 1,
    last_name: "Ondricka"
  },
  {
    first_name: "Cecelia",
    id: 2,
    last_name: "Osinski"
  },
  {...},
]  
```

Response Code
```
200
```

**Customer Show**

Request URL
```
http://localhost:3000/api/v1/customers/:id
```

Response Body
```
{
  first_name: "Joey",
  id: 1,
  last_name: "Ondricka"
}
```

Response Code
```
200
```

##### Customer Relationship Endpoints
**Invoices**

Request URL
```
http://localhost:3000/api/v1/customers/:id/invoices
```

Response Body
```
[
  {
    id: 8,
    customer_id: 1,
    merchant_id: 38,
    status: "shipped"
  },
  {
    id: 7,
    customer_id: 1,
    merchant_id: 44,
    status: "shipped"
  },
  {...},
]  
```

Response Code
```
200
```

**Transactions**

Request URL
```
http://localhost:3000/api/v1/customers/:id/transactions
```

Response Body
```
[
  {
    credit_card_number: "4801647818676136",
    id: 7,
    invoice_id: 8,
    result: "success"
  },
  {
    credit_card_number: "4203696133194408",
    id: 6,
    invoice_id: 7,
    result: "success"
  },
  {...},
]  
```

Response Code
```
200
```

##### Customer Business Intelligence Endpoints

##### *Single Customer*


**Merchant with Whom Customer Has Completed Most Transactions**

Request URL
```
http://localhost:3000/api/v1/customers/:id/favorite_merchant
```

Response Body
```
{
  id: 26,
  name: "Balistreri, Schaefer and Kshlerin"
}
```

Response Code
```
200
```
