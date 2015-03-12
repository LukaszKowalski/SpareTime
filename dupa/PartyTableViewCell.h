//
//  PartyTableViewCell.h
//  SpareTime
//
//  Created by Łukasz Kowalski on 05/01/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *categoryView;
@property (nonatomic, strong) UIView *photoConteiner;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier cellOpened:(BOOL)cellOpened;

@end
