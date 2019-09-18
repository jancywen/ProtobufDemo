//
//  GSSocketManager.h
//  CarShare
//
//  Created by 大熊🐻 on 2019/9/11.
//  Copyright © 2019 rihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

NS_ASSUME_NONNULL_BEGIN



@class GSSocketManager, Response, Request;

@protocol GSSocketManagerDelegate <NSObject>

@optional
- (void)socketManager:(GSSocketManager *)socketManager didConnectToHost:(NSString *)host port:(uint16_t)port;
- (void)socketManager:(GSSocketManager *)socketManager didDisconnectWithError:(NSError *)error;
    
- (void)socketManager:(GSSocketManager *)socketManager didWriteDataWithTag:(long)tag;
    
- (void)socketManager:(GSSocketManager *)socketManager didReceiveData:(Response *)message;


@end

@interface GSSocketManager : NSObject
    @property (nonatomic, weak) id <GSSocketManagerDelegate> delegate;
    
    @property (nonatomic, strong) GCDAsyncSocket *tcpSocket;
    
    @property (nonatomic, assign, getter=isManualOffline) BOOL manualOffline;

    
+ (instancetype)shareManager;
    
- (void)startConnect;
    
- (void)disconnect;
- (void)automaticDisconnect;
    
- (void)sendData:(Request *)message;
@end

NS_ASSUME_NONNULL_END
