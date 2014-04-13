//
//  PlaceModel.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Place.h"

@implementation Place

+ (Place *)placeFromDict: (NSDictionary *)args
{
    Place *obj = [Place alloc];
    [obj set_id:[args objectForKey:@"_id"]];
    [obj setName:[args objectForKey:@"name"]];
    return obj;
}

@end
