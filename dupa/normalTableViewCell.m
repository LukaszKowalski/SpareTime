//
//  normalTableViewCell.m
//  Dupa
//
//  Created by Łukasz Kowalski on 2/13/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "normalTableViewCell.h"

@implementation normalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier cellOpened:(BOOL)cellOpened{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        
        }
        return self;
    }


@end
