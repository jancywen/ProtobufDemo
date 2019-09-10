//
//  ViewController.m
//  ProtobufDemo
//
//  Created by 大熊🐻 on 2019/9/9.
//  Copyright © 2019 大熊🐻. All rights reserved.
//

#import "ViewController.h"
#import "Location.pbobjc.h"
#import "GCD/GCDAsyncSocket.h"



@interface ViewController ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) GCDAsyncSocket *tcpSocket;
@property (weak, nonatomic) IBOutlet UILabel *connectStatus;
@property (weak, nonatomic) IBOutlet UILabel *log;
@property (weak, nonatomic) IBOutlet UILabel *PINGStatus;
@property (weak, nonatomic) IBOutlet UILabel *breakStatus;
@end

@implementation ViewController


#define SOCKETURL @"localhost"
#define SOCKETPORT 1234

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self simple];
}


/**
 简单使用
 */
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

- (void)socket{
    
}
- (IBAction)connectAction:(id)sender {
    
    self.tcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error;
    BOOL isConnect = [self.tcpSocket connectToHost:SOCKETURL onPort:SOCKETPORT withTimeout:-1 error:&error];
    if (isConnect) {
        self.connectStatus.text = @"socket 尝试连接...";
        
    } else {
        self.connectStatus.text = @"socket 没有尝试连接...";
    }
}
- (IBAction)sendSomething:(id)sender {

    Location *location = [[Location alloc]init];
    location.accessToken = @"base qw";
    location.orderId = @"orderid-123";
    location.clientId = @"clientid-123";
    location.latitude = 30.199544680748;
    location.longitude = 120.27409366925;
    location.speed = 0.25;
    
    NSData *data = [location data];
    
    [self.tcpSocket writeData:data withTimeout:-1 tag:110];
}

- (IBAction)sendPING:(id)sender {
    NSData *data = [@"PING" dataUsingEncoding:NSUTF8StringEncoding];
    [self.tcpSocket writeData:data withTimeout:-1 tag:10];
}
    
    
- (IBAction)breakAction:(id)sender {
    [self.tcpSocket disconnect];
    self.tcpSocket = nil;
}
    
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功");
    self.connectStatus.text = @"连接成功";
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if (tag == 10) {
        self.PINGStatus.text = @"Ping 发送成功";
    }
    if (tag == 110) {
        NSLog(@"location 发送成功");
    }
    [self.tcpSocket readDataWithTimeout:-1 tag:tag];
    
}
    
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    if (tag == 10) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        self.PINGStatus.text = str;
    }
    if (tag == 110) {
        Location *location = [Location parseFromData:data error:nil];
        self.log.text = location.accessToken;
    }
    
}
 
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    if (err == nil) {
        self.breakStatus.text = @"断开连接";
    }
}
@end
