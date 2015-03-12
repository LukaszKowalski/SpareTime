//
//  firstCellTableViewCell.m
//  Dupa
//
//  Created by Łukasz Kowalski on 2/13/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "firstCellTableViewCell.h"

@implementation firstCellTableViewCell

- (void)awakeFromNib {
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    visualEffectView.frame = self.background.frame;
    [self.background addSubview:visualEffectView];
    [self.contentView insertSubview:self.categoryName aboveSubview:self.background];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
