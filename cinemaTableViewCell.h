//
//  cinemaTableViewCell.h
//  Dupa
//
//  Created by Łukasz Kowalski on 23/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cinemaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *showTime;

@end
