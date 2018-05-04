# Rails Engine
This Rails-based API allows a user or application to consume sales engine data for merchants, items, invoices, invoice items, transactions, and customers. Setup and other instructions, including information regarding each of the available endpoints, are detailed below.

### Contributors
[Adam Conway](http://www.github.com/adam-conway)

[Andrew Piermarini](http://www.github.com/agpiermarini)

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
$ rake db:{create, migrate}
$ rake import:all
```

Then spin up a server:

```
$ rails s
```

### Endpoints
*:id should be substituted with an integer corresponding to the desired merchant*

#### Merchant
**Index** http://localhost:3000/api/v1/merchants
```
Status Code: 200
```
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

**Show** http://localhost:3000/api/v1/merchants/:id
```
Status Code: 200
```
```
{
  id: 1,
  name: "Schroeder-Jerde"
}
```

##### Merchant Relationships
**Invoices Associated with a Merchant**
http://localhost:3000/api/v1/merchants/:id/invoices
```
Status Code: 200
```
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

**Items Associated with a Merchant**
http://localhost:3000/api/v1/merchants/:id/items
```
Status Code: 200
```
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

##### Merchant Queries

##### *All Merchants*
**Top Merchants Ranked by Total Revenue**
http://localhost:3000/api/v1/merchants/most_revenue?quantity=x
*Where X is the number of merchants you would like to be returned*

```
Status Code: 200
```
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
http://localhost:3000/api/v1/merchants/revenue?date=x
*Where X is the date passed in 'YYYY-MM-DD' format*

```
Status Code: 200

```
```
{
  total_revenue: "2495397.37"
}
```

**Top Merchants Ranked by Total Number of Items Sold**
http://localhost:3000/api/v1/merchants/most_items?quantity=x
*Where X is the total number of merchants you would like to be returned*

```
Status Code: 200
```
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

##### *Single Merchant*
*:id should be substituted with an integer corresponding to the desired merchant*

**Total Revenue for a Merchant Across Successful Transactions**
http://localhost:3000/api/v1/merchants/:id/revenue
```
Status Code: 200
```
```
{
  revenue: "528774.64"
}
```


**Total Revenue for a Merchant for a Specific Invoice Date**
*Where X is the date passed in 'YYYY-MM-DD' format*
http://localhost:3000/api/v1/merchants/:id/revenue?date=x
```
Status Code: 200
```
```
{
  revenue: "2708.26"
}
```

**Customers with Unpaid Invoices for a Given Merchant**
http://localhost:3000/api/v1/merchants/:id/customers_with_pending_invoices
```
Status Code: 200
```
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

**Customer with Highest Number of Successful Transactions for a Given Merchant**
http://localhost:3000/api/v1/merchants/:id/favorite_customer
```
Status Code: 200
```
```
{
  first_name: "Carmella",
  id: 787,
  last_name: "Zulauf"
}
```

#### Item
**Index** http://localhost:3000/api/v1/items
```
Status Code: 200
```
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

**Show** http://localhost:3000/api/v1/items/:id
```
Status Code: 200
```
```
{
  id: 1,
  name: "Item Qui Esse",
  description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
  merchant_id: 1,
  unit_price: "751.07"
}
```

##### Item Relationships
**Invoice Items Associated with an Item**
http://localhost:3000/api/v1/items/:id/invoice_items

```
Status Code: 200
```
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
**Merchant Associated with an Item**
http://localhost:3000//api/v1/items/:id/merchant
```
Status Code: 200
```
```
{
  id: 1,
  name: "Schroeder-Jerde"
}
```

##### Item Queries

#### Invoice
**Index**
**Show**
##### Invoice Relationships
##### Invoice Queries

#### Invoice Item
**Index**
**Show**
##### Invoice Item Relationships
**Invoice Associated with Invoice Item** http://localhost:3000/api/v1/invoice_items/:id/invoice
```
Status Code: 200
```
```
{
  id: 1,
  customer_id: 1,
  merchant_id: 26,
  status: "shipped"
}
```

**Item Associated with Invoice Item**
http://localhost:3000/api/v1/invoice_items/:id/item
```
Status Code: 200
```
```
{
  id: 539,
  name: "Item Sunt Saepe",
  description: "Quibusdam aut qui. Sint repudiandae et dolor quo. Et nihil qui beatae est ipsam quo corrupti. Voluptatibus ut pariatur dolorem nostrum temporibus magnam enim. Quia nisi voluptate aperiam vel et.",
  merchant_id: 26,
  unit_price: "136.35"
}
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


# Versions
Ruby 2.4.1  
Ruby on Rails 5.1.6
ActiveRecord VERSION




* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
