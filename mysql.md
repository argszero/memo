## 查看各个表占用空间大小
```
SELECT (data_length+index_length)/power(1024,3) size,table_schema,table_name 
FROM information_schema.tables 
ORDER BY size desc limit 10;
```
