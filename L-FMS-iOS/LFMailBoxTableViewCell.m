//
//  LFMailBoxTableViewCell.m
//  L-FMS-iOS
//
//  Created by 虎猫儿 on 15/10/3.
//  Copyright (c) 2015年 虎猫儿. All rights reserved.
//

#import "LFMailBoxTableViewCell.h"

@interface LFMailBoxTableViewCell ()


@end

@implementation LFMailBoxTableViewCell

- (void)awakeFromNib {
    self.lastMessageLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - reuse

- (void)prepareForReuse {
    [super prepareForReuse];
}

@end
