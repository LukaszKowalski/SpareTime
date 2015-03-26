//
//  clubTableViewCell.m
//  Dupa
//
//  Created by Łukasz Kowalski on 26/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "clubTableViewCell.h"

@implementation clubTableViewCell

- (void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.changePhoto addTarget:self action:@selector(changePhotos) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)changePhotos{
    
    static NSInteger numberOfPhotos = 1;
    if (numberOfPhotos == 0) {
        numberOfPhotos++;
        self.photoOne.hidden = YES;
        self.photoTwo.hidden = YES;
        self.photoThree.hidden = YES;
        self.poster.hidden = NO;
        self.posterTwoLivePhotos.hidden = YES;
        self.posterOneLivePhoto.hidden = YES;
    }
    
    else if (numberOfPhotos == 1) {
        numberOfPhotos++;
        self.photoOne.hidden = NO;
        self.poster.hidden = YES;
        self.posterOneLivePhoto.hidden = NO;
        
    }
    else if (numberOfPhotos == 2) {
        numberOfPhotos++;
        self.photoTwo.hidden = NO;
        self.posterOneLivePhoto.hidden = YES;
        self.posterTwoLivePhotos.hidden = NO;
    }
    else if (numberOfPhotos == 3) {
        numberOfPhotos++;
        self.photoThree.hidden = NO;
        self.posterTwoLivePhotos.hidden = YES;
    }
    else if (numberOfPhotos == 4) {
        numberOfPhotos = 0;
        [self changePhotos];
    }
    
}

@end
