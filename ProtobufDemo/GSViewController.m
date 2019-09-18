//
//  GSViewController.m
//  ProtobufDemo
//
//  Created by 大熊🐻 on 2019/9/18.
//  Copyright © 2019 大熊🐻. All rights reserved.
//

#import "GSViewController.h"
#import "GSSocketManager.h"
#import "Message.pbobjc.h"
@interface GSViewController ()<GSSocketManagerDelegate>

@end

@implementation GSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[GSSocketManager shareManager] startConnect];
    [GSSocketManager shareManager].delegate = self;
}

- (void)sendPing{
    Ping *ping = [[Ping alloc]init];
    Request *req = [[Request alloc]init];
    req.msgType = MSG_TYPE_Ping;
    req.ping = ping;
    [GSSocketManager.shareManager sendData:req];
}

- (void)socketManager:(GSSocketManager *)socketManager didConnectToHost:(NSString *)host port:(uint16_t)port {
    
}
- (void)socketManager:(GSSocketManager *)socketManager didDisconnectWithError:(NSError *)error {
    
}

- (void)socketManager:(GSSocketManager *)socketManager didWriteDataWithTag:(long)tag {
    
}

- (void)socketManager:(GSSocketManager *)socketManager didReceiveData:(Response *)message {
    switch (message.msgType) {
        case MSG_TYPE_Pong:
            NSLog(@"MSG_TYPE_Pong");
            break;
            
        default:
            break;
    }
}
@end
