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
    if ([self.currentCategory isEqualToString:@"cinema"]) {
        [self getCinemaContentFromAPI];
    }
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
- (NSArray *)getClubNames{
    self.clubNames = [[NSArray alloc] initWithObjects:
                        @"Bank",
                        @"DeLite",
                        @"Capitol",
                        @"Bal",
                        @"Bątą",
                        @"NiePowiem",
                         nil];
    
    return self.clubNames;
}
- (NSInteger)numberOfSectionsInTableView{
    return 5;
}

- (NSInteger)numberOfRowsInTableView{
    return 50;
}

- (void)getCinemaContentFromAPI{
    
    //Some POST
    NSURL *url = [NSURL URLWithString:@"http://sprtime.com:8080"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:@"4" forKey:@"categoryIds"];
    [parameters setObject:@"2015040920" forKey:@"dateStr"];
    [parameters setObject:[NSNumber numberWithInteger:0] forKey:@"offset"];
    [parameters setObject:[NSNumber numberWithInteger:50] forKey:@"limit"];
    
    NSLog(@"paramtery : %@",parameters);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"dM8Axj5tiQhh" forHTTPHeaderField:@"X-Token"];
    
    [manager POST:@"/mob/catalogueQuery2"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *response = (NSDictionary *)responseObject;
              NSLog(@"Success: %@", response  );
              
              NSArray *results = [response objectForKey:@"res"];
              
              for (NSDictionary *category in results) {
                  NSLog(@"%@", category);
                  NSData *webData = [[category objectForKey:@"payload"] dataUsingEncoding:NSUTF8StringEncoding] ;
                  
                  NSError *error;
                  NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
                  NSLog(@"JSON DIct: %@", jsonDict);
              }
              
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
    //

    
}



@end
