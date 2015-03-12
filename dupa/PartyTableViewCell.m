//
//  PartyTableViewCell.m
//  SpareTime
//
//  Created by Łukasz Kowalski on 05/01/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import "PartyTableViewCell.h"
#define Category_Box_Height 72
#define Category_Subclass_Height 36
#define Category_Object_Height 152

@implementation PartyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier cellOpened:(BOOL)cellOpened{
    NSLog(@"creating cell");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Category_Object_Height - 6)];
        if (self.frame.size.height == 250) {
            self.categoryView.frame = CGRectMake(0, 0, self.frame.size.width, 250 - 6);
        }
        self.categoryView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.categoryView];
        
        NSLog(@"szerokość %f", self.frame.size.width);
        
        self.photoConteiner = [[UIView alloc] init];
        self.photoConteiner.frame = CGRectMake(0, 0, 280, 90);
        self.photoConteiner.backgroundColor = [UIColor redColor];
        [self.categoryView addSubview:self.photoConteiner];
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        [self.photoConteiner addSubview:imageView1];
        imageView1.contentMode = UIViewContentModeScaleToFill;
        UIImage *image1 = [UIImage imageNamed:@"kawa1"];
        imageView1.image = image1;
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0, 90, 90)];
        [self.photoConteiner addSubview:imageView2];
        imageView2.contentMode = UIViewContentModeScaleToFill;
        UIImage *image2 = [UIImage imageNamed:@"kawa2"];
        imageView2.image = image2;
        
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 0, 90, 90)];
        UIImage *image3 = [UIImage imageNamed:@"kawa3"];
        imageView3.contentMode = UIViewContentModeScaleToFill;
        imageView3.image = image3;
        [self.photoConteiner addSubview:imageView3];
        
        UILabel *placeName = [[UILabel alloc] init];
        placeName.text = @"Bank Club";
        placeName.textColor = [UIColor blueColor];
        placeName.frame = CGRectMake(self.photoConteiner.frame.origin.x + 15, Category_Object_Height /3 *2 , 100, 40);
        [self.categoryView addSubview:placeName];
        
        UIImageView *plusView = [[UIImageView alloc] initWithFrame:CGRectMake(self.photoConteiner.frame.origin.x + 240, Category_Object_Height /3 *2.3 , 10, 10)];
        [self.categoryView addSubview:plusView];
        UIImage *plus = [UIImage imageNamed:@"plus"];
        plusView.image = plus;
        
        UIImageView *minusView = [[UIImageView alloc] initWithFrame:CGRectMake(self.photoConteiner.frame.origin.x + 240, 15 , 10, 10)];
        [self.categoryView addSubview:minusView];
        UIImage *minus = [UIImage imageNamed:@"Minus"];
        minusView.image = minus;
        minusView.hidden = YES;
        
        if (cellOpened == YES) {
            [UIView animateWithDuration:.35  delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.categoryView.frame = CGRectMake(0, 0, self.frame.size.width, 250 - 6);
                self.photoConteiner.frame = CGRectMake(0, 40, self.photoConteiner.frame.size.width, self.photoConteiner.frame.size.height);
                placeName.frame = CGRectMake(self.photoConteiner.frame.origin.x + 15, 12, 100, 20);
                plusView.hidden = YES;
                minusView.hidden = NO;
            } completion:^(BOOL finished) {
                
            }];
        }else if(cellOpened == NO){
            [UIView animateWithDuration:.1  delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.categoryView.frame = CGRectMake(0, 0, self.frame.size.width, Category_Object_Height - 6);
                self.photoConteiner.frame = CGRectMake(0, 0, 280, 90);
                placeName.frame = CGRectMake(self.photoConteiner.frame.origin.x + 15, Category_Object_Height /3 *2 , 100, 40);
                plusView.hidden = NO;
                minusView.hidden = YES;
            } completion:^(BOOL finished) {
                
            }];

        }

    }
    
    
return self;

}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    
//    if (selected == YES) {
//        NSLog(@"zaznaczone %@", self.description);
//        self.categoryView.backgroundColor = [UIColor redColor];
//    }else{
//        NSLog(@"odznaczone");
//        self.categoryView.backgroundColor = [UIColor whiteColor];
//
//    }
//
//}



@end

//else {
//    
//    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, Category_Object_Height - 6)];
//    if (cell.frame.size.height == 250) {
//        categoryView.frame = CGRectMake(0, 0, cell.frame.size.width, 250 - 6);
//    }
//    categoryView.backgroundColor = [UIColor whiteColor];
//    [cell addSubview:categoryView];
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, categoryView.frame.size.width /3, 90)];
//    [categoryView addSubview:imageView1];
//    imageView1.contentMode = UIViewContentModeScaleAspectFit;
//    UIImage *image1 = [UIImage imageNamed:@"kawa1"];
//    imageView1.image = image1;
//    
//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(categoryView.frame.size.width /3, 0, categoryView.frame.size.width /3, 90)];
//    [categoryView addSubview:imageView2];
//    imageView2.contentMode = UIViewContentModeScaleAspectFit;
//    UIImage *image2 = [UIImage imageNamed:@"kawa2"];
//    imageView2.image = image2;
//    
//    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(categoryView.frame.size.width *2 /3, 0, categoryView.frame.size.width /3, 90)];
//    UIImage *image3 = [UIImage imageNamed:@"kawa3"];
//    imageView3.contentMode = UIViewContentModeScaleAspectFit;
//    imageView3.image = image3;
//    [categoryView addSubview:imageView3];
//    
//}