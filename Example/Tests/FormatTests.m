//
//  FormatTests.m
//  SLConditionalDateFormatterTests
//
//  Created by Sebastian Ludwig on 31.07.15.
//  Copyright (c) 2015 Sebastian Ludwig. All rights reserved.
//

#import "TestCase.h"

static int hours = 60 * 60;
static int days = 24 * 60 * 60;


@interface FormatTests : TestCase

@end

@implementation FormatTests

- (void)setUp {
    [super setUp];
}

- (void)testRules
{
    //    [formatter addFormat:@"R" forTimeInterval:(-2 * 60 * 60)];    // 1 hour ago
    //    [formatter addFormat:@"RR" forTimeInterval:(-2 * 60 * 60 * 24)];    // 1 day 2 hours ago
    //    [formatter addFormat:@"~R" forTimeInterval:(-2 * 60 * 60)];    // about 1 hour ago
    //    [formatter addFormat:@"HH:mm" for:Today];
    //    [formatter addFormat:@"R at {HH:mm}" for:Yesterday];
    //    [formatter addFormat:@"HH:mm" for:Today];
    //    [formatter addFormat:@"R at {HH:mm}" for:Yesterday];
    //    [formatter addFormat:@"I" forLast:2 unit:Weeks];
    //    [formatter addFormat:@"R" forNext:2 unit:Days];
    
    //    [formatter addFormat:@"HH:mm" for:SLRealtiveDateToday];
    //    [formatter addFormat:@"R at {HH:mm}" for:SLRealtiveDateYesterday];
    //    [formatter addFormat:@"R" forLast:2 unit:SLRealtiveDateWeeks];
    //    [formatter addFormat:@"R" forNext:2 unit:SLRealtiveDateDays];
    
    
    //    [formatter addFormat:@"HH:mm" for:SLTimeUnitToday];
    //    [formatter addFormat:@"R at {HH:mm}" for:SLTimeUnitYesterday];
    //    [formatter addFormat:@"R" forLast:2 unit:SLTimeUnitWeeks];
    //    [formatter addFormat:@"R" forNext:2 unit:SLTimeUnitDays];
    
    //    formatter.defaultFormat:@"{yyyy-MM-dd} at {HH:mm}";
    // {<anything with only template characters will be passed to dateFormatFromTemplate>}
    
    // Days
    // Weeks
    // Months
    // Years
    
    // Today        // TODO: allow "I" only for the following?
    // Yesterday
    // Tomorrow
    
    // ThisWeek
    // LastWeek
    // NextWeek
    
    // ThisMonth
    // LastMonth
    // NextMonth
    
    // ThisYear
    // LastYear
    // NextYear
    
    // TODO: should default "I" fall back to "R"?
}

- (void)testHandlesNilDefault {
    self.formatter.defaultFormat = nil;
    
    NSString *result = [self expressionFromDate:@"2015-02-23 20:33:50 +0000"
                                toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqual(result, nil);
}

#pragma mark Formats I and R

- (void)testUsesDefaultFormat
{
    self.formatter.defaultFormat = @"R";
    NSString *result = [self expressionFromDate:@"2015-02-23 20:33:50 +0000"
                                toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqualObjects(result, @"1 day ago");
}

- (void)testIdiomaticExpressionsFormat
{
    self.formatter.defaultFormat = @"I";
    NSString *result = [self expressionFromDate:@"2015-02-23 20:33:50 +0000"
                                toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqualObjects(result, @"yesterday");
}

- (void)testSignificantUnitsForRelativeFormat
{
    self.formatter.defaultFormat = @"RR";
    
    NSString *result = [self expressionFromDate:@"2015-02-22 6:33:50 +0000" toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqualObjects(result, @"2 days 3 hours ago");
}

- (void)testOnlyChangesTemplateCharacters
{
    self.formatter.defaultFormat = @"I, yo";
    NSString *result = [self expressionFromDate:@"2015-02-23 20:33:50 +0000"
                                toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqualObjects(result, @"yesterday, yo");
}

- (void)testReplacesMultipleTemplates
{
    self.formatter.defaultFormat = @"I / R";
    NSString *result = [self expressionFromDate:@"2015-02-23 20:33:50 +0000"
                                toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqualObjects(result, @"yesterday / 13 hours 39 minutes ago");
}

#pragma mark Precedence

- (void)testAppliesAddedFormatFirst
{
    self.formatter.defaultFormat = @"I";
    [self.formatter addFormat:@"R" forTimeInterval:(-4 * days)];
    NSString *result = [self.formatter stringForTimeInterval:(-1 * days)];
    XCTAssertEqualObjects(result, @"1 day ago");
}

- (void)testChecksTimeIntervalForFormat
{
    self.formatter.defaultFormat = @"I";
    [self.formatter addFormat:@"R" forTimeInterval:(-3 * hours)];
    NSString *result = [self.formatter stringForTimeInterval:(-1 * days)];
    XCTAssertEqualObjects(result, @"yesterday");
}

- (void)testAppliesFormatsInOrder
{
    [self.formatter addFormat:@"R" forTimeInterval:(-4 * days)];
    [self.formatter addFormat:@"RR" forTimeInterval:(-4 * days)];
    
    NSString *result = [self expressionFromDate:@"2015-02-22 6:33:50 +0000" toReferenceDate:@"2015-02-24 10:13:39 +0000"];
    XCTAssertEqualObjects(result, @"2 days ago");
}

#pragma mark Logical intervals

- (void)testTimeFormatForToday
{
//    [self.formatter addFormat:@"R" for:SLTimeUnitToday];
//    NSString *result = [self.formatter stringForTimeInterval:(-3 * hours)];
//    XCTAssertEqualObjects(result, @"3 hours ago");
}

//    [formatter addFormat:@"HH:mm" for:SLTimeUnitToday];
//    [formatter addFormat:@"R at {HH:mm}" for:SLTimeUnitYesterday];
//    [formatter addFormat:@"R" forLast:2 unit:SLTimeUnitWeeks];
//    [formatter addFormat:@"R" forNext:2 unit:SLTimeUnitDays];

@end
