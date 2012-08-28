//
//  Contato.h
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject<NSCoding>

//@property (nonatomic, strong) NSString *nome;

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
@property (strong) NSString *twitter;

- (NSString *)description;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

//-(void) setNome:(NSString *)nome;
//-(void) setTelefone:(NSString *)telefone;
//-(void) setEmail:(NSString *)email;
//-(void) setEndereco:(NSString *)endereco;
//-(void) setSite:(NSString *)site;

@end