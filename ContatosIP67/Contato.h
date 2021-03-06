//
//  Contato.h
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

//@interface Contato : NSObject<NSCoding, MKAnnotation>
@interface Contato : NSManagedObject<MKAnnotation>

//@property (nonatomic, strong) NSString *nome;

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
@property (strong) NSString *twitter;
@property (strong) UIImage *foto;

@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;

- (NSString *)description;
//- (void)encodeWithCoder:(NSCoder *)aCoder;
//- (id)initWithCoder:(NSCoder *)aDecoder;



//-(void) setNome:(NSString *)nome;
//-(void) setTelefone:(NSString *)telefone;
//-(void) setEmail:(NSString *)email;
//-(void) setEndereco:(NSString *)endereco;
//-(void) setSite:(NSString *)site;

@end