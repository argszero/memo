## 查看正在运行的sql
```
select * from information_schema.processlist where command !='Sleep';
```

## 查看各个表占用空间大小
```
SELECT (data_length+index_length)/power(1024,3) size,table_schema,table_name 
FROM information_schema.tables 
ORDER BY size desc limit 10;
```

## 释放表空间
?
```
optimize table 
```
