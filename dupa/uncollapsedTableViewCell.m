//
//  uncollapsedTableViewCell.m
//  Dupa
//
//  Created by Łukasz Kowalski on 3/20/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "uncollapsedTableViewCell.h"

@implementation uncollapsedTableViewCell

- (void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
