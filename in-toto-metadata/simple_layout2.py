#!/usr/bin/env python

from in_toto.models.layout import Layout, Step, Inspection 
import in_toto.util
import json
import datetime

if __name__:

    # Get keys
    santiago_key = in_toto.util.import_rsa_key_from_file("santiago.pub")
    justin_key = in_toto.util.import_rsa_key_from_file("justin")

    with open("root.layout") as fp:
        info = json.load(fp)

    l = Layout.read(info)
    l.sign(justin_key)
    l.dump()
