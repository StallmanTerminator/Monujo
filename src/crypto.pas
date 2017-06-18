(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT crypto;

{$mode objfpc}{$H+}

INTERFACE

USES
	{$IF DEFINED(WINDOWS)}
	jwawincrypt,
	{$ENDIF}
        sysutils;

PROCEDURE GenerateSeed(seed: pchar);

IMPLEMENTATION

PROCEDURE GenerateSeed(seed: pchar);
{$IF DEFINED(UNIX)}
VAR
        fp: file of char;
        data: array[0..31] of char;
        i: integer;
BEGIN
        (* https://www.2uo.de/myths-about-urandom/ *)
        AssignFile(fp, '/dev/urandom');
        reset(fp);
        blockread(fp, data, 32);
        FOR i := 0 TO 31 DO
                seed[i] := data[i];
        CloseFile(fp);
{$ELSEIF DEFINED(WINDOWS)}
VAR
	provider: HCRYPTPROV;
BEGIN
	CryptAcquireContext(provider, NIL, NIL, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT | CRYPT_SILENT);
	CryptGenRandom(provider, 32, @seed[0]);
	CryptReleaseContext(provider, 0);
{$ENDIF}
END;

END.
