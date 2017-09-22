#!/usr/bin/env python

from in_toto.models.layout import Layout, Step, Inspection 
import in_toto.util
import datetime

if __name__:

    # Get keys
    santiago_key = in_toto.util.import_rsa_key_from_file("santiago")
    justin_key = in_toto.util.import_rsa_key_from_file("justin")
    print("{}".format(justin_key['keyid']))

    git = Step(name="tag-webapp", 
               expected_command='git tag',
               material_matchrules=[], 
               product_matchrules=[
                         ["CREATE", "src/*"],
                         ["CREATE", "public/*"]],
              pubkeys=[santiago_key['keyid']])

    eslint = Step(name="eslint",  
                expected_command="eslint src/",
                material_matchrules=[
                    ["MATCH", "PRODUCT", "src/*", "from", "tag-webapp:"], 
                            ],
               product_matchrules=[], 
               pubkeys=[santiago_key['keyid']])

    build = Step(name="build", 
                expected_command="npm run build",
                material_matchrules=[
                           ["MATCH", "PRODUCT", "src/*", "FROM", "tag-webapp"], 
                           ["MATCH", "PRODUCT", "public/*", "FROM", "tag-webapp"]],
                        product_matchrules=[
                            ["CREATE", "build/*"]
                            ],
                        pubkeys=[santiago_key['keyid']])

    dockerize = Step(name="dockerize",
                expected_command="docker build .",
                material_matchrules=[
                            ["CREATE", "Dockerfile"],
                            ["MATCH", "*" "IN", "react-webapp", "WITH", "PRODUCTS", "IN", "build/*", "FROM", "build"],
                ],
                product_matchrules=[
                            ["CREATE", "blah"],
                            ],
                    pubkeys=[santiago_key['keyid']])

#   someinspection = Inspection(name="untar", 
#                run="tar xvf PolyPasswordHasher-0.2a0.tar.gz",
#                material_matchrules=[
#                   ],
#                product_matchrules=[
#                   ])

    expiration = (datetime.datetime.now() + datetime.timedelta(days=30)).isoformat() + "Z"
    santiago_key['keyval']['private'] = None
    l = Layout(steps=[git, eslint, dockerize],
               inspect=[],
               keys={santiago_key['keyid']:santiago_key},
               expires=expiration)

    l.sign(justin_key)
    l.dump()
