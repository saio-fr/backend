# create a default customer
USE customer;
INSERT INTO Customers VALUES ('181a8024-796e-11e5-8bcf-feff819cdc9f', 'saio', 5, '1446124528', '1446124528');

# create a default user admin
USE user;
INSERT INTO Users VALUES ('3d693d2a-796e-11e5-8bcf-feff819cdc9f', '181a8024-796e-11e5-8bcf-feff819cdc9f', 'dev@saio.fr', '34c6fceca75e456f25e7e99531e2425c6c1de443', 'Raphael', 'Simon', 'http://cdn.saio.fr/avatar', 'null', '1446124528', '1446124528');
