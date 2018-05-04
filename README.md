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

### Endpoints
*:id should be substituted with an integer corresponding to the desired merchant*

#### Merchant Endpoints
**Merchant Index**

Request URL
```
http://localhost:3000/api/v1/merchants
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
http://localhost:3000/api/v1/merchants/:id
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


##### Merchant Relationships
**Invoices Associated with a Merchant**

Request URL
```
http://localhost:3000/api/v1/merchants/:id/invoices
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
http://localhost:3000/api/v1/merchants/:id/items
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

##### Merchant Queries

##### *All Merchants*
**Top Merchants Ranked by Total Revenue**

Request URL
```
http://localhost:3000/api/v1/merchants/most_revenue?quantity=x
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
http://localhost:3000/api/v1/merchants/revenue?date=x
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
http://localhost:3000/api/v1/merchants/most_items?quantity=x
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
http://localhost:3000/api/v1/merchants/:id/revenue
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
http://localhost:3000/api/v1/merchants/:id/revenue?date=x
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
http://localhost:3000/api/v1/merchants/:id/customers_with_pending_invoices
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
http://localhost:3000/api/v1/merchants/:id/favorite_customer
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
http://localhost:3000/api/v1/items
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
http://localhost:3000/api/v1/items/:id
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

##### Item Relationships
**Invoice Items Associated with an Item**

Request URL
```
http://localhost:3000/api/v1/items/:id/invoice_items
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
http://localhost:3000//api/v1/items/:id/merchant
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

##### Item Queries
##### *Single Item*
*:id should be substituted with an integer corresponding to the desired item*

##### *All Items*


#### Invoice Endpoints
**Invoice Index**
**Invoice Show**
##### Invoice Relationships
##### Invoice Queries

#### Invoice Item
**Invoice Item Index**
**Invoice Item Show**
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
http://localhost:3000/api/v1/invoice_items/:id/item
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

##### Invoice Item Queries

#### Transaction
**Index**
**Show**
##### Transaction Relationships
##### Transaction Queries

#### Customer
**Index**
**Show**
##### Customer Relationships
##### Customer Queries

### Contribute

If you would like to contribute to this project, you can fork the repository [here](https://github.com/adam-conway/rails_engine). Pull requests will be considered in kind, but please note that contributions must adhere to a rebase workflow.

This project uses the RSpec test framework. Run tests using the standard `$ rspec` command.

#### Current Contributors
[Adam Conway](http://www.github.com/adam-conway)

[Andrew Piermarini](http://www.github.com/agpiermarini)


# Versions
Ruby 2.4.1  
Ruby on Rails 5.1.6
ActiveRecord VERSION
RSpec VERSION





* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
