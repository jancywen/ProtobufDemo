# ProtobufDemo


### 环境安装
使用brew安装，没有安装brew可以自行百度安装

1.安装依赖工具
```
$ brew install automake
$ brew install libtool
```
2.安装protobuf
```
$ brew install protobuf
```
3.克隆 protobuf-objc
```
$ git clone https://github.com/alexeyxo/protobuf-objc.git
```
4.运行脚本 (切换到protobuf-objc路径）
```
$  ./scripts/build.sh
```
### 创建编辑 proto 文件
```
syntax = 'proto3';

message Location {
    string accessToken = 1;
    string cdType = 2;
    string clientId = 3;
    string connectUser = 4;
    string direction = 5;
    double latitude = 6;
    double longitude = 7;
    string orderId = 8;
    float speed = 9;
    int64 timestamp = 10;
    float travelMile = 11;
    string type = 12;
}
```
### 转化objc、py文件
使用protoc工具生成 Objective-C 和Python文件
```
$ protoc --proto_path=A --objc_out=B Location.proto
$ protoc --proto_path=A --python_out=B Location.proto
其中--proto_path=后跟A是需要处理的proto文件所在的文件夹，--objc_out=指明生成的是Objective-C代码以及目标文件存放路径，B是目标文件存放路径,Location.proto是需要处理的文件。
--python_out=生成Python文件
```
至此，我们的准备工作就做完了，新建一个项目 姑且命名 protobufDemo，cocoapods集成protobuf，将生成的objc文件拖入到项目中因为这两个文件不支持ARC，设置编译参数 TARGETS >> Build Phases >> Compile Sources >> Location.pbobjc.m 为 -fno-objc-arc 。

### 简单应用
```
#import "Location.pbobjc.h"

......

- (void)simple {
    Location *location = [[Location alloc]init];
    location.accessToken = @"base qw";
    location.orderId = @"orderid-123";
    location.clientId = @"clientid-123";
    location.latitude = 30.199544680748;
    location.longitude = 120.27409366925;
    location.speed = 0.25;
    
    NSData *data = [location data];
    
    Location *l = [Location parseFromData:data error:nil];
    NSLog(@"%.11f", l.longitude);
}
```
### socket应用
建立socket连接，向服务端发送数据
```
NSData *data = [location data];
[self.tcpSocket writeData:data withTimeout:-1 tag:110];
```
处理接收的数据
```
Location *location = [Location parseFromData:data error:nil];
```
参考：

[iOS下 安装Protobuf(ProtocolBuffers)的详细步骤](https://www.jianshu.com/p/189368a9d744)

[Protobuf3 教程](https://www.kaifaxueyuan.com/basic/protobuf3.html)

[cocoapods 引入 三方库 历程](https://blog.csdn.net/jancywen/article/details/100691067)
