## Copyright:   Public domain.
## Filename:    SYSTEM_TEST_STANDARD_LEAD_INS.agc
## Purpose:     The main source file for Luminary revision 069.
##              It is part of the source code for the original release 
##              of the source code for the Lunar Module's (LM) Apollo 
##              Guidance Computer (AGC) for Apollo 10. The actual flown 
##              version was Luminary 69 revision 2, which included a 
##              newer lunar gravity model and only affected module 2.
##              This file is intended to be a faithful transcription, except
##              that the code format has been changed to conform to the
##              requirements of the yaYUL assembler rather than the
##              original YUL assembler.
## Reference:   pp. 383-385
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2016-12-13 MAS  Created from Luminary 99.
##              2016-12-14 MAS  Updated from comment-proofed Luminary 99 version.

## NOTE: Page numbers below have not yet been updated to reflect Luminary 69.

## Page 370
		EBANK=	XSM
		
		BANK	33
		SETLOC	E/PROG
		BANK
		
		COUNT*	$$/P07
		
# SPECIAL PROGRAMS TO EASE THE PANGS OF ERASABLE MEMORY PROGRAMS.
#
# E/BKCALL	FOR DOING BANKCALLS FROM AND RETURNING TO ERASABLE.
#
# THIS ROUTINE IS CALLABLE FROM ERASABLE OR FIXED.  LIKE BANKCALL, HOWEVER, SWITCHING BETWEEN S3 AND S4
# IS NOT POSSIBLE.
#
# THE CALLING SEQUENCE IS:
#
#	TC	BANKCALL
#	CADR	E/BKCALL
#	CADR	ROUTINE		WHERE YOU WANT TO GO IN FIXED.
#	RETURN HERE FROM DISPLAY TERMINATE, BAD STALL OR TC Q.
#	RETURN HERE FROM DISPLAY PROCEED OR GOOD RETURN FROM STALL.
#	RETURN HERE FROM DISPLAY ENTER OR RECYCLE.
#
# THIS ROUTINE REQUIRES TWO ERASABLES (EBUF2, +1) IN UNSWITCHED WHICH ARE UNSHARED BY INTERRUPTS AND
# OTHER EMEMORY PROGRAMS.
#
# A + L ARE PRESERVED THROUGH BANKCALL AND E/BKCALL.

E/BKCALL	DXCH	BUF2		# SAVE A,L AND GET DP RETURN.
		DXCH	EBUF2		# SAVE DP RETURN.
		INCR	EBUF2		# RETURN +1 BECAUSE DOUBLE CADR.
		CA	BBANK
		MASK	LOW10		# GET CURRENT EBANK.  (SBANK SOMEDAY)
		ADS	EBUF2	+1	# FORM BBCON.  (WAS FBANK)
		NDX	EBUF2
		CA	0 	-1	# GET CADR OF ROUTINE.
		TC	SWCALL		# GO TO ROUTINE, SETTING Q TO SWRETURN
					# AND RESTORING A + L.
		TC	+4		# TX Q, V34, OR BAD STALL RETURN.
		TC	+2		# PROCEED OR GOOD STALL RETURN.
		INCR	EBUF2		# ENTER OR RECYCLE RETURN.
		INCR	EBUF2
E/SWITCH	DXCH	EBUF2
		DTCB
		
## Page 371
# E/CALL	FOR CALLING A FIXED MEMORY INTERPRETIVE SUBROUTINE FROM ERASABLE AND RETURNING TO ERASABLE.
#
# THE CALLING SEQUENCE IS...
#
#	RTB
#		E/CALL
#	CADR	ROUTINE			THE INTERPRETIVE SUBROUTINE YOU WANT.
#					RETURNS HERE IN INTERPRETIVE.
	
E/CALL		LXCH	LOC		# ADRES -1 OF CADR.
		INDEX	L
		CA	L		# CADR IN A.
		INCR	L
		INCR	L		# RETURN ADRES IN L.
		DXCH	EBUF2		# STORE CADR AND RETURN.
		TC	INTPRET
		CALL
			EBUF2		# INDIRECTLY EXECUTE ROUTING.  IT MUST
		EXIT			# LEAVE VIA RVQ OR EQUIVALENT.
		LXCH	EBUF2 	+1	# PICK UP RETURN.
		TCF	INTPRET +2	# SET LOC AND RETURN TO CALLER.
		
## Page 372
# E/JOBWAK	FOR WAKING UP ERASABLE MEMORY JOBS.
#
# THIS ROUTINE MUST BE CALLED IN INTERRUPT OR WITH INTERRUPTS INHIBITED.
#
# THE CALLING SEQUENCE IS:
#
#	INHINT
#	  .
#         .
#	CA	WAKEADR		ADDRESS OF SLEEPING JOB
#	TC	IBNKCALL
#	CADR	E/JOBWAK
#	  .			RETURNS HERE
#	  .
#	  .
#	RELINT			IF YOU DID AN INHINT.

		BANK	33
		SETLOC	E/PROG
		BANK
		
		COUNT*	 $$/P07
		
E/JOBWAK	TC	JOBWAKE		# ARRIVE IWTH ADRES IN A.
		CS	BIT11
		NDX	LOCCTR
		ADS	LOC		# KNOCK FIXED MEMORY BIT OUT OF ADRES.
		TC	RUPTREG3	# RETURN
		
