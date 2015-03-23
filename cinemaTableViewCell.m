//
//  cinemaTableViewCell.m
//  Dupa
//
//  Created by Łukasz Kowalski on 23/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "cinemaTableViewCell.h"

@implementation cinemaTableViewCell

- (void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
