//
//  LFChatRoomViewController.m
//  L-FMS-iOS
//
//  Created by 虎猫儿 on 15/10/7.
//  Copyright (c) 2015年 虎猫儿. All rights reserved.
//

#import "LFChatRoomViewController.h"
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface LFChatRoomViewController ()

//AVIMConversation实例
@property (nonatomic, strong) AVIMConversation *conversation ;

@end

@implementation LFChatRoomViewController

#pragma mark - init 

- (instancetype)init {
    if ( self = [super init] ) {
        [self setUp] ;
    }
    return self ;
}

- (instancetype)initWithConersation:(AVIMConversation *)conv {
    if ( self = [self init] ) {
        self.conversation = conv ;
        [self setUp] ;
    }
    return self ;
}

- (void)setUp {
    self.hidesBottomBarWhenPushed = YES ;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad] ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
}

- (void)dealloc {
    
}

@end