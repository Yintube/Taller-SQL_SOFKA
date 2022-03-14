-- products

SELECT name
FROM mydb.product WHERE mydb.product.id_product
IN(SELECT product_id_product FROM mydb.sale_has_product WHERE sale_has_product.sale_id_sale IN(
SELECT id_sale FROM mydb.sale
WHERE client_document_type = "CC" AND client_id = 10000
));

-- product providers by name of product

SELECT provider.name FROM mydb.provider
WHERE provider.id_provider IN (SELECT provider_id_provider FROM
mydb.provider_has_product WHERE product_id_product IN (SELECT id_product FROM mydb.product
WHERE mydb.product.name = 'Rice - Aborio')
);


-- most sold product

SELECT id_product, name, total FROM
mydb.product
INNER JOIN 
(SELECT product_id_product, COUNT(product_id_product) AS total FROM mydb.sale INNER JOIN mydb.sale_has_product
ON mydb.sale.id_sale = mydb.sale_has_product.sale_id_sale
GROUP BY product_id_product) T ON mydb.product.id_product = T.product_id_product
ORDER BY total DESC;