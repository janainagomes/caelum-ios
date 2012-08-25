//
//  FormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(self.contato){
        nome.text = contato.nome;
        telefone.text = contato.telefone;
        email.text = contato.email;
        endereco.text = contato.endereco;
        site.text = contato.site;
    }
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

@synthesize nome, telefone, email, endereco, site, contato, delegate;
//
//- (IBAction) pegaDadosDoFormulario:(id)sender {
//
//    Contato *contato = [self obtemContato: (id)sender];
//    
////    NSMutableDictionary *dadosContato = [[NSMutableDictionary alloc] init];
////    [dadosContato setObject: [contato nome] forKey:@"nome" ];
////    [dadosContato setObject: [contato telefone] forKey:@"telefone" ];
////    [dadosContato setObject: [contato email] forKey:@"email" ];
////    [dadosContato setObject: [contato endereco] forKey:@"endereco" ];
////    [dadosContato setObject: [contato site] forKey:@"site" ];
////    NSLog(@"dados: %@", dadosContato);
//    
//    
//    //Desta forma acessa o metodo que sobrescreve o getter
//    [[self contatos] addObject:contato];
//    
//    //Acesso direto a propriedade
//    //[self.contatos addObject:contato];
//    
//    NSLog(@"Contatos: %@", [self contatos]);
// 
//}


-(Contato *) pegaDadosFormulario{
    
    if(!self.contato){
        contato = [[Contato alloc] init];
    }
    
    [contato setNome: [nome text]];
    [contato setTelefone: [telefone text]];
    [contato setEmail: [email text]];
    [contato setEndereco: [endereco text] ];
    [contato setSite: [site text]];
    
    //NSLog(@"contato om nome: %@", [contato nome]);
     //[site resignFirstResponder];
     
    //[[self view] endEditing: YES];
    
    return contato;
    
}



@synthesize contatos = _contatos;

-(IBAction) proximoElemento:(id)sender{
    
    if(sender == nome){
        [telefone becomeFirstResponder];
    }else if (sender == telefone){
        [email becomeFirstResponder];
    }else if (sender == email){
        [endereco becomeFirstResponder];
    }else if (sender == endereco){
        [site becomeFirstResponder];
    }else if (sender == site){
        [site resignFirstResponder];
    }    
    
    
}

//Sobrescrevendo o metodo getter
- (NSMutableArray *) contatos{
    NSLog(@"Acessou o método");
    return _contatos;
}

//Implementando a inicialização customizada
- (id)init
{
    self = [super init];
    if (self) {
        //removendo do codigo para nao zerar o array
       // self.contatos = [[NSMutableArray alloc] init];
        
        self.navigationItem.title = @"Contato";
       
        UIBarButtonItem *voltar = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(escondeFormulario)];
        
        self.navigationItem.leftBarButtonItem = voltar;
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(criaContato)];
        
        self.navigationItem.rightBarButtonItem = adiciona;
        
    }
    return self;
}

- (void) escondeFormulario {
    [self dismissModalViewControllerAnimated:YES];
}

- (void) criaContato{
    Contato *novoContato =  [self pegaDadosFormulario];
    [self.contatos addObject:novoContato];
    //NSLog(@"Contatos cadastrados: %d", [self.contatos count]);
    [self dismissModalViewControllerAnimated: YES];
    if(delegate){
        [self.delegate contatoAdicionado:novoContato];
    }
}

//Editando uma linha selecionada
-(id) initWithContato:(Contato *)_contato {
    self = [super init];
    if(self){
        self.contato = _contato;
        
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" 
                                                                      style:(UIBarButtonItemStylePlain)
                                                                     target:self 
                                                                     action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
        
    }
    return self;
}

-(void) atualizaContato {
    Contato *contatoAtualizado = [self pegaDadosFormulario];
    [self.navigationController popViewControllerAnimated:YES];
    if(delegate){
        [self.delegate contatoAtualizado:contatoAtualizado];
    }
}

@end
