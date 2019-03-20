/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/*
 #import <humor.h> : Not planning to implement: dateByAskingBoyOut and dateByGettingBabysitter
 ----
 General Thanks: sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen
 
 Include GMT and time zone utilities?
*/

#import "NSDate+Utilities.h"

// Thanks, AshFurrow
static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear);



@implementation NSDate (Utilities)

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateDayAfterTomorrow{
    return [NSDate dateWithDaysFromNow:2];
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) && 
			(components1.day == components2.day));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL) isDayAfterTomorrow{
    return [self isEqualToDateIgnoringTime:[NSDate dateDayAfterTomorrow]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekday != components2.weekday){
     return NO;
    }
    
	// Must have a time interval under 1 week. Thanks @aclark
	return (ABS([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL) isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingYears: (NSInteger) dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark - Extremes

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) dateAtEndOfDay
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	components.hour = 23; // Thanks Aleksey Kononov
	components.minute = 59;
	components.second = 59;
	return [[NSDate currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
	return components.hour;
}

- (NSInteger) hour
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.hour;
}

- (NSInteger) minute
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.minute;
}

- (NSInteger) seconds
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.second;
}

- (NSInteger) day
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.day;
}

- (NSInteger) month
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.month;
}

- (NSInteger) week
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekday;
}

- (NSInteger) weekday
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) year
{
	NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
	return components.year;
}

+ (NSString *)getTimeByDate:(NSDate *)date byProgress:(float)current {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (current / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    return [formatter stringFromDate:date];
}

+(NSString *)getTimeDistance:(NSTimeInterval)targetDateWithTimeInterval{
    NSDate *nowDate = [NSDate date];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:targetDateWithTimeInterval];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ) fromDate:nowDate toDate:targetDate options:0];
    NSString * hourString = @"";
    NSString * miniString = @"";
    NSString * secString = @"";
    NSString * dayString = @"";
    
    // 【天】
    if ([components day] != 0){
        if ([components day] < 10){
            dayString = [NSString stringWithFormat:@"0%li",(long)[components day]];
        } else {
            dayString = [NSString stringWithFormat:@"%li",(long)[components day]];
        }
    } else {
        dayString = @"";
    }
    // 【小时】
    if ([components hour] != 0){        //  小时 = 0
        if ([components hour] < 10){
            hourString = [NSString stringWithFormat:@"0%li",(long)[components hour]];
        } else {
            hourString = [NSString stringWithFormat:@"%li",(long)[components hour]];
        }
    } else {
        hourString = @"00";
    }
    // 【分钟】
    if ([components minute] != 0){
        if ([components minute] < 10){
             miniString = [NSString stringWithFormat:@"0%li",(long)[components minute]];
        } else {
            miniString = [NSString stringWithFormat:@"%li",(long)[components minute]];
        }
    } else {
         miniString = @"00";
    }
    // 【秒】
    if ([components second] != 0){
        if ([components second] < 10){
            secString = [NSString stringWithFormat:@"0%li",(long)[components second]];
        } else {
            secString = [NSString stringWithFormat:@"%li",(long)[components second]];
        }
    } else {
        secString = @"00";
    }
    
    // 【毫秒】
    
    if (([components day] <= 0) && ([components hour] <= 0) && ([components minute] <= 0) && ([components second] <= 0)){
        return @"已揭晓";
    }
    
    if (dayString.length){              // 有天
        return [NSString stringWithFormat:@"%@天%@小时%@分%@秒",dayString,hourString,miniString,secString];
    }
    
    return [NSString stringWithFormat:@"%@:%@:%@",hourString,miniString,secString];
}

+(NSTimeInterval)getNSTimeIntervalWithCurrent{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    return a;
}

#pragma mark-- 转化时间为相应格式
+ (NSString *)getTimeGap:(NSTimeInterval)updateTime{
    NSDate *nowDate = [NSDate date];
    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:updateTime];

    BOOL isToday = [confromTime isToday];
    BOOL isYesDay = [confromTime isYesterday];

    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear )
                                                        fromDate:confromTime
                                                          toDate:nowDate
                                                         options:0];
    NSString *totalCalendarString = @"";
    NSString *miniString = @"";
    NSString *hourString = @"";
    if (isToday) {
        if ([components hour] == 0) {
            if ([components minute] == 0) {
                miniString = @"刚刚";
            }else{
                miniString = [NSString stringWithFormat:@"%ld分钟前",(long)[components minute]];
            }
            totalCalendarString = @"刚刚";
        }else{
            hourString = [NSString stringWithFormat:@"%ld小时前",(long)[components hour]];
            totalCalendarString = @"今天";
        }
        totalCalendarString = [NSString stringWithFormat:@"%@%@",hourString,miniString];
    }else if (isYesDay){
        totalCalendarString = @"昨天";
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter  setDateFormat:@"MM月dd日"];
        totalCalendarString = [dateFormatter stringFromDate:confromTime];
    }
    return totalCalendarString;
}


#pragma mark-- 转化时间为相应格式
+ (NSString *)getTimeGapWithTime:(NSDate *)confromTime{
    NSDate *nowDate = [NSDate date];
    
    BOOL isToday = [confromTime isToday];
    BOOL isYesDay = [confromTime isYesterday];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear )
                                                        fromDate:confromTime
                                                          toDate:nowDate
                                                         options:0];
    NSString *totalCalendarString = @"";
    NSString *miniString = @"";
    NSString *hourString = @"";
    if (isToday) {
        if ([components hour] == 0) {
            if ([components minute] == 0) {
                miniString = @"刚刚";
            }else{
                miniString = [NSString stringWithFormat:@"%ld分钟前",(long)[components minute]];
            }
            totalCalendarString = @"刚刚";
        }else{
            hourString = [NSString stringWithFormat:@"%ld小时前",(long)[components hour]];
            totalCalendarString = @"今天";
        }
        totalCalendarString = [NSString stringWithFormat:@"%@%@",hourString,miniString];
    }else if (isYesDay){
        totalCalendarString = @"昨天";
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter  setDateFormat:@"MM月dd日"];
        totalCalendarString = [dateFormatter stringFromDate:confromTime];
    }
    return totalCalendarString;
}




+(NSString *)gamePass:(NSTimeInterval)time{
//    NSDate *nowDate = [NSDate date];
//    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:time];
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ) fromDate:confromTime toDate:nowDate options:0];
    NSString *youxiPass = @"";
    //    youxiPass = [NSString stringWithFormat:@"游戏已进行%li分%li秒",(long)[components minute],(long)[components second]];
    youxiPass = @"战斗结束";
    return youxiPass;
}


+(NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

+(NSString *)getOSSFileURL{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMM/dd"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}


+(NSString *)getCurrentTimeWithFileName{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}



+(NSString *)getCurrentTimeWithDay{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

+(NSString *)getTimeWithString:(NSTimeInterval)time{
    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString = [formatter stringFromDate:confromTime];
    return dateString;
}

+(NSString *)getTimeWithDuobaoString:(NSTimeInterval)time{
    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:confromTime];
    return dateString;
}

+(NSString *)getCurrentTimeWithMoon{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"M"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

+(NSString *)getTimeWithLotteryString:(NSTimeInterval)time{
    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:confromTime];
    return dateString;
}

+(NSString *)getLotteryListString:(NSTimeInterval)time{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    
    return [NSString stringWithFormat:@"%@ %@",dateString,weekStr];
}




+(NSString *)getLotteryTimeDistance:(NSTimeInterval)targetDateWithTimeInterval{
    NSDate *nowDate = [NSDate date];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:targetDateWithTimeInterval];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ) fromDate:nowDate toDate:targetDate options:0];
    NSString * hourString = @"";
    NSString * miniString = @"";
    NSString * secString = @"";
    NSString * dayString = @"";
    
    // 【天】
    if ([components day] != 0){
        if ([components day] < 10){
            dayString = [NSString stringWithFormat:@"0%li",(long)[components day]];
        } else {
            dayString = [NSString stringWithFormat:@"%li",(long)[components day]];
        }
    } else {
        dayString = @"";
    }
    // 【小时】
    if ([components hour] != 0){        //  小时 = 0
        if ([components hour] < 10){
            hourString = [NSString stringWithFormat:@"0%li",(long)[components hour]];
        } else {
            hourString = [NSString stringWithFormat:@"%li",(long)[components hour]];
        }
    } else {
        hourString = @"00";
    }
    // 【分钟】
    if ([components minute] != 0){
        if ([components minute] < 10){
            miniString = [NSString stringWithFormat:@"0%li",(long)[components minute]];
        } else {
            miniString = [NSString stringWithFormat:@"%li",(long)[components minute]];
        }
    } else {
        miniString = @"00";
    }
    // 【秒】
    if ([components second] != 0){
        if ([components second] < 10){
            secString = [NSString stringWithFormat:@"0%li",(long)[components second]];
        } else {
            secString = [NSString stringWithFormat:@"%li",(long)[components second]];
        }
    } else {
        secString = @"00";
    }
    
    if (dayString.length){              // 有天
//        hourString = [NSString stringWithFormat:@"%li",(long)[components hour] + ([components day] * 24)];
        return [NSString stringWithFormat:@"%@天%@:%@:%@",dayString,hourString,miniString,secString];
    } else {
        hourString = [NSString stringWithFormat:@"%li",(long)[components hour] + ([components day] * 24)];
        
        if (([components day] <= 0) && ([components hour] <= 0) && ([components minute] <= 0) && ([components second] <= 0)){
            return @"比赛中";
        } else {
            return [NSString stringWithFormat:@"%@:%@:%@",hourString,miniString,secString];
        }
        
        return [NSString stringWithFormat:@"%@:%@:%@",hourString,miniString,secString];
    }

}

#pragma mark - 绝地求生倒计时

+(NSString *)getJuediLotteryTargetTime:(NSTimeInterval)targetTime{
    NSDate *nowDate = [NSDate date];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:targetTime];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ) fromDate:nowDate toDate:targetDate options:0];
    NSString * hourString = @"";
    NSString * miniString = @"";
    NSString * secString = @"";
    NSString * dayString = @"";
    
    // 【天】
    if ([components day] != 0){
        if ([components day] < 10){
            dayString = [NSString stringWithFormat:@"0%li",(long)[components day]];
        } else {
            dayString = [NSString stringWithFormat:@"%li",(long)[components day]];
        }
    } else {
        dayString = @"";
    }
    // 【小时】
    if ([components hour] != 0){        //  小时 = 0
        if ([components hour] < 10){
            hourString = [NSString stringWithFormat:@"0%li",(long)[components hour]];
        } else {
            hourString = [NSString stringWithFormat:@"%li",(long)[components hour]];
        }
    } else {
        hourString = @"00";
    }
    // 【分钟】
    if ([components minute] != 0){
        if ([components minute] < 10){
            miniString = [NSString stringWithFormat:@"0%li",(long)[components minute]];
        } else {
            miniString = [NSString stringWithFormat:@"%li",(long)[components minute]];
        }
    } else {
        miniString = @"00";
    }
    // 【秒】
    if ([components second] != 0){
        if ([components second] < 10){
            secString = [NSString stringWithFormat:@"0%li",(long)[components second]];
        } else {
            secString = [NSString stringWithFormat:@"%li",(long)[components second]];
        }
    } else {
        secString = @"00";
    }
    
    if (dayString.length){              // 有天
        return [NSString stringWithFormat:@"%@天%@:%@:%@",dayString,hourString,miniString,secString];
    } else {
        hourString = [NSString stringWithFormat:@"%li",(long)[components hour] + ([components day] * 24)];
        
        if (([components day] <= 0) && ([components hour] <= 0) && ([components minute] <= 0) && ([components second] <= 0)){
            return @"战斗中";
        } else {
            return [NSString stringWithFormat:@"%@:%@:%@",hourString,miniString,secString];
        }
        return [NSString stringWithFormat:@"%@:%@:%@",hourString,miniString,secString];
    }
}

#pragma mark 获取目标时间
+ (NSTimeInterval)getTargetDateTimeWithTimeInterval:(NSTimeInterval)time{
    NSDate *nowDate = [NSDate date];                                // 当前时间
    NSDate *targetDate = [nowDate dateByAddingTimeInterval:time];   // 目标时间
    NSTimeInterval targetDateWithTimeInterval = [targetDate timeIntervalSince1970];
    return targetDateWithTimeInterval;
}


#pragma mark 计算倒计时时间
+ (NSString *)getCountdownWithTargetDate:(NSTimeInterval)targetDateWithTimeInterval{
    NSDate *nowDate = [NSDate date];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:targetDateWithTimeInterval];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components: (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear )
                                                        fromDate:nowDate
                                                          toDate:targetDate
                                                         options:0];
    
    NSString * miniString = [NSString stringWithFormat:@"%ld",(long)[components minute]];
    NSString * secString = [NSString stringWithFormat:@"%ld",(long)[components second]];
    
    return [NSString stringWithFormat:@"战斗中(%@:%@)",miniString,secString];
}

@end
