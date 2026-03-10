CREATE TABLE Document_type (

    id_document_type UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_name VARCHAR(50) NOT NULL,
    code VARCHAR(10),
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE Person (

    id_person UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	document_number VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(20),
	address VARCHAR(150),
	created_at TIMESTAMPTZ DEFAULT NOW(),
    id_type_document UUID REFERENCES Document_type(id_document_type)
);

CREATE TABLE Files (

    id_file UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	file_name VARCHAR(100),
	file_path TEXT,
	created_at TIMESTAMPTZ DEFAULT NOW(),
	status BOOLEAN DEFAULT TRUE,
	id_person UUID REFERENCES Person(id_person)
);

CREATE TABLE Roles (

    id_role UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	role_name VARCHAR(50) NOT NULL UNIQUE,
	description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
	status BOOLEAN DEFAULT TRUE
);

CREATE TABLE Modules (

    id_module UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	module_name VARCHAR(50) NOT NULL UNIQUE,
	description TEXT,
	created_at TIMESTAMPTZ DEFAULT NOW(),
	status BOOLEAN DEFAULT TRUE
);

CREATE TABLE App_View (

    id_view UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	view_name VARCHAR(100) NOT NULL,
	route VARCHAR(150),
	created_at TIMESTAMpTZ DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE Users (

    id_user UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
	status BOOLEAN DEFAULT TRUE,
	person_id UUID REFERENCES Person(id_person)
);

CREATE TABLE User_Role (

    id_user_role UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	created_at TIMESTAMPTZ DEFAULT NOW(),
	status BOOLEAN DEFAULT TRUE,
	id_user UUID REFERENCES Users(id_user),
	id_role UUID REFERENCES Roles(id_role)
);

CREATE TABLE Role_Module (

    id_role_module UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	created_at TIMESTAMPTZ DEFAULT NOW(),
	status BOOLEAN DEFAULT TRUE,
	id_role UUID REFERENCES Roles(id_role),
	id_module UUID REFERENCES Modules(id_module),
	UNIQUE(id_role, id_module)
);

CREATE TABLE Modules_Views (

    id_module_view UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
	status BOOLEAN DEFAULT TRUE,
    id_module UUID REFERENCES Modules(id_module),
	id_view UUID REFERENCES App_View(id_view)
);

CREATE TABLE Category (

    id_category UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_name VARCHAR(100) NOT NULL,
	description TEXT,
	status BOOLEAN DEFAULT TRUE
);

CREATE TABLE Supplier (

    id_supplier UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	supplier_name VARCHAR(150) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(100),
	status BOOLEAN DEFAULT TRUE	
);

CREATE TABLE Product (

    id_product UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	product_name VARCHAR(150) NOT NULL,
	description TEXT,
	price INTEGER NOT NULL,
	status BOOLEAN DEFAULT TRUE,
	id_category UUID REFERENCES Category(id_category),
	id_supplier UUID REFERENCES Supplier(id_supplier)
);

CREATE TABLE Inventory (

    id_inventory UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	stock INTEGER NOT NULL,
	last_update TIMESTAMPTZ DEFAULT NOW(),
	status BOOLEAN DEFAULT TRUE,
	id_product UUID REFERENCES Product(id_product)
);

CREATE TABLE Payment_Method (

    id_payment_method UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	name_payment_method VARCHAR(50) NOT NULL,
	status BOOLEAN DEFAULT TRUE
);

CREATE TABLE Customer (

    id_customer UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	status BOOLEAN DEFAULT TRUE,
	id_person UUID REFERENCES Person(id_person)
);

CREATE TABLE Orders (

    id_order UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_date TIMESTAMPTZ DEFAULT NOW(),
	total INTEGER NOT NULL,
	status BOOLEAN DEFAULT TRUE,
	id_customer UUID REFERENCES Customer(id_customer)
);

CREATE TABLE Order_Item (

    id_order_item UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	quantity INTEGER NOT NULL,
	price INTEGER NOT NULL,
	id_order UUID REFERENCES Orders(id_order),
	id_product UUID REFERENCES Product(id_product)
);

CREATE TABLE Invoice (

    id_invoice UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_date TIMESTAMPTZ DEFAULT NOW(),
	total INTEGER NOT NULL,
	status BOOLEAN DEFAULT TRUE,
    id_order UUID REFERENCES Orders(id_order)
);

CREATE TABLE Invoice_Item (

    id_invoice_item UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    quantity INTEGER NOT NULL,
    price INTEGER NOT NULL,
    id_invoice UUID REFERENCES Invoice(id_invoice),
    id_product UUID REFERENCES Product(id_product)
);

CREATE TABLE Payment (

    id_payment UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    amount INTEGER NOT NULL,
	payment_date TIMESTAMPTZ DEFAULT NOW(),
	id_invoice UUID REFERENCES Invoice(id_invoice),
    id_payment_method UUID REFERENCES Payment_Method(id_payment_method) 
);


INSERT INTO Document_type (document_name, code, status)
VALUES ('Tarjeta de Identidad','TI',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Tarjeta de Identidad','TI',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Tarjeta de Identidad','TI',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Tarjeta de Identidad','TI',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Tarjeta de Identidad','TI',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Cédula de Ciudadanía','CC',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Cédula de Ciudadanía','CC',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Cédula de Ciudadanía','CC',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Cédula de Ciudadanía','CC',TRUE);

INSERT INTO Document_type (document_name, code, status)
VALUES ('Cédula de Ciudadanía','CC',TRUE);



INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Juan','Perez','10001','3101111111','Barrio Centro',
(SELECT id_document_type FROM Document_type LIMIT 1));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Maria','Gomez','10002','3101111112','Barrio Calixto',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 1));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Carlos','Rodriguez','10003','3101111113','Barrio Tenerife',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 2));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Laura','Martinez','10004','3101111114','Barrio Altico',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 3));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Andres','Lopez','10005','3101111115','Barrio Obrero',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 4));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Sofia','Ramirez','10006','3101111116','Barrio Cándido',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 5));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Miguel','Torres','10007','3101111117','Barrio Quirinal',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 6));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Valentina','Castro','10008','3101111118','Barrio Canaima',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 7));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Camilo','Hernandez','10009','3101111119','Barrio Santa Ines',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 8));

INSERT INTO Person (first_name,last_name,document_number,phone,address,id_type_document)
VALUES ('Daniela','Vargas','10010','3101111120','Barrio Las Palmas',
(SELECT id_document_type FROM Document_type LIMIT 1 OFFSET 9));


INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto1.jpg','/files/foto1.jpg',(SELECT id_person FROM Person LIMIT 1));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto2.jpg','/files/foto2.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 1));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto3.jpg','/files/foto3.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 2));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto4.jpg','/files/foto4.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 3));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto5.jpg','/files/foto5.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 4));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto6.jpg','/files/foto6.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 5));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto7.jpg','/files/foto7.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 6));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto8.jpg','/files/foto8.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 7));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto9.jpg','/files/foto9.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 8));

INSERT INTO Files (file_name,file_path,id_person)
VALUES ('foto10.jpg','/files/foto10.jpg',(SELECT id_person FROM Person LIMIT 1 OFFSET 9));


INSERT INTO Roles (role_name,description,status)
VALUES ('Administrador','Control total del sistema',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Cajero','Registra ventas del cafetin',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Inventario','Control de productos',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Supervisor','Supervisa ventas',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Auxiliar','Atiende el cafetin',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Instructor','Usuario del sistema',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Aprendiz','Cliente del cafetin',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Contador','Consulta reportes',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Gerente','Control general',TRUE);

INSERT INTO Roles (role_name,description,status)
VALUES ('Invitado','Acceso limitado',TRUE);


INSERT INTO Modules (module_name,description)
VALUES ('Ventas','Registro de ventas');

INSERT INTO Modules (module_name,description)
VALUES ('Inventario','Control de stock');

INSERT INTO Modules (module_name,description)
VALUES ('Productos','Gestion de productos');

INSERT INTO Modules (module_name,description)
VALUES ('Clientes','Gestion de clientes');

INSERT INTO Modules (module_name,description)
VALUES ('Proveedores','Gestion proveedores');

INSERT INTO Modules (module_name,description)
VALUES ('Facturacion','Generacion de facturas');

INSERT INTO Modules (module_name,description)
VALUES ('Pagos','Registro de pagos');

INSERT INTO Modules (module_name,description)
VALUES ('Reportes','Reportes del sistema');

INSERT INTO Modules (module_name,description)
VALUES ('Seguridad','Usuarios y roles');

INSERT INTO Modules (module_name,description)
VALUES ('Configuracion','Configuracion general');


INSERT INTO App_View (view_name,route)
VALUES ('Dashboard','/dashboard');

INSERT INTO App_View (view_name,route)
VALUES ('Ventas','/ventas');

INSERT INTO App_View (view_name,route)
VALUES ('Productos','/productos');

INSERT INTO App_View (view_name,route)
VALUES ('Inventario','/inventario');

INSERT INTO App_View (view_name,route)
VALUES ('Clientes','/clientes');

INSERT INTO App_View (view_name,route)
VALUES ('Proveedores','/proveedores');

INSERT INTO App_View (view_name,route)
VALUES ('Facturas','/facturas');

INSERT INTO App_View (view_name,route)
VALUES ('Pagos','/pagos');

INSERT INTO App_View (view_name,route)
VALUES ('Reportes','/reportes');

INSERT INTO App_View (view_name,route)
VALUES ('Usuarios','/usuarios');


INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1),
(SELECT id_view FROM App_View LIMIT 1)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 1),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 1)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 2),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 2)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 3),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 3)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 4),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 4)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 5),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 5)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 6),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 6)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 7),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 7)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 8),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 8)
);

INSERT INTO Modules_Views (id_module,id_view)
VALUES (
(SELECT id_module FROM Modules LIMIT 1 OFFSET 9),
(SELECT id_view FROM App_View LIMIT 1 OFFSET 9)
);



INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1),
(SELECT id_module FROM Modules LIMIT 1)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 1),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 1)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 2),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 2)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 3),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 3)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 4),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 4)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 5),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 5)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 6),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 6)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 7),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 7)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 8),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 8)
);

INSERT INTO Role_Module (id_role,id_module)
VALUES (
(SELECT id_role FROM Roles LIMIT 1 OFFSET 9),
(SELECT id_module FROM Modules LIMIT 1 OFFSET 9)
);



INSERT INTO Users (username,email,user_password,person_id)
VALUES ('juanp','juanp@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('mariag','mariag@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 1));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('carlosr','carlosr@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 2));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('lauram','lauram@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 3));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('andresl','andresl@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 4));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('sofiar','sofiar@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 5));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('miguelt','miguelt@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 6));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('valentinac','valentinac@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 7));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('camiloh','camiloh@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 8));

INSERT INTO Users (username,email,user_password,person_id)
VALUES ('danielav','danielav@mail.com','123456',
(SELECT id_person FROM Person LIMIT 1 OFFSET 9));



INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1),
(SELECT id_role FROM Roles LIMIT 1)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 1),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 1)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 2),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 2)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 3),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 3)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 4),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 4)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 5),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 5)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 6),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 6)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 7),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 7)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 8),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 8)
);

INSERT INTO User_Role (id_user,id_role)
VALUES (
(SELECT id_user FROM Users LIMIT 1 OFFSET 9),
(SELECT id_role FROM Roles LIMIT 1 OFFSET 9)
);


INSERT INTO Category (category_name,description,status)
VALUES ('Café','Bebidas de café',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Bebidas calientes','Chocolate y aromáticas',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Bebidas frías','Jugos y gaseosas',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Panadería','Productos de panadería',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Snacks','Comidas rápidas',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Postres','Dulces y postres',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Sandwich','Sandwich y comidas rápidas',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Promociones','Combos y promociones',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Jugos naturales','Jugos preparados',TRUE);

INSERT INTO Category (category_name,description,status)
VALUES ('Otros','Otros productos',TRUE);


INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Café Colombia SAS','3105551111','contacto@cafecolombia.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Panadería Central','3105552222','ventas@panaderiacentral.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Distribuidora Snacks','3105553333','info@snacks.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Jugos Naturales SAS','3105554444','ventas@jugos.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Dulces del Valle','3105555555','contacto@dulces.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Panificadora Neiva','3105556666','ventas@panneiva.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Distribuidora Bebidas','3105557777','ventas@bebidas.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Productos La Granja','3105558888','info@lagranja.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Comercializadora Sur','3105559999','contacto@sur.com',TRUE);

INSERT INTO Supplier (supplier_name,phone,email,status)
VALUES ('Alimentos del Huila','3105550000','ventas@huila.com',TRUE);



INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Café negro','Café tradicional',1200,
(SELECT id_category FROM Category LIMIT 1),
(SELECT id_supplier FROM Supplier LIMIT 1),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Café con leche','Café con leche caliente',1500,
(SELECT id_category FROM Category LIMIT 1 OFFSET 1),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 1),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Chocolate caliente','Chocolate tradicional',1800,
(SELECT id_category FROM Category LIMIT 1 OFFSET 1),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 2),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Empanada','Empanada de carne',2000,
(SELECT id_category FROM Category LIMIT 1 OFFSET 4),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 3),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Croissant','Pan hojaldrado',2200,
(SELECT id_category FROM Category LIMIT 1 OFFSET 3),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 4),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Jugo de naranja','Jugo natural',2500,
(SELECT id_category FROM Category LIMIT 1 OFFSET 8),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 5),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Galleta chocolate','Galleta dulce',1200,
(SELECT id_category FROM Category LIMIT 1 OFFSET 5),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 6),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Sandwich jamón','Sandwich sencillo',3000,
(SELECT id_category FROM Category LIMIT 1 OFFSET 6),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 7),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Capuccino','Café espumoso',3500,
(SELECT id_category FROM Category LIMIT 1),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 8),
TRUE);

INSERT INTO Product (product_name,description,price,id_category,id_supplier,status)
VALUES ('Combo desayuno','Café + pan',4000,
(SELECT id_category FROM Category LIMIT 1 OFFSET 7),
(SELECT id_supplier FROM Supplier LIMIT 1 OFFSET 9),
TRUE);



INSERT INTO Inventory (stock,id_product,status)
VALUES (50,(SELECT id_product FROM Product LIMIT 1),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (40,(SELECT id_product FROM Product LIMIT 1 OFFSET 1),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (30,(SELECT id_product FROM Product LIMIT 1 OFFSET 2),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (60,(SELECT id_product FROM Product LIMIT 1 OFFSET 3),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (45,(SELECT id_product FROM Product LIMIT 1 OFFSET 4),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (35,(SELECT id_product FROM Product LIMIT 1 OFFSET 5),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (70,(SELECT id_product FROM Product LIMIT 1 OFFSET 6),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (80,(SELECT id_product FROM Product LIMIT 1 OFFSET 7),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (55,(SELECT id_product FROM Product LIMIT 1 OFFSET 8),TRUE);

INSERT INTO Inventory (stock,id_product,status)
VALUES (65,(SELECT id_product FROM Product LIMIT 1 OFFSET 9),TRUE);



INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Efectivo', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Tarjeta Débito', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Tarjeta Crédito', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Nequi', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Daviplata', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Transferencia Bancaria', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Código QR', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Pago Mixto', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Cupón de Descuento', TRUE);

INSERT INTO Payment_Method (name_payment_method, status)
VALUES ('Crédito Cafetín', TRUE);



INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 1));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 2));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 3));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 4));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 5));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 6));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 7));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 8));

INSERT INTO Customer (status, id_person)
VALUES (TRUE,(SELECT id_person FROM Person LIMIT 1 OFFSET 9));



INSERT INTO Orders (total, status, id_customer)
VALUES (8000, TRUE,(SELECT id_customer FROM Customer LIMIT 1));

INSERT INTO Orders (total, status, id_customer)
VALUES (12000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 1));

INSERT INTO Orders (total, status, id_customer)
VALUES (6500, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 2));

INSERT INTO Orders (total, status, id_customer)
VALUES (15000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 3));

INSERT INTO Orders (total, status, id_customer)
VALUES (9000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 4));

INSERT INTO Orders (total, status, id_customer)
VALUES (7000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 5));

INSERT INTO Orders (total, status, id_customer)
VALUES (18000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 6));

INSERT INTO Orders (total, status, id_customer)
VALUES (5000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 7));

INSERT INTO Orders (total, status, id_customer)
VALUES (11000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 8));

INSERT INTO Orders (total, status, id_customer)
VALUES (14000, TRUE,(SELECT id_customer FROM Customer LIMIT 1 OFFSET 9));



INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (1,3000,
(SELECT id_order FROM Orders LIMIT 1),
(SELECT id_product FROM Product LIMIT 1));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (2,2500,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 1),
(SELECT id_product FROM Product LIMIT 1 OFFSET 1));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (1,3500,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 2),
(SELECT id_product FROM Product LIMIT 1 OFFSET 2));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (3,2000,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 3),
(SELECT id_product FROM Product LIMIT 1 OFFSET 3));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (2,3000,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 4),
(SELECT id_product FROM Product LIMIT 1 OFFSET 4));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (1,4000,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 5),
(SELECT id_product FROM Product LIMIT 1 OFFSET 5));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (2,3500,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 6),
(SELECT id_product FROM Product LIMIT 1 OFFSET 6));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (1,2500,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 7),
(SELECT id_product FROM Product LIMIT 1 OFFSET 7));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (2,2800,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 8),
(SELECT id_product FROM Product LIMIT 1 OFFSET 8));

INSERT INTO Order_Item (quantity, price, id_order, id_product)
VALUES (1,3200,
(SELECT id_order FROM Orders LIMIT 1 OFFSET 9),
(SELECT id_product FROM Product LIMIT 1 OFFSET 9));



INSERT INTO Invoice (total, status, id_order)
VALUES (8000, TRUE,(SELECT id_order FROM Orders LIMIT 1));

INSERT INTO Invoice (total, status, id_order)
VALUES (12000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 1));

INSERT INTO Invoice (total, status, id_order)
VALUES (6500, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 2));

INSERT INTO Invoice (total, status, id_order)
VALUES (15000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 3));

INSERT INTO Invoice (total, status, id_order)
VALUES (9000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 4));

INSERT INTO Invoice (total, status, id_order)
VALUES (7000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 5));

INSERT INTO Invoice (total, status, id_order)
VALUES (18000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 6));

INSERT INTO Invoice (total, status, id_order)
VALUES (5000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 7));

INSERT INTO Invoice (total, status, id_order)
VALUES (11000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 8));

INSERT INTO Invoice (total, status, id_order)
VALUES (14000, TRUE,(SELECT id_order FROM Orders LIMIT 1 OFFSET 9));



INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (8000,
(SELECT id_invoice FROM Invoice LIMIT 1),
(SELECT id_payment_method FROM Payment_Method LIMIT 1));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (12000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 1),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 1));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (6500,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 2),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 2));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (15000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 3),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 3));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (9000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 4),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 4));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (7000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 5),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 5));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (18000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 6),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 6));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (5000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 7),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 7));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (11000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 8),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 8));

INSERT INTO Payment (amount, id_invoice, id_payment_method)
VALUES (14000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 9),
(SELECT id_payment_method FROM Payment_Method LIMIT 1 OFFSET 9));


INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (1,3000,
(SELECT id_invoice FROM Invoice LIMIT 1),
(SELECT id_product FROM Product LIMIT 1));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (2,2500,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 1),
(SELECT id_product FROM Product LIMIT 1 OFFSET 1));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (1,3500,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 2),
(SELECT id_product FROM Product LIMIT 1 OFFSET 2));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (3,2000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 3),
(SELECT id_product FROM Product LIMIT 1 OFFSET 3));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (2,3000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 4),
(SELECT id_product FROM Product LIMIT 1 OFFSET 4));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (1,4000,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 5),
(SELECT id_product FROM Product LIMIT 1 OFFSET 5));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (2,3500,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 6),
(SELECT id_product FROM Product LIMIT 1 OFFSET 6));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (1,2500,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 7),
(SELECT id_product FROM Product LIMIT 1 OFFSET 7));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (2,2800,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 8),
(SELECT id_product FROM Product LIMIT 1 OFFSET 8));

INSERT INTO Invoice_Item (quantity, price, id_invoice, id_product)
VALUES (1,3200,
(SELECT id_invoice FROM Invoice LIMIT 1 OFFSET 9),
(SELECT id_product FROM Product LIMIT 1 OFFSET 9));
