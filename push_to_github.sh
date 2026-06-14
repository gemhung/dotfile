#!/bin/bash
git -c core.sshCommand='ssh -i ~/.ssh/id_ed25519_personal -o IdentitiesOnly=yes' push origin HEAD:main

