//
//  main.m
//  iCalEventCreator
//
//  Created by Deni Bacic on 7. 10. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//
//  Script adds event to calendar of your choice



#import <Foundation/Foundation.h>

#import <CoreWLAN/CoreWLAN.h>
#import <EventKit/EventKit.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
//        NSLog(@"Hello, World!");
        
        NSString *calendarName = @"Work";
        int hoursNumber = 8;
        NSString *eventName = @"KI";
        NSString *location = @"Hajdrihova 19";
        
        
        
        
        EKEventStore *store = [[EKEventStore alloc] initWithAccessToEntityTypes:EKEntityMaskEvent];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSArray *calendarList = [store calendarsForEntityType:EKEntityTypeEvent];
        
        EKCalendar *internalCalendarName = [[EKCalendar alloc] init];
        
        for (int i=0; i<[calendarList count]; i++) {
            EKCalendar *cal =[calendarList objectAtIndex:i];
            
            if  ([cal.title isEqualToString:calendarName]) {
                internalCalendarName = cal;
            }
        }
        
        
        
        
        NSDateComponents *dc = [[NSDateComponents alloc] init];
        [dc setHour:hoursNumber];
        NSDate *startDate = [NSDate date];
        NSDate *endDate = [calendar dateByAddingComponents:dc toDate:[NSDate date] options:0];
        EKEvent *anEvent = [EKEvent eventWithEventStore:store];
        [anEvent setTitle:eventName];;
        [anEvent setCalendar:internalCalendarName];
        [anEvent setLocation:location];
        [anEvent setStartDate:startDate];
        [anEvent setEndDate:endDate];
        [store saveEvent:anEvent span:EKSpanThisEvent commit:YES error:nil];

        
    }
    return 0;
}

