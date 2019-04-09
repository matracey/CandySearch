//
//  Candy.m
//  CandySearch
//
//  Created by Martin Tracey on 02/05/2013.
//  Copyright (c) 2013 Martin Tracey. All rights reserved.
//

#import "Candy.h"

@implementation Candy
@synthesize category;
@synthesize name;

+(id)candyOfCategory:(NSString *)category name:(NSString *)name
{
    Candy *newCandy = [[self alloc] init];
    newCandy.category = category;
    newCandy.name = name;
    return newCandy;
}

@end
