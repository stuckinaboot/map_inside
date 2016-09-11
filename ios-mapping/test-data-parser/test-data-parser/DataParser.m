//
//  DataParser.m
//  test-data-parser
//
//  Created by Andrew Fischer on 9/10/16.
//  Copyright © 2016 Andrew Fischer. All rights reserved.
//

#import "DataParser.h"

@implementation DataParser

// Eventually will have to get bluetooth stream.
+ (NSArray *)rawDataFromFile {
    NSError *error;
    NSString *fileStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource: @"samplePing" ofType: @"txt"] encoding:NSUTF8StringEncoding error:&error];
    if(error) {  //Handle error
        NSLog(@"%@", error);
    }
    
    NSArray *lines = [fileStr componentsSeparatedByString:@"\n"];
    NSMutableArray *toModify = [lines mutableCopy];
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    
    // Strip comments
    for (NSString *line in toModify) {
        // Strip comments
        NSString *noComments = [[line componentsSeparatedByString:@"#"] objectAtIndex:0];
        
        if (noComments.length > 0) {
            // Tuples from raw text values
            NSString *lVal = [[noComments componentsSeparatedByString:@","] objectAtIndex:0];
            lVal = [[lVal componentsSeparatedByString:@": "] objectAtIndex:1];
            NSString *rVal = [[noComments componentsSeparatedByString:@","] objectAtIndex:1];
            rVal = [[rVal componentsSeparatedByString:@": "] objectAtIndex:1];
            NSString *fVal = [[noComments componentsSeparatedByString:@","] objectAtIndex:2];
            fVal = [[fVal componentsSeparatedByString:@": "] objectAtIndex:1];
            NSString *time = [[noComments componentsSeparatedByString:@","] objectAtIndex:3];
            time = [[time componentsSeparatedByString:@": "] objectAtIndex:1];
            
            NSString *vals = [NSString stringWithFormat:@"%@,%@,%@,%@", lVal, rVal, fVal, time];
            
            // Trim whitespace if it is a thing
            [parsedItems addObject:[vals stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]]];
        }
    }
    
    NSLog(@"%@", parsedItems);
    return parsedItems;
}

@end
