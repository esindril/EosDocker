#! /bin/bash

eos -b space quota default off
eos -b space set default on
eos -b vid enable sss
eos -b vid enable unix
eos -b fs boot \*
eos -b config save -f default
