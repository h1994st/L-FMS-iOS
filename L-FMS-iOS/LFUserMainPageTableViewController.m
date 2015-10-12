//
//  LFUserMainPageTableViewController.m
//  L-FMS-iOS
//
//  Created by 虎猫儿 on 15/10/13.
//  Copyright (c) 2015年 虎猫儿. All rights reserved.
//

#import "LFUserMainPageTableViewController.h"

#import "LFUserMainPageButtonTableViewCell.h"
#import "LFUserInfoItemTableViewCell.h"
#import "LFUserMainInfoTableViewCell.h"

#import "LFCommon.h"

#define itemnameKey @"itemname"
#define itemDescriptionKey @"itemDescription"

@interface LFUserMainPageTableViewController ()<LFUserMainPageButtonTableViewCellDelegate>

@property (nonatomic) NSArray *dataSource ;

@end

@implementation LFUserMainPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
    self.dataSource = @[@{itemnameKey:@"邮箱",
                          itemDescriptionKey:self.user.email},
                        @{itemnameKey:@"电话",
                          itemDescriptionKey:self.user.mobilePhoneNumber},
                        @{itemnameKey:@"地址",
                          itemDescriptionKey:self.user.address},
                        @{itemnameKey:@"学院",
                          itemDescriptionKey:self.user.major},
                        ] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning] ;
}

#pragma mark - actions 

- (void)chatWithCurrentUser {
    if ( !self.user ) return ;
    if ( [self.user.objectId isEqualToString:[LFUser currentUser].objectId]) return ;
}


#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 10 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10 ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( 1 == section ) {
        //电话，邮箱，地址，学院
        return 4 ;
    }
    
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section ;
    if ( 0 == section ) {
        return 110 ;
    }
    
    if ( 2 == section ) {
        return 60 ;
    }
    
    return 44 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section ;
    if ( 0 == section ) {
        //主页
        LFUserMainInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFUserMainInfoTableViewCellReuseId" forIndexPath:indexPath] ;
        cell.nameLabel.text = self.user.name ;
        cell.genderLabel.text = self.user.gender ;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.user.avatar.url]
                                placeholderImage:[UIImage imageNamed:@"testAvatar1"]] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell ;
    }
    
    if ( 2 == section ) {
        LFUserMainPageButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFUserMainPageButtonTableViewCellReuseId" forIndexPath:indexPath] ;
        cell.delegate = self ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell ;
    }
    
    LFUserInfoItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFUserInfoItemTableViewCellReuseId" forIndexPath:indexPath];
    NSInteger row = indexPath.row ;
    
    NSDictionary *info = self.dataSource[row] ;
    cell.itemNameLabel.text = info[itemnameKey] ;
    cell.itemValueLabel.text = info[itemDescriptionKey] ;
    
    return cell ;
}

#pragma mark - LFUserMainPageButtonTableViewCellDelegate

- (void)buttonCellDidClickedButton:(LFUserMainPageButtonTableViewCell *)cell {
    [self chatWithCurrentUser] ;
}

@end