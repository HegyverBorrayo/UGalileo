
CREATE TABLE distributors (
    id int NOT NULL,
    slug char(25) NOT NULL,
    name char(50) NOT NULL,
    created_at date NOT NULL,
    created_by char(30) NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE distributor_branches(
    id INT NOT NULL,
    distributor_id INT NOT NULL,
    name char(50) NOT NULL,
    address char(80) NOT NULL,
    created_at date NOT NULL,
    created_by char(30) NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id)
);

CREATE TABLE distributor_products (
    code char(100) NOT NULL,
    distributor_id INT NOT NULL,
    name char(100) NOT NULL,
    status char(20) NOT NULL DEFAULT 'ACTIVE',
    profit_percentage int NOT NULL,
    description char(100) NOT NULL,
    image char(250) NOT NULL,
    created_at date NOT NULL,
    created_by char(30) NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY (code),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id)
);

CREATE TABLE distributor_branch_dally_sales (
    id INT NOT NULL,
    distributor_id INT NOT NULL,
    distributor_branch_id INT NOT NULL,
    product_code char(100) NULL,
    quantity_sale INT NOT NULL,
    total_sale INT NOT NULL,
    created_at date NOT NULL,
    created_by char(30) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id),
    FOREIGN KEY (distributor_branch_id) REFERENCES distributor_branches(id)
);

CREATE TABLE distributor_branch_products(
    id INT NOT NULL,
    distributor_id INT NOT NULL,
    distributor_branch_id INT NOT NULL,
    product_code char(100) NULL,
    minimun_stock_quantity INT NOT NULL DEFAULT 1,
    available_quantity INT NOT NULL DEFAULT 0,
    unit_price float NOT NULL,
    wholesale_price float NOT NULL,
    wholesale_quantity_required INT NOT NULL,
    created_at date NOT NULL,
    created_by date NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id),
    FOREIGN KEY (distributor_branch_id) REFERENCES distributor_branches(id),
    FOREIGN KEY (product_code) REFERENCES distributor_products(code)
);

CREATE TABLE distributor_manufacturers (
    id INT NOT NULL,
    distributor_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    status char(20) NOT NULL DEFAULT 'ACTIVE',
    created_at date NOT NULL,
    created_by date NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id)
);

CREATE TABLE distributor_manufacturer_products (
    id INT NOT NULL,
    distributor_id INT NOT NULL,
    distributor_manufacturer_id INT NOT NULL,
    product_code char(100) NULL,
    created_at date NOT NULL,
    created_by date NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id),
    FOREIGN KEY (distributor_manufacturer_id) REFERENCES distributor_manufacturers(id),
    FOREIGN KEY (product_code) REFERENCES distributor_products(code)
);


CREATE TABLE distributor_manufacturer_orders (
    id INT NOT NULL,
    distributor_id INT NOT NULL,
    distributor_branch_id INT NOT NULL,
    distributor_manufacturer_id INT NOT NULL,
    product_code char(100) NULL,
    status char(20) NOT NULL DEFAULT 'PENDING',
    order_final_status char(20) NOT NULL DEFAULT 'PENDING',
    unit_price float NOT NULL,
    required_quantity INT NOT NULL,
    manufacturer_quantity INT NOT NULL,
    total_price_quantity float NOT NULL,
    created_at date NOT NULL,
    created_by date NOT NULL,
    update_at date NOT NULL,
    update_by char(30) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (distributor_id) REFERENCES distributors(id),
    FOREIGN KEY (distributor_branch_id) REFERENCES distributor_branches(id),
    FOREIGN KEY (distributor_manufacturer_id) REFERENCES distributor_manufacturers(id),
    FOREIGN KEY (product_code) REFERENCES distributor_products(code)
);