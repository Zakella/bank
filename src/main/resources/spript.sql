
-- CREATE DATABASE If;



DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS authorities CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS account_transactions CASCADE;

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
                          FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
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
                                      FOREIGN KEY (account_number) REFERENCES accounts (account_number) ON DELETE CASCADE,
                                      FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);


INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, current_date - 7, 'Coffee Shop', 'Withdrawal', 30, 34500, current_date - 7);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, current_date - 6, 'Uber', 'Withdrawal', 100, 34400, current_date - 6);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, current_date - 5, 'Self Deposit', 'Deposit', 500, 34900, current_date - 5);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, current_date - 4, 'Ebay', 'Withdrawal', 600, 34300, current_date - 4);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, current_date - 2, 'OnlineTransfer', 'Deposit', 700, 35000, current_date - 2);

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (gen_random_uuid(), 1865764534, 1, current_date - 1, 'Amazon.com', 'Withdrawal', 100, 34900, current_date - 1);

CREATE TABLE loans (
                       loan_number serial NOT NULL,
                       customer_id int NOT NULL,
                       start_dt date NOT NULL,
                       loan_type varchar(100) NOT NULL,
                       total_loan int NOT NULL,
                       amount_paid int NOT NULL,
                       outstanding_amount int NOT NULL,
                       create_dt date DEFAULT NULL,
                       PRIMARY KEY (loan_number),
                       CONSTRAINT loan_customer_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);


INSERT INTO loans (customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
VALUES (1, '2020-10-13'::DATE, 'Home', 200000, 50000, 150000, '2020-10-13'::DATE);

INSERT INTO loans (customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
VALUES (1, '2020-06-06'::DATE, 'Vehicle', 40000, 10000, 30000, '2020-06-06'::DATE);

INSERT INTO loans (customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
VALUES (1, '2018-02-14'::DATE, 'Home', 50000, 10000, 40000, '2018-02-14'::DATE);

INSERT INTO loans (customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
VALUES (1, '2018-02-14'::DATE, 'Personal', 10000, 3500, 6500, '2018-02-14'::DATE);

CREATE TABLE cards (
                       card_id SERIAL NOT NULL,
                       card_number varchar(100) NOT NULL,
                       customer_id int NOT NULL,
                       card_type varchar(100) NOT NULL,
                       total_limit int NOT NULL,
                       amount_used int NOT NULL,
                       available_amount int NOT NULL,
                       create_dt date DEFAULT NULL,
                       PRIMARY KEY (card_id),
                       CONSTRAINT card_customer_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);


INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
VALUES ('4565XXXX4656', 1, 'Credit', 10000, 500, 9500, current_date);

INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
VALUES ('3455XXXX8673', 1, 'Credit', 7500, 600, 6900, current_date);

INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
VALUES ('2359XXXX9346', 1, 'Credit', 20000, 4000, 16000, current_date);

CREATE TABLE notice_details (
                                notice_id SERIAL NOT NULL,
                                notice_summary varchar(200) NOT NULL,
                                notice_details varchar(500) NOT NULL,
                                notic_beg_dt date NOT NULL,
                                notic_end_dt date DEFAULT NULL,
                                create_dt date DEFAULT NULL,
                                update_dt date DEFAULT NULL,
                                PRIMARY KEY (notice_id)
);


INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Home Loan Interest rates reduced', 'Home loan interest rates are reduced as per the government guidelines. The updated rates will be effective immediately',
        current_date - interval '30 days', current_date + interval '30 days', current_date, null);

INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Net Banking Offers', 'Customers who will opt for Internet banking while opening a savings account will get a $50 Amazon voucher',
        current_date - interval '30 days', current_date + interval '30 days', current_date, null);

INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Mobile App Downtime', 'The mobile application of EazyBank will be down from 2AM-5AM on 12/05/2020 due to maintenance activities',
        current_date - interval '30 days', current_date + interval '30 days', current_date, null);

INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('E Auction notice', 'There will be an e-auction on 12/08/2020 on the Bank website for all the stubborn arrears. Interested parties can participate in the e-auction',
        current_date - interval '30 days', current_date + interval '30 days', current_date, null);

INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Launch of Millennia Cards', 'Millennia Credit Cards are launched for the premium customers of EazyBank. With these cards, you will get 5% cashback for each purchase',
        current_date - interval '30 days', current_date + interval '30 days', current_date, null);

INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('COVID-19 Insurance', 'EazyBank launched an insurance policy which will cover COVID-19 expenses. Please reach out to the branch for more details',
        current_date - interval '30 days', current_date + interval '30 days', current_date, null);


CREATE TABLE contact_messages (
                                  contact_id varchar(50) NOT NULL,
                                  contact_name varchar(50) NOT NULL,
                                  contact_email varchar(100) NOT NULL,
                                  subject varchar(500) NOT NULL,
                                  message varchar(2000) NOT NULL,
                                  create_dt date DEFAULT NULL,
                                  PRIMARY KEY (contact_id)
);

CREATE TABLE authorities (
                             id serial NOT NULL,
                             customer_id int NOT NULL,
                             name varchar(50) NOT NULL,
                             PRIMARY KEY (id),
                             CONSTRAINT authorities_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

INSERT INTO authorities (customer_id, name)
VALUES (1, 'VIEWACCOUNT');

INSERT INTO authorities (customer_id, name)
VALUES (1, 'VIEWCARDS');

INSERT INTO authorities (customer_id, name)
VALUES (1, 'VIEWLOANS');

INSERT INTO authorities (customer_id, name)
VALUES (1, 'VIEWBALANCE');

DELETE FROM authorities;

INSERT INTO authorities (customer_id, name)
VALUES (1, 'ROLE_USER');

INSERT INTO authorities (customer_id, name)
VALUES (1, 'ROLE_ADMIN');
