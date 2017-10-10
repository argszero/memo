```@Value```默认只支持```Array```及基本类型，如果需要支持```List\Set```等，有两种方法：

１. 使用```DefaultConversionService```
```
@Bean 
public ConversionService conversionService() {
    return new DefaultConversionService();
}
```
2.　使用EL表达式
```
 @Value("#{'${list.of.strings}'.split(',')}") 
 private List<String> list;
 
 @Value("#{'${set.of.strings}'.split(',')}") 
 private Set<String> list;
```
