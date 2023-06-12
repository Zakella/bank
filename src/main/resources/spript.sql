
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          email VARCHAR(100) NOT NULL,
                          mobile_number VARCHAR(20) NOT NULL,
                          pwd VARCHAR(500) NOT NULL,
                          role VARCHAR(100) NOT NULL,
                          create_dt DATE DEFAULT NULL
);

INSERT INTO customer (name, email, mobile_number, pwd, role, create_dt)
VALUES ('Happy', 'happy@example.com', '9876548337', '$2y$12$oRRbkNfwuR8ug4MlzH5FOeui.//1mkd.RsOAJMbykTSupVy.x/vb2', 'admin', CURRENT_DATE);

CREATE TABLE accounts (
                          customer_id INT NOT NULL,
                          account_number INT NOT NULL,
                          account_type VARCHAR(100) NOT NULL,
                          branch_address VARCHAR(200) NOT NULL,
                          create_dt DATE DEFAULT NULL,
                          PRIMARY KEY (account_number),
                          CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

INSERT INTO accounts (customer_id, account_number, account_type, branch_address, create_dt)
VALUES (1, 1865764534, 'Savings', '123 Main Street, New York', CURRENT_DATE);

CREATE TABLE account_transactions (
                                      transaction_id UUID NOT NULL,
                                      account_number INT NOT NULL,
                                      customer_id INT NOT NULL,
                                      transaction_dt DATE NOT NULL,
                                      transaction_summary VARCHAR(200) NOT NULL,
                                      transaction_type VARCHAR(100) NOT NULL,
                                      transaction_amt INT NOT NULL,
                                      closing_balance INT NOT NULL,
                                      create_dt DATE DEFAULT NULL,
                                      PRIMARY KEY (transaction_id),
                                      CONSTRAINT fk_account_number FOREIGN KEY (account_number) REFERENCES accounts (account_number) ON DELETE CASCADE,
                                      CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, CURRENT_DATE - 7, 'Coffee Shop', 'Withdrawal', 30, 34500, CURRENT_DATE - 7);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, CURRENT_DATE - 6, 'Uber', 'Withdrawal', 100, 34400, CURRENT_DATE - 6);

-- Другие запросы INSERT...

CREATE TABLE loans (
                       loan_number SERIAL PRIMARY KEY,
                       customer_id INT NOT NULL,
                       start_dt DATE NOT NULL,
                       loan_type VARCHAR(100) NOT NULL,
                       total_loan INT NOT NULL,
                       amount_paid INT NOT NULL,
                       outstanding_amount INT NOT NULL,
                       create_dt DATE DEFAULT NULL,
                       CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

-- Другие запросы CREATE TABLE и INSERT...

CREATE TABLE cards (
                       card_id SERIAL PRIMARY KEY,
                       card_number VARCHAR(100) NOT NULL,
                       customer_id INT NOT NULL,
                       card_type VARCHAR(100) NOT NULL,
                       total_limit INT NOT NULL,
                       amount_used INT NOT NULL,
                       available_amount INT NOT NULL,
                       create_dt DATE DEFAULT NULL,
                       CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

-- Другие запросы CREATE TABLE и INSERT...

CREATE TABLE notice_details (
                                notice_id SERIAL PRIMARY KEY,
                                notice_summary VARCHAR(200) NOT NULL,
                                notice_details VARCHAR(500) NOT NULL,
                                notic_beg_dt DATE NOT NULL,
                                notic_end_dt DATE DEFAULT NULL,
                                create_dt DATE DEFAULT NULL,
                                update_dt DATE DEFAULT NULL
);

-- Другие запросы CREATE TABLE и INSERT...

CREATE TABLE contact_messages (
                                  contact_id UUID NOT NULL,
                                  contact_name VARCHAR(50) NOT NULL,
                                  contact_email VARCHAR(100) NOT NULL,
                                  subject VARCHAR(500) NOT NULL,
                                  message VARCHAR(2000) NOT NULL,
                                  create_dt DATE DEFAULT NULL,
                                  PRIMARY KEY (contact_id)
);

-- Другие запросы CREATE TABLE и INSERT...
