//
//  leftViewModel.m
//  Dupa
//
//  Created by Łukasz Kowalski on 13/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "leftViewModel.h"

@implementation leftViewModel

static leftViewModel *sharedBarInstance = nil;    // static instance variable

+ (leftViewModel *)sharedInstance {
    if (sharedBarInstance == nil) {
        sharedBarInstance = [[super allocWithZone:NULL] init];
    }
    return sharedBarInstance;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}
- (void)sideBarCategory:(NSString *)categoryName{
    self.currentCategory = categoryName;
    NSLog(@"singleton category = %@", self.currentCategory);
}

- (NSString *)getSideBarCategory{
    return self.currentCategory;
}
- (void) reloadTableView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetsideBar" object:nil];

}
- (NSArray *)getCinemaNames{
    self.cinemaNames = [[NSArray alloc] initWithObjects:
    @"Ada Kino Studyjne",
    @"Antropos",
    @"Atlantic",
    @"Cinema City Arkadia",
    @"Cinema City Bemowo",
    @"Cinema City Janki",
    @"Cinema City Mokotów",
    @"Cinema City Promenada",
    @"Cinema City Sadyba",
    @"Iluzjon Filmoteki Narodowej",
    @"IMAX",
    @"Kino KC",
    @"Kino Praha",
    @"Kino.Lab",
    @"Kinokawiarnia Stacja Falenica",
    @"Kinoteka",
    @"Kultura",
    @"Luna",
    @"Multikino Targówek",
    @"Multikino Ursynów",
    @"Multikino Wola",
    @"Multikino Złote Tarasy",
    @"Muranów",
    @"Planetarium Niebo Kopernika",
    @"Świt",
    @"Wisła", nil];
    
    return self.cinemaNames;
}


@end
