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

//Implementacao do coredata
@synthesize contexto = _contexto;

-(NSURL *)  applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

}

- (NSManagedObjectModel *) manegedObjectModel{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model_Contatos" withExtension:@"momd"];
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *) coordinate{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self manegedObjectModel]];
    
    NSURL *pastaDocuments = [self applicationDocumentsDirectory];
    NSURL *localBancoDados = [pastaDocuments URLByAppendingPathComponent:@"Contatos.sqlite"];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBancoDados options:nil error:nil];
    
    return coordinator;
    
}

- (NSManagedObjectContext *) contexto{
    if(_contexto != nil){
        return _contexto;
    }
    
    NSPersistentStoreCoordinator *coordinate = [self coordinate];
    _contexto = [[NSManagedObjectContext alloc] init];
    [_contexto setPersistentStoreCoordinator:coordinate];
    return _contexto;
}

//--

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self inserirDados];
    [self buscarContatos];
    
    //Salvar arquivo com contatos
//    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentDir = [userDirs objectAtIndex:0];
//    
//    self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos", documentDir];
//    
    //Recuperar dados do arquivo
//    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
//    if(!self.contatos){
//        self.contatos = [[NSMutableArray alloc] init];
//    }
    
    ListaContatosViewController *lista = [[ListaContatosViewController alloc] init];
    lista.contatos = self.contatos;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lista];
    
    ContatosNoMapaViewController *contatosMapa = [[ContatosNoMapaViewController alloc] init];
    contatosMapa.contatos = self.contatos;
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
    //[NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
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

- (void) salvaContexto {
    NSError *error;
    if(![self.contexto save:&error]){
        NSDictionary *informacoes = [error userInfo];
        NSArray *multiplosErros = [informacoes objectForKey:NSDetailedErrorsKey];
        
        if(multiplosErros){
            for (NSError *erro in multiplosErros){
                NSLog(@"Ocorreu um problema %@", [erro userInfo]);
            }
            
        }else{
            NSLog(@"Ocorreu um problema %@", informacoes);
        }
        
    }
    
}

- (void) inserirDados{
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    if(!dadosInseridos){
        Contato *caelumRJ = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.contexto];
        
        caelumRJ.nome = @"Caelum Unidade Rio de Janeiro";
        caelumRJ.email = @"contato@caelum.com.br";
        caelumRJ.endereco = @"Rio de Janeiro, RJ, Rua Ouvidor, 50";
        caelumRJ.telefone = @"02192951351";
        caelumRJ.site = @"http://www.caelum.com.br";
        caelumRJ.latitude = [NSNumber numberWithDouble: -23.5883034];
        caelumRJ.longitude = [NSNumber numberWithDouble: -46.632369];
        
        [self salvaContexto];
        [configuracoes setBool:TRUE forKey:@"dados_inseridos"];
        [configuracoes synchronize];
        
    }
}

-(void) buscarContatos {
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    
    NSSortDescriptor *ordenaPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    [buscaContatos setSortDescriptors: [NSArray arrayWithObject:ordenaPorNome]];
    
    NSArray *contatosImutaveis = [self.contexto executeFetchRequest:buscaContatos error:nil];
    
    self.contatos = [contatosImutaveis mutableCopy];
    
}


@end
