(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT TestChecksum;

{$mode objfpc}{$H+}

INTERFACE

USES
        sysutils, fpcunit, testutils, checksum;

TYPE
        TTestChecksum = CLASS(TTestCase)
        PUBLISHED
		PROCEDURE TestCalculateChecksum;
		PROCEDURE TestCheckAddressChecksum;
        END;

IMPLEMENTATION

PROCEDURE TTestChecksum.TestCalculateChecksum;
VAR
	(*
	 * J4c8CARmP9vAFNGtHRuzx14zvxojyRWHW2darguVqjtX
	 * from https://github.com/Tortue95/Duniter_Paper_Wallet/blob/master/Duniter_Auth_Protocol.md
	*)
	raw: array[0..31] of byte = ($fd, $83, $22, $90, $82, $8d, $53, $4f, $f6, $59, $4f, $cd, $e1, $96, $4f, $04, $d5, $9f, $8e, $aa, $85, $50, $d4, $20, $4a, $3b, $3f, $84, $51, $ea, $98, $94);
        pubkey: pchar;
	i: integer;
BEGIN
	pubkey := StrAlloc(32);
	FOR i := 0 TO 31 DO
		pubkey[i] := char(raw[i]);
        AssertEquals('KAv', CalculateChecksum(pubkey));
	StrDispose(pubkey);
END;

PROCEDURE TTestChecksum.TestCheckAddressChecksum;
BEGIN
	AssertTrue(CheckAddressChecksum('J4c8CARmP9vAFNGtHRuzx14zvxojyRWHW2darguVqjtX', 'KAv'));
END;

END.
