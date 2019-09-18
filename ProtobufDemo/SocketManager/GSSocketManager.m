//
//  GSSocketManager.m
//  CarShare
//
//  Created by 大熊🐻 on 2019/9/11.
//  Copyright © 2019 rihui. All rights reserved.
//

#import "GSSocketManager.h"
#import "Message.pbobjc.h"
#import "LCSocketEncoder.h"
#import "LCSocketDecoder.h"


NSInteger registerTag = 300;
#define SOCKETURL @"localhost"
#define SOCKETPORT 1234
@interface GSSocketManager() <GCDAsyncSocketDelegate,LCSocketEncoderOutputProtocol,LCSocketDecoderOutputProtocol>

    @property (nonatomic, strong) NSTimer *timer;
    
    @property (nonatomic, assign) BOOL isRegister;
    
    @property (nonatomic, strong) LCSocketEncoder *encodeDelegate;
    @property (nonatomic, strong) LCSocketDecoder *decodeDelegate;


@end
static GSSocketManager *manager = nil;

@implementation GSSocketManager

    
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GSSocketManager alloc] init];
    });
    
    return manager;
}
    
    - (void)startConnect {
        
        self.tcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError *error;
        self.manualOffline = NO;
        BOOL isConnect = [self.tcpSocket connectToHost:SOCKETURL onPort:SOCKETPORT withTimeout:-1 error:&error];  
        if (isConnect) {
            NSLog(@"socket 尝试连接...");
            
        } else {
            NSLog(@"socket 没有尝试连接...");
            
        }
    }
    
- (void)disconnect {
    self.manualOffline = YES;
    [self.tcpSocket disconnect];
    self.tcpSocket = nil;
}
    
- (void)automaticDisconnect {
    [self.tcpSocket disconnect];
    self.tcpSocket = nil;
}
    
- (void)sendData:(Request *)message {
    message.phoneType = 2;
    message.clientType = CLIENT_TYPE_Driver;
    
    NSData * data = [message delimitedData];
    
    if (!self.encodeDelegate) {
        self.encodeDelegate = [[LCSocketEncoder alloc] init];
    }
    [self.encodeDelegate encodeProtobuf:data output:self];
    
}
    
#pragma  mark - <GcdSocketDelegate>
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"socket 连接成功");
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self.tcpSocket readDataWithTimeout:-1 tag:0];
    if ([self.delegate respondsToSelector:@selector(socketManager:didConnectToHost:port:)]) {
        [self.delegate socketManager:self didConnectToHost:host port:port];
    }
}
    
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
    {
        
        if (self.isManualOffline) {
            NSLog(@"socket 手动断开");
            //        [self.timer setFireDate:[NSDate distantFuture]];
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
            
        } else {
            [self automaticDisconnect];
            NSLog(@"socket 自动断开，发送重连");
            if (!self.timer) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reconnectTimer:) userInfo:nil repeats:YES];
            }
            //        [self.timer setFireDate:[NSDate distantPast]];
            
        }
        if ([self.delegate respondsToSelector:@selector(socketManager:didDisconnectWithError:)]) {
            [self.delegate socketManager:self didDisconnectWithError:err];
        }
    }
    
#pragma mark - timer event
- (void)reconnectTimer:(NSTimer *)timer {
    [self startConnect];
    //    [self sendOnlineWithOrderStatus:[RHAccountManager userOrderStatus] completion:nil];
}
    
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    if (!self.decodeDelegate) {
        self.decodeDelegate = [[LCSocketDecoder alloc] init];
    }
    [self.decodeDelegate decode:data output:self];
    
}
    
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
    {
        NSLog(@"socket write data:");
        if ([self.delegate respondsToSelector:@selector(socketManager:didWriteDataWithTag:)]) {
            [self.delegate socketManager:self didWriteDataWithTag:tag];
        }
    }

    
    
    
#pragma mark - <LCSocketEncoderOutputProtocol>
- (void)didEndEncode:(id)encodedPacket error:(NSError *)error {
    
    if (self.isRegister) {
        [self.tcpSocket writeData:encodedPacket withTimeout:-1 tag:registerTag];
    } else {
        [self.tcpSocket writeData:encodedPacket withTimeout:-1 tag:0];
    }
}
    
#pragma mark - <LCSocketDecoderOutputProtocol>
- (void)didEndDecode:(id)decodedPacket error:(NSError *)error {
        
    GPBCodedInputStream *s = [[GPBCodedInputStream alloc]initWithData:decodedPacket];
    Response *res = [Response parseDelimitedFromCodedInputStream:s extensionRegistry:nil error:nil];
    if ([self.delegate respondsToSelector:@selector(socketManager:didReceiveData:)]) {
        [self.delegate socketManager:self didReceiveData:res];
    }
    NSLog(@"*************  %@",res);
    [self.tcpSocket readDataWithTimeout:-1 tag:0];
        
}
    
@end
