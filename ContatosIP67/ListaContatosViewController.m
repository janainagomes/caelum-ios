//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 22/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Twitter/TWTweetComposeViewController.h>

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"
#import "Contato.h"
#import "SiteDoContatoViewController.h"

@implementation ListaContatosViewController

@synthesize contatos; 

- (id)init
{
    self = [super init];
    if (self) {
        
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
            target:self action:@selector(exibeFormulario)];
        
        [[self navigationItem] setRightBarButtonItem: botaoExibirFormulario];
        
        
        //Adicionando a imagem nos UITabBarItem
        UIImage *imagemTabItem = [UIImage imageNamed: @"lista-contatos.png"];
        
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:imagemTabItem tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Contatos";
        //Exibindo o botao para deletar no lado direito
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
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
    [self.contatos addObject:contato];
    NSLog(@"adicionado: %d", [self.contatos indexOfObject:contato]);
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc] 
                                              initWithTarget:self 
                                              action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:longPress];
}

-(void) exibeMaisAcoes:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        Contato *contato = [contatos objectAtIndex:index.row];
        
        contatoSelecionado = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar site", @"Abrir Mapas", @"Twitter", nil];
        
        //[opcoes showInView:self.view];
        
        [opcoes showFromTabBar:self.tabBarController.tabBar];
        
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        case 4:
            [self enviarTwitter];
            
        default:
            break;
    }
    contatoSelecionado = nil;
}

-(void) ligar{
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        NSString *numero = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        
        [self  abrirAplicativoComURL:numero];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligacao" message:@"Seu dispositivo nao e um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void) abrirAplicativoComURL:(NSString *) url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void) enviarEmail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc] init];
        enviadorEmail.mailComposeDelegate = self;
        
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [enviadorEmail setSubject:@"Caelum"];
        [self presentModalViewController:enviadorEmail animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops" message:@"Voce nao pode enviar emails. Sem conexao." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *) controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];    
}

-(void) abrirSite{
    //NSString *url = contatoSelecionado.site;
    //[self abrirAplicativoComURL:url];
    
    SiteDoContatoViewController *siteView = [SiteDoContatoViewController new];
    [siteView setContato:contatoSelecionado];
    [self.navigationController pushViewController:siteView animated:YES];
    
}

-(void) mostrarMapa{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco]
                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:url];
}

- (void) enviarTwitter {
    NSLog(@"Twitter: %@", contatoSelecionado.twitter);
    TWTweetComposeViewController *enviadorDeTwitter = [[TWTweetComposeViewController alloc] init];
    [enviadorDeTwitter setInitialText:contatoSelecionado.twitter];
    [self presentModalViewController:enviadorDeTwitter animated:YES];
}

@end
