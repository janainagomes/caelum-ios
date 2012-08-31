//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <MapKit/MKUserTrackingBarButtonItem.h>

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

@synthesize mapa, contatos;

-(id) init{
    self = [super init];
    if(self){
        UIImage *imagemTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" 
                                                              image:imagemTabItem 
                                                                tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Localizacao";
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
    
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) viewWillAppear:(BOOL)animated{
    [self.mapa addAnnotations:contatos];
}

-(void) viewWillDisappear:(BOOL)animated{
    [self.mapa removeAnnotations:contatos];
}

@end
