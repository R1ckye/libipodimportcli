//
//  main.m
//  libipodimportcli
//
//  Created by Richard Murvai (Rickye) on 2012.09.25..
//
//  If you want to build this tool with theos, you have to repleace
//  [NSString stringWithCString: encoding: ]; with [NSString stringWithCString: ];
//

#import "ipodimport.h" //From the library

@interface AVAudioPlayer : NSObject //And you have to link to AVFountation
@property(readonly) double duration;
- (id)initWithContentsOfURL:(id)arg1 error:(id*)arg2;
@end

void usage() {
printf("Usage: libipodimportcli /path/to/song\n");
}

int main(int argc, char **argv, char **envp) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if (argc < 2) { usage(); return 0; }
    NSString *path = [NSString stringWithCString:argv[1]];
    NSURL* url = [NSURL fileURLWithPath:path];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    double dur = player.duration;
    [player release];
    char title[50];
    printf("Title: ");
    scanf("%s", title);
    char author [50];
    printf("Author: ");
    scanf("%s", author);
    char genre[50];
    printf("Genre: ");
    scanf("%s", genre);
    NSDictionary *metadata = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithCString:title encoding:NSUTF8StringEncoding], kIPIKeyTitle,
                              [NSString stringWithCString:author encoding:NSUTF8StringEncoding], kIPIKeyArtist,
                              [NSString stringWithCString:genre encoding:NSUTF8StringEncoding], kIPIKeyGenre,
                              [NSNumber numberWithInt:dur * 1000], kIPIKeyDuration,
                              [NSNumber numberWithInt:2012], kIPIKeyYear,
                              nil];
    [[IPIPodImporter sharedInstance] importFileAtPath:path withMetadata:metadata];
    [pool release];
    return 0;
}
