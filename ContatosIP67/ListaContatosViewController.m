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
        
        //Exibindo o botao para deletar no lado direito
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
            target:self action:@selector(exibeFormulario)];
        
        [[self navigationItem] setRightBarButtonItem: botaoExibirFormulario];
        
    }
    return self;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] initWithContato:contato];
    form.delegate = self;
    form.contatos = self.contatos;
        
    [self.navigationController pushViewController:form animated:YES];
    
    NSLog(@"Nome: %@", contato.nome);
}

//Editar e remover a linha do registro (Path - Section x Row)
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatos removeObjectAtIndex:indexPath.row];
        
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
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
    form.delegate  = self;
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:form];

    [self presentModalViewController:navigation animated:YES];
    
}

-(void) contatoAtualizado:(Contato *)contato {
    NSLog(@"atualizado: %d", [self.contatos indexOfObject:contato]);
}

-(void) contatoAdicionado:(Contato *)contato {
    NSLog(@"adicionado: %d", [self.contatos indexOfObject:contato]);
}


@end
