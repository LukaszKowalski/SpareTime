//
//  leftViewModel.h
//  Dupa
//
//  Created by Łukasz Kowalski on 13/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface leftViewModel : NSObject

@property (strong, nonatomic) NSString *currentCategory;

+ (leftViewModel *)sharedInstance;   // class method to return the singleton object
- (void)sideBarCategory:(NSString *)categoryName;
- (NSString *)getSideBarCategory;

@end
