#! /usr/bin/python3.6
# -*- coding: latin-1 -*-

import json
import uuid

def ligne(texte = '', taille = 10) :
    """
       objet : tracer une ligne de longueur taille avec le motif
    """
    m = '-' * taille
    print("{}{}{}".format(m, texte, m))

def uuid_exple_1 ():
    u = uuid.uuid1()
    
    print(u)
    ligne('type')
    print(type(u))
    ligne('bytes')
    print('bytes   :', repr(u.bytes))
    print('hex     :', u.hex)
    print('int     :', u.int)
    print('urn     :', u.urn)
    print('variant :', u.variant)
    print('version :', u.version)
    print('fields  :', u.fields)
    print('  time_low             : ', u.time_low)
    print('  time_mid             : ', u.time_mid)
    print('  time_hi_version      : ', u.time_hi_version)
    print('  clock_seq_hi_variant : ', u.clock_seq_hi_variant)
    print('  clock_seq_low        : ', u.clock_seq_low)
    print('  node                 : ', u.node)
    print('  time                 : ', u.time)
    print('  clock_seq            : ', u.clock_seq)

def uuid_exple_2 (u):
    print(u)
    ligne('type')
    print(type(u))
    ligne('bytes')
    print('bytes   :', repr(u.bytes))
    print('hex     :', u.hex)
    print('int     :', u.int)
    print('urn     :', u.urn)
    print('variant :', u.variant)
    print('version :', u.version)
    print('fields  :', u.fields)
    print('  time_low             : ', u.time_low)
    print('  time_mid             : ', u.time_mid)
    print('  time_hi_version      : ', u.time_hi_version)
    print('  clock_seq_hi_variant : ', u.clock_seq_hi_variant)
    print('  clock_seq_low        : ', u.clock_seq_low)
    print('  node                 : ', u.node)
    print('  time                 : ', u.time)
    print('  clock_seq            : ', u.clock_seq)

def autre_exple () :
    namespace_types = sorted(
        n
        for n in dir(uuid)
        if n.startswith('NAMESPACE_')
    )

    name = 'www.doughellmann.com'

    for namespace_type in namespace_types:
        print(namespace_type)
        namespace_uuid = getattr(uuid, namespace_type)
        print(' ', uuid.uuid3(namespace_uuid, name))
        print(' ', uuid.uuid3(namespace_uuid, name))
        print()
    
    ligne('avec google')
    name = 'www.google.com'

    for namespace_type in namespace_types:
        print(namespace_type)
        namespace_uuid = getattr(uuid, namespace_type)
        print(' ', uuid.uuid3(namespace_uuid, name))
        print(' ', uuid.uuid3(namespace_uuid, name))
        print()

    
    ligne('avec orange')
    name = 'www.orange.fr'

    for namespace_type in namespace_types:
        print(namespace_type)
        namespace_uuid = getattr(uuid, namespace_type)
        print(' ', uuid.uuid3(namespace_uuid, name))
        print(' ', uuid.uuid3(namespace_uuid, name))
        print()

def uuid_and_json () :
    """
      a use of json and uuid
    """
    # import uuid
    # import json

    mydict = { "myuuid form 1" : str(uuid.uuid1()) }
    json.dumps(mydict) 
    print(mydict)
    print()

    mydict = { "myuuid form 4" : str(uuid.uuid4()) }
    json.dumps(mydict) 
    print(mydict)

    yuyu = uuid.uuid4()
    mydict = {'anOther uuid 4th form' : str(yuyu)}
    json.dumps(mydict)
    print(mydict)
    print('  now, the fields : ', yuyu.fields)
    uuid_exple_2(yuyu)
    

def main () :
    """
    Objet : fonction principale
    """

    # uuid_exple_1 ()

    # u = uuid.uuid1()
    # uuid_exple_2 (u)

    # ligne ('dir(uuid)')
    # print(dir(uuid))

    # ligne ('autre_exple()')
    # autre_exple ()

    ligne('uuid4, the random uuid')
    u = uuid.uuid4()
    uuid_exple_2 (u)
    print ('  and the fields : ', u.fields)

    ligne('uuid_and_json')
    uuid_and_json()

# ------
main ()
