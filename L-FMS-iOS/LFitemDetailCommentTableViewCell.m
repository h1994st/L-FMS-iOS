//
//  LFitemDetailCommentTableViewCell.m
//  L-FMS-iOS
//
//  Created by 虎猫儿 on 15/10/11.
//  Copyright (c) 2015年 虎猫儿. All rights reserved.
//

#import "LFitemDetailCommentTableViewCell.h"

@interface LFitemDetailCommentTableViewCell ()

@end

@implementation LFitemDetailCommentTableViewCell

- (void)awakeFromNib {
    //LFitemDetailCommentTableViewCellReuseId
    
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView.layer setCornerRadius:self.avatarImageView.bounds.size.height/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
