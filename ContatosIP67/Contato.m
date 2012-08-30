//
//  Contato.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@synthesize nome = _nome;
@synthesize telefone = _telefone;
@synthesize email = _email;
@synthesize endereco = _endereco;
@synthesize site = _site;
@synthesize twitter = _twitter;
@synthesize foto = _foto;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;


- (NSString*) description {
    NSString *retorno = [NSString stringWithFormat:@"Nome: %@ \n Email: %@",_nome, _email]; 
    return retorno;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_nome forKey:@"nome"];
    [aCoder encodeObject:_telefone forKey:@"telefone"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_endereco forKey:@"endereco"];
    [aCoder encodeObject:_site forKey:@"site"];
    [aCoder encodeObject:_twitter forKey:@"twitter"];
    [aCoder encodeObject:_foto forKey:@"foto"];
    [aCoder encodeObject:_latitude forKey:@"latitude"];
    [aCoder encodeObject:_longitude forKey:@"longitude"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setNome:[aDecoder decodeObjectForKey:@"nome"]];
        [self setTelefone: [aDecoder decodeObjectForKey:@"telefone"]];
        [self setEmail: [aDecoder decodeObjectForKey:@"email"]];
        [self setEndereco: [aDecoder decodeObjectForKey:@"endereco"]];
        [self setSite: [aDecoder decodeObjectForKey:@"site"]];
        [self setTwitter: [aDecoder decodeObjectForKey:@"twitter"]];
        [self setFoto: [aDecoder decodeObjectForKey:@"foto"]];
        [self setLatitude: [aDecoder decodeObjectForKey:@"latitude"]];
        [self setLongitude: [aDecoder decodeObjectForKey:@"longitude"]];
    }
    return self;
}

@end
