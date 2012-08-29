//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FormularioContatoViewController.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"

@implementation AppDelegate

@synthesize window = _window, contatos, arquivoContatos;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    //Salvar arquivo com contatos
    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [userDirs objectAtIndex:0];
    
    self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos", documentDir];
    
    //Recuperar dados do arquivo
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
    if(!self.contatos){
        self.contatos = [[NSMutableArray alloc] init];
    }
    
    ListaContatosViewController *lista = [[ListaContatosViewController alloc] init];
    lista.contatos = self.contatos;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lista];
    
    ContatosNoMapaViewController *contatosMapa = [[ContatosNoMapaViewController alloc] init];
    
    //Criando os contatos no mapa
    UINavigationController *mapaNavigation = [[UINavigationController alloc] initWithRootViewController:contatosMapa];    
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:nav, mapaNavigation, nil];
    
    //---
    
    //Inicializando a lista de contatos
    //self.contatos = [[NSMutableArray alloc] init ];
    
    //Inicializando o formulario como principal
    //FormularioContatoViewController *formulario = [[FormularioContatoViewController alloc] init];
    //self.window.rootViewController = formulario;
    
    //self.window.rootViewController = lista;
    //[[self  window] setRootViewController : lista];

    
    // Override point for customization after application launch.
    //
    
    
    
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    sleep(3);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //Implementando para salvar arquivos
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
