-- migrate:up
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    login TEXT NOT NULL UNIQUE,
    pw TEXT NOT NULL
);

-- migrate:down
DROP TABLE IF EXISTS users;

