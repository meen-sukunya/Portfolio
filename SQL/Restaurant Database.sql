-- 1. Create tables

CREATE TABLE IF NOT EXISTS Employees (
  EmpId INTEGER NOT NULL,
  EmpName TEXT NOT NULL,
  Position TEXT,
  Salary NUMERIC,
  PRIMARY KEY("EmpId")
);

CREATE TABLE IF NOT EXISTS Customers (
  CustomerId INTEGER NOT NULL,
  FirstName TEXT NOT NULL,
  LastName TEXT,
  Phone TEXT,
  PRIMARY KEY("CustomerId")
);

CREATE TABLE IF NOT EXISTS Category (
  CategoryId INTEGER NOT NULL,
  Names TEXT,
  EmpId INTEGER,
  PRIMARY KEY("CategoryId"),
  FOREIGN KEY (EmpId) REFERENCES Employees(EmpId)
);

CREATE TABLE IF NOT EXISTS Menu (
  MenuId INTEGER NOT NULL,
  MenuName TEXT NOT NULL,
  CategoryId INTEGER,
  Price NUMERIC,
  PRIMARY KEY("MenuId"),
  FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

CREATE TABLE IF NOT EXISTS Orders (
  OrderId INTEGER NOT NULL,
  CustomerId INTEGER,
  MenuId INTEGER,
  Items INTEGER,
  PRIMARY KEY("OrderId"),
  FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
  FOREIGN KEY (MenuId) REFERENCES Menu(MenuId)
);

-- 2. Insert values into tables

INSERT INTO Employees VALUES 
  (1, 'Nattawan', 'Waitress', 17000),
  (2, 'Jirakit', 'Waiter', 17000),
  (3, 'Sarinya', 'Manager', 30000),
  (4, 'Sarut', 'Bartender', 40000),
  (5, 'Sittichai', 'Executive Chef', 50000),
  (6, 'Kittipat', 'Sous Chef', 35000),
  (7, 'Tinapop', 'Dish washer', 15000);
  
INSERT INTO Customers VALUES
  (1, 'Chris', 'Hemsworth', '09 2554 5463'),
  (2, 'Ryan', 'Reynolds', '08 5698 2546'),
  (3, 'Conan', 'Gray', '08 7215 2398'),
  (4, 'Matty', 'Healy', '09 5658 4213');

INSERT INTO Category VALUES
  (1, 'Steak', 5),
  (2, 'Side Dish', 6),
  (3, 'Soups', 6),
  (4, 'Beverages', 4);
  
INSERT INTO Menu VALUES
  (1, 'Pork Chop', 1, 189),
  (2, 'Chicken', 1, 99),
  (3, 'Salmon', 1, 229),
  (4, 'Rib Eye', 1, 239),
  (5, 'French Fried', 2, 59),
  (6, 'Mashed Potato', 2, 69),
  (7, 'Garlic Bread', 2, 49),
  (8, 'Hash Brown', 2, 69),
  (9, 'Fried Onion Rings', 2, 65),
  (10, 'Mushroom Soup', 3, 75),
  (11, 'Corn Soup', 3, 75),
  (12, 'Spinach Soup', 3, 75),
  (13, 'Iced Lemon Tea', 4, 49),
  (14, 'Margarita', 4, 99),
  (15, 'Mojito', 4, 69),
  (16, 'Drinking Water', 4, 20);
  
INSERT INTO Orders VALUES
  (1, 2, 4, 2),
  (2, 1, 6, 1),
  (3, 2, 15, 2),
  (4, 1, 2, 1),
  (5, 3, 14, 1),
  (6, 3, 1, 1),
  (7, 4, 11, 1),
  (8, 4, 3, 2),
  (9, 4, 7, 2),
  (10, 2, 12, 1),
  (11, 4, 13, 2);
  
-- 3. Create a virtual table (VIEW)
 
CREATE VIEW IF NOT EXISTS Restaurant AS
  SELECT
    cus.CustomerId AS id,
    cus.FirstName AS name,
    menu.MenuName AS menu,
    cat.Names AS category,
    emp.EmpName AS chef,
    menu.Price AS price,
    orders.Items AS items,
    menu.Price * orders.Items AS totalPrice
  FROM Customers AS cus
  
  JOIN Orders AS orders ON cus.CustomerId = orders.CustomerId
  JOIN Menu AS menu ON menu.MenuId = orders.MenuId
  JOIN Category AS cat ON cat.CategoryId = menu.CategoryId
  JOIN Employees AS emp ON emp.EmpId = cat.EmpId;
  
-- 4. Extract data from a database
-- 4.1 The customer's order

SELECT 
  name AS customer,
  menu,
  items,
  totalPrice AS price
FROM Restaurant
WHERE name = 'Ryan'; 

-- 4.2 The customer's bill

SELECT 
  name,
  menu,
  items,
  totalPrice,
  sum(totalPrice) OVER() AS netPrice
FROM Restaurant
WHERE name = 'Matty'; 
 
-- 4.3 The employee's duties 

SELECT 
  chef,
  menu,
  items,
  totalPrice
FROM Restaurant
ORDER BY chef;
 
