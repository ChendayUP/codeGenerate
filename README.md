# codeGenerate
### 简单的代码生成器
网络请求json转换成model是纯体力活,一般都是用工具生成,之前用JSON Accelerator进行生成,但是修改起来比较麻烦,看他的源码写的也比较复杂,后来发现了Mustache这个工具,一下就把问题简单化了mustache模板引擎

Mustache介绍与语法

参这篇文章链接

工具介绍

主要利用JSON来生成model和与model对应的TableViewCell的数据绑定,Cell默认model的每一条数据都会对应一个控件,String和Int对应UILabel,图片链接对应UIImageView,可以根据需要修改模板代码

model模板代码如下:

#import <Foundation/Foundation.h>

@interface {{name}}Model : NSObject

{{#properties}}@property (nonatomic, {{#strong}}strong{{/strong}}{{^strong}}assign{{/strong}} ) {{type}} {{#strong}}*{{/strong}}{{typename}};
{{/properties}}
@end
getArray.append(["type":typeName[type] ?? "String",
                             "typename":key,
                             "strong":typestrong[type] ?? true,
                             "image": isImage,
                             "uitype": isImage ? "ImageView" :"Label"])
let dic:[String:Any] = [
    "properties" : getArray,
    "name" : name
]
{{#key}}{{/key}}有两个作用,一个是用数组赋值,一个是表示YES就显示,NO就不显示
{{^key}}{{/key}}表示NO就显示,YES就不显示
{{#properties}}{{/properties}}通过properties数组属性赋值
{{#strong}}strong{{/strong}}表示strong这个属性为YES就显示
{{^strong}}assign{{/strong}}表示strong这个属性为NO就显示
# ^这个两个就相当于if判断了
