//
//  FormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewController.h"

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

@synthesize nome, telefone, email, endereco, site;

- (IBAction) pegaDadosDoFormulario:(id)sender {

    NSMutableDictionary *dadosContato = [[NSMutableDictionary alloc] init];
    [dadosContato setObject: [nome text] forKey:@"nome" ];
    [dadosContato setObject: [telefone text] forKey:@"telefone" ];
    [dadosContato setObject: [email text] forKey:@"email" ];
    [dadosContato setObject: [endereco text] forKey:@"endereco" ];
    [dadosContato setObject: [site text] forKey:@"site" ];
    
    NSLog(@"dados: %@", dadosContato);
    

}

- (IBAction) enviarAction: (id) sender{
	//[mensagem setText:texto.text];
	[nome resignFirstResponder];
    [telefone resignFirstResponder];
    [email resignFirstResponder];
    [endereco resignFirstResponder];
    [site resignFirstResponder];
    
}

- (IBAction) esconderTeclado: (id) sender{
	[nome resignFirstResponder];
    [telefone resignFirstResponder];
    [email resignFirstResponder];
    [endereco resignFirstResponder];
    [site resignFirstResponder];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

@end
