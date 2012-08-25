//
//  FormularioContatoViewController.h
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ListaContatosProtocol.h"

@interface FormularioContatoViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *nome;
@property (nonatomic, weak) IBOutlet UITextField *telefone;
@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UITextField *endereco;
@property (nonatomic, weak) IBOutlet UITextField *site;

@property (strong, nonatomic) NSMutableArray *contatos;

@property (strong) Contato *contato;

@property (weak) id<ListaContatosProtocol> delegate;

-(id) initWithContato:(Contato *)contato;

@end
