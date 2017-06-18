(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT TestBase58;

{$mode objfpc}{$H+}

INTERFACE

USES
        sysutils, fpcunit, testutils, base58;

TYPE
        TTestBase58 = CLASS(TTestCase)
        PUBLISHED
                PROCEDURE TestEncode;
		PROCEDURE TestEncodeNullByte;
        END;

IMPLEMENTATION

PROCEDURE TTestBase58.TestEncode;
VAR
        data: pchar;
BEGIN
        data := '00000000000000000000000000000000';
        AssertEquals('4F7BsTMVPKFshM1MwLf6y23cid6fL3xMpazVoF9krzUw', Base58Encode(data));
END;

PROCEDURE TTestBase58.TestEncodeNullByte;
VAR
	data: pchar;
	i: integer;
BEGIN
	data := StrAlloc(32);
	FOR i := 0 TO 32 DO
		data[i] := #0;
	AssertEquals('11111111111111111111111111111111', Base58Encode(data));
	StrDispose(data);
END;

END.
