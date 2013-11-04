//
//  GetHTMLTextOfClipboard.m
//  GetHTMLTextOfClipboard



#import "GetHTMLTextOfClipboard.h"

@implementation GetHTMLTextOfClipboard

- (BOOL)ignoresInput
{
    return YES;
}

- (void)doRunWithInput:(id)input
{
	NSPasteboard* pb=[NSPasteboard generalPasteboard];
    
    //Chrome, Firefox
    NSString* string=[pb stringForType:@"public.html"];
    if (!string) {
        //Safari
        if ([[pb availableTypeFromArray:@[@"com.apple.webarchive"]]isEqualToString:@"com.apple.webarchive"]) {
            NSData* data=[pb dataForType:@"com.apple.webarchive"];
            WebArchive* archive=[[WebArchive alloc]initWithData:data];
            WebResource* res=[archive mainResource];
            NSData* content=[res data];
            string=[[NSString alloc]initWithData:content encoding:NSUTF8StringEncoding];
        }
    }
    
    [self setOutput:string];
    [self finishRunningWithError:nil];
    
}

- (void)runAsynchronouslyWithInput:(id)input
{
    [self performSelectorOnMainThread:@selector(doRunWithInput:) withObject:input waitUntilDone:NO];

}
@end
