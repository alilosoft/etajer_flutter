-- migrate:up
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    sale_price MONEY NOT NULL
);

-- migrate:down

