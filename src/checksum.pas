(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT checksum;

{$mode objfpc}{$H+}

INTERFACE

USES
        sysutils,
        base58,
        sodium;

FUNCTION CalculateChecksum(const pub_key: pchar): shortstring;
FUNCTION CheckAddressChecksum(address: string; chk: string): boolean;

IMPLEMENTATION

FUNCTION CalculateChecksum(const pub_key: pchar): shortstring;
VAR
        pass1: pchar;
        pass2: pchar;
        encoded: shortstring;
BEGIN
        result := '';
        pass1 := StrAlloc(32);
        crypto_hash_sha256(pass1, pub_key, 32);

        pass2 := StrAlloc(32);
        crypto_hash_sha256(pass2, pass1, 32);

        encoded := Base58Encode(pass2);
        result := Copy(encoded, 0, 3);
        StrDispose(pass1);
        StrDispose(pass2);
END;

FUNCTION CheckAddressChecksum(address: string; chk: string): boolean;
BEGIN
        result := False;
END;

END.
