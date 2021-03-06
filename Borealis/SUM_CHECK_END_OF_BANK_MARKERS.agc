### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    AGC_BLOCK_TWO_SELF-CHECK.agc
## Purpose:     This program is designed to extensively test the Apollo Guidance Computer
##              (specifically the LM instantiation of it). It is built on top of a heavily
##              stripped-down Aurora 12, with all code ostensibly added by the DAP Group
##              removed. Instead Borealis expands upon the tests provided by Aurora,
##              including corrected tests from Retread 44 and tests from Ron Burkey's
##              Validation.
## Assembler:   yaYUL
## Contact:     Mike Stewart <mastewar1@gmail.com>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2016-12-20 MAS  Created from Aurora 12 (with much DAP stuff removed).
## Mod history: 2016-12-21 MAS  Updated for new end-of-bank locations for self-tests.

                SETLOC  ENDRTRDF
                TC
                TC
                
                SETLOC  ENDINTF
                TC
                TC
                
                SETLOC  ENDINTS0
                TC
                TC
                
                SETLOC  ENDSLFS2
                TC
                TC
                
                SETLOC  ENDPINS1
                TC
                TC
                
                SETLOC  ENDPINS2
                TC
                TC
                
                BANK    06
                TC
                TC
                
                BANK    07
                TC
                TC
                
                SETLOC  ENDRTSTS
                TC
                TC
                
                SETLOC  ENDEXTVS
                TC
                TC
                
                BANK    12
                TC
                TC
                
                SETLOC  ENDAMODS
                TC
                TC
                
                SETLOC  ENDIMUS1
                TC
                TC
                
                SETLOC  ENDRTBSS
                TC
                TC
                
                SETLOC  ENDIMUS3
                TC
                TC
                
                SETLOC  ENDIMUS2
                TC
                TC
                
                SETLOC  ENDSLFS1
                TC
                TC
                
                SETLOC  ENDPREL1
                TC
                TC

                SETLOC  ENDINST1
                TC
                TC

                SETLOC  ENDINST2
                TC
                TC
