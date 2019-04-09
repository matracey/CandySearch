//
//  Candy.h
//  CandySearch
//
//  Created by Martin Tracey on 02/05/2013.
//  Copyright (c) 2013 Martin Tracey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject {
    NSString *category;
    NSString *name;
}

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name;

@end
