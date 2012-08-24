//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 22/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"
#import "Contato.h"

@implementation ListaContatosViewController

@synthesize contatos; 

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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;   
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self contatos] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *cellIdentifier = @"Cell"; //@"CellStyleDefault";
    static NSString *cellIdentifier = @"CellStyleSubtitle";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
//        cell = [[UITableViewCell alloc]
//        initWithStyle:UITableViewCellStyleDefault
//        reuseIdentifier:cellIdentifier];
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellIdentifier];
        
    }
    
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    NSLog(@"Contato: %@", contato);
    
    //[[cell textLabel] setText:[contato nome]];
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.email;
    
    return cell;
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"Total cadastrado: %d", [self.contatos count]);
    
    [self.tableView reloadData];
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
    form.contatos = self.contatos;
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:form];

    [self presentModalViewController:navigation animated:YES];
    
    
}


@end
