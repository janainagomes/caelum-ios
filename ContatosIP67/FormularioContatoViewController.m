//
//  FormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import <CoreLocation/CoreLocation.h>


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
    
    //Criando um observer para receber mensagens
//    [[NSNotificationCenter defaultCenter] addObserver:self 
//                                             selector:@selector(tecladoApareceu:)
//                                                 name:UIKeyboardDidShowNotification 
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self 
//                                             selector:@selector(tecladoSumiu) 
//                                                 name:UIKeyboardDidHideNotification 
//                                               object:nil];
    
    if(self.contato){
        nome.text = contato.nome;
        telefone.text = contato.telefone;
        email.text = contato.email;
        endereco.text = contato.endereco;
        site.text = contato.site;
        twitter.text = contato.twitter;
        
        latitude.text = [contato.latitude stringValue];
        longitude.text = [contato.longitude stringValue];
        
        if(contato.foto){
            [botaoFoto setImage: contato.foto
                       forState:UIControlStateNormal];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self 
//                                                    name:UIKeyboardDidShowNotification 
//                                                  object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self 
//                                                    name:UIKeyboardWillHideNotification 
//                                                  object:nil];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@synthesize nome, telefone, email, endereco, site, contato, delegate, twitter, botaoFoto,  longitude, latitude, botaoLocalizacao;
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
    [contato setTwitter: [twitter text]];
    
    [contato setLatitude: [NSNumber numberWithFloat:[latitude.text floatValue]]];
    [contato setLongitude: [NSNumber numberWithFloat:[longitude.text floatValue]]];
    
    if(botaoFoto.imageView.image){
        contato.foto = botaoFoto.imageView.image;
    }
    
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
        [twitter becomeFirstResponder];
    }else if (sender == twitter){
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
    //NSLog(@"Contatos cadastrados: %d", [self.contatos count]);
    Contato *novoContato = [self pegaDadosFormulario];
    if (self.delegate) {
        [self.delegate contatoAdicionado:novoContato];   
    }
    [self dismissModalViewControllerAnimated:YES];
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
    if (self.delegate) {
        [self.delegate contatoAtualizado:contatoAtualizado];   
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        //camera disponivel
        
    }else{ //biblioteca
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
        
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoFoto  setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

-(void) tecladoApareceu:(NSNotification *) notification {
    NSLog(@"Um teclado qualquer apareceu na tela");
}

-(void) tecladoSumiu:(NSNotification *) notification {
    NSLog(@"Um teclado qualquer sumiu da tela");
}

//Mostrando mensgem do observer
//-(void) textFieldDidBeginEditing:(UITextField *) textField{
//    self.campoAtual = textField;
//}

//Mostrando mensgem do observer
//-(void) textFieldDidEndEditing:(UITextField *)textField{
//    self.campoAtual = nil;
//}


- (IBAction)buscarCoordenadas:(id)sender{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:endereco.text completionHandler:
     ^(NSArray *resultados, NSError *error) {
         if(error == nil && [resultados count] > 0){
             CLPlacemark *resultado = [resultados objectAtIndex:0];
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }
     }];
    
}

@end
