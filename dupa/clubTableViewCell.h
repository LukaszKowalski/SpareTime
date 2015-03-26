//
//  clubTableViewCell.h
//  Dupa
//
//  Created by Łukasz Kowalski on 26/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clubTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoOne;
@property (weak, nonatomic) IBOutlet UIImageView *photoTwo;
@property (weak, nonatomic) IBOutlet UIImageView *photoThree;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UIImageView *posterOneLivePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *posterTwoLivePhotos;
@property (weak, nonatomic) IBOutlet UIButton *changePhoto;

@end
