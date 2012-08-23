//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 22/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[self navigationItem] setTitle : @"Contatos"];
        
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
            target:self action:@selector(exibeFormulario)];
        [[self navigationItem] setRightBarButtonItem: botaoExibirFormulario];
        
    }
    return self;
}

-(void) exibeFormulario{
    NSLog(@"Aqui vamos exibir o formulario");
    
//    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle: @"Alerta" 
//                                                     message:@"Inicio da aplicacao" 
//                                                    delegate:self 
//                                           cancelButtonTitle:@"OK" 
//                                           otherButtonTitles:@"Cancel", nil];
//    
//    [alerta show];
    
    
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] init];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:form];

    [self presentModalViewController:navigation animated:YES];
    
    
}

@end
